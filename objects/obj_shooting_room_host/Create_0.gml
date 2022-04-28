host = noone;
clients = [];
players = [];
has_menu_appeared = false;
winning_player = noone;
has_match_ended = false;
has_bipped = false;
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
font = fnt_mono;
font_countdown = fnt_mono_big;
font_height = font_get_size(font);
countdown = 1;
countdown_scale = 0;
countdown_growth_speed = .1;
countdown_fps_stopped = 45;
current_countdown_fps_stopped = 0;
has_begun = false;
particles = [];
sounds = [];
guns_to_remove = [];

function disconnect_client(_client_socket) {
	for (var i = 0; i < array_length(global.host.client_sockets); i++)
		if (global.host.client_sockets[i] == _client_socket)
			array_delete(global.host.client_sockets, i, 1);
	
	for (var i = 0; i < array_length(global.game_state.players); i++)
		if (global.game_state.players[i].socket == _client_socket)
			array_delete(global.game_state.players, i, 1);
	
	network_destroy(_client_socket);
	
	if (array_length(global.host.client_sockets) > 0)
		global.host.send_packet_to_clients(NETWORK_EVENT.SET_PLAYERS, {
			players: global.game_state.players
		});
	else if (instance_exists(obj_menu_simple))
		obj_menu_simple.options.back_to_main_menu.on_selected(instance_id);
}

function is_input_enabled(_player) {
	return !_player.is_dead && !has_match_ended && has_begun;
}

function get_player_state(_player) {
	return {
		x: _player.x,
		y: _player.y,
		image_xscale: _player.image_xscale,
		is_dead: _player.is_dead,
		is_aiming: _player.is_aiming,
		is_reloading: _player.is_reloading,
		has_gun: _player.has_gun,
		bullets_count: _player.bullets_count,
		socket: _player.socket,
		animation: {
			sprite_index: _player.sprite_index,
			image_index: _player.image_index
		},
		aiming_instance: _player.aiming_instance == noone ? noone : {
			angle: _player.aiming_instance.image_angle,
			aiming: _player.aiming_instance.aiming,
			x: _player.aiming_instance.x,
			y: _player.aiming_instance.y,
		},
		cartridge: _player.cartridge == noone ? noone : {
			shake_params: _player.cartridge.shake_params,
			angle: _player.cartridge.angle,
			image_index: _player.cartridge.image_index
		}
	}
}

function get_players_states() {
	var _states = [get_player_state(host)];

	for (var i = 0; i < array_length(clients); i++)
		array_push(_states, get_player_state(clients[i]));
	
	return _states;
}

function update_host() {
	if (host.has_fallen_dead)
		return;

	if (!host.is_aiming && !host.is_reloading 
		&& host.sprite_index != host.sprites_indexes.draw_gun)
		host.update_movement();
	
	if (!self.is_input_enabled(host))
		return;

	if (host.has_gun && host.input.is_reload_pressed() 
		&& !host.is_reloading && host.bullets_count < host.cartridge_capacity
		&& host.sprite_index != host.sprites_indexes.draw_gun
		&& host.sprite_index != host.sprites_indexes.air) {
		host.is_reloading = true;
		host.sprite_index = host.sprites_indexes.reload;
		host.cancel_movement();
		
		if (host.is_aiming)
			host.remove_aiming_instance();
	}

	host.update_aim();
}

function client_reload_check(_client, _client_input) {
	if (_client.has_gun && _client_input.is_reload_pressed 
		&& !_client.is_reloading && _client.bullets_count < _client.cartridge_capacity
		&& _client.sprite_index != _client.sprites_indexes.draw_gun
		&& _client.sprite_index != _client.sprites_indexes.air) {
		_client.is_reloading = true;
		_client.sprite_index = _client.sprites_indexes.reload;
		_client.cancel_movement();
		
		if (_client.is_aiming)
			_client.remove_aiming_instance();
	}
}

function client_aiming_check(_client, _client_input) {
	var is_aiming = _client_input.is_aiming_held;
	if (is_aiming) {
		if (_client.is_reloading)
			_client.is_aiming = true;
		else if (_client.sprite_index != _client.sprites_indexes.draw_gun
			&& _client.sprite_index != _client.sprites_indexes.air 
			&& !_client.is_aiming) {
			_client.sprite_index = _client.sprites_indexes.draw_gun;
			_client.cancel_movement();
		}
	} else {
		if (_client.is_aiming) {
			_client.is_aiming = false;
			if (!_client.is_reloading) {
				_client.sprite_index = _client.sprites_indexes.idle;
				_client.remove_aiming_instance()
			}
		}
	}
	return is_aiming;
}

function add_shooting_particles_and_sound(_shoot_particles) {
	if (_shoot_particles != noone)
		for (var i = 0; i < array_length(_shoot_particles); i++)
			array_push(particles, _shoot_particles[i]);
	
	array_push(sounds, {
		index: sfx_shoot,
		pitch: audio_sound_get_pitch(sfx_shoot),
		priority: 5,
		is_loop: false
	});
}

function client_shoot_check(_client, _client_input) {
	if (_client_input.is_shoot_pressed && _client_input.is_aiming_held) {
		var has_failed = false;
		if (_client.bullets_count > 0) {
			add_shooting_particles_and_sound(
				_client.aiming_instance.shoot());
			_client.bullets_count--;
			_client.cartridge.spin_next_bullet();
			
			if (_client.aiming_instance.aiming.target.object_index == obj_player_host)
				_client.aiming_instance.aiming.target = _client.aiming_instance.aiming.target.socket;
			else
				_client.aiming_instance.aiming.target = noone;
		} else {
			_client.cartridge.shake();
			
			has_failed = true;
		}
	}
}

function update_client(_client, _client_input) {
	if (_client.has_fallen_dead)
		return;

	if (!_client.is_aiming && !_client.is_reloading 
		&& _client.sprite_index != _client.sprites_indexes.draw_gun)
		_client.update_movement(_client_input);
	
	if (!self.is_input_enabled(_client))
		return;

	client_reload_check(_client, _client_input);
	
	if (!_client.has_gun ||
		!client_aiming_check(_client, _client_input) ||
		_client.aiming_instance == noone ||
		_client.is_reloading)
		return;
	
	_client.aiming_instance.image_angle = _client_input.aiming_angle;
	client_shoot_check(_client, _client_input);
}
