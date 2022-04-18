client = noone;
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
has_begun = false;
timeout_delay = noone;

function is_input_enabled() {
	return !client.is_dead && !has_match_ended && has_begun;
}

function leave() {
	global.client.send_packet_to_server(NETWORK_EVENT.REMOVE);
	room_goto(Menu);
}

function instantiate_particle(_particle) {
	with (instance_create_layer(_particle.x, _particle.y, "Dusts", obj_particle)) {
		image_index = _particle.index;
		image_xscale = _particle.xscale;
		image_yscale = _particle.yscale;
		horizontal_speed = _particle.horizontal_speed;
		vertical_speed = _particle.vertical_speed;
		set_type(_particle.type);
	}
}

function update_player_state(_player, _state) {
	_player.x = _state.x;
	_player.y = _state.y;
	_player.image_xscale = _state.image_xscale;
	_player.is_dead = _state.is_dead;
	_player.is_aiming = _state.is_aiming;
	_player.is_reloading = _state.is_reloading;
	_player.has_gun = _state.has_gun;
	_player.bullets_count = _state.bullets_count;
	_player.sprite_index = _state.animation.sprite_index;
	_player.image_index = _state.animation.image_index;
			
	if (_player.aiming_instance == noone && _state.is_aiming)
		_player.insert_aiming_instance();
	else if (_player.aiming_instance != noone && 
		(!_state.is_aiming || _state.is_reloading || has_match_ended))
		_player.remove_aiming_instance();
			
	if (_player.aiming_instance != noone) {
		if (_state.aiming_instance.angle > 90 && _state.aiming_instance.angle <= 270)
			_player.aiming_instance.image_yscale = -1;
		else
			_player.aiming_instance.image_yscale = 1;
		
		_player.aiming_instance.image_angle = _state.aiming_instance.angle;
		_player.aiming_instance.recoil = _state.aiming_instance.recoil;
		_player.aiming_instance.aiming = _state.aiming_instance.aiming;
		_player.cartrige.shake_params = _state.cartrige.shake_params;
	}
}

function on_countdown(_data) {
	countdown = _data.countdown.value;
	countdown_scale = _data.countdown.scale;
	has_begun = _data.has_begun;
}

function on_match_update(_data) {
	for (var i = 0; i < array_length(_data.guns_to_remove); i++;) {
		var _gun_to_remove = _data.guns_to_remove[i];
		var _gun_found = instance_position(_gun_to_remove.x, _gun_to_remove.y, obj_gun);
		instance_destroy(_gun_found);
	}
}

function on_end_match(_data) {
	if (has_match_ended)
		return;
			
	has_match_ended = true;
	if (_data.winner != noone)
		winner = array_find(players, function(c, s) {
			return c.socket == s;
		}, _data.winner);
}

function on_event(_data, _player) {
	switch (_data.event) {
		case SHOOTING_CLIENT_EVENT.COUNTDOWN:
			on_countdown(_data);
			break;
		
		case SHOOTING_CLIENT_EVENT.MATCH_UPDATE:
			on_match_update(_data);
			break;
	
		case SHOOTING_CLIENT_EVENT.END_MATCH:
			on_end_match(_data);
			break;
	}
}
