host = noone;
clients = [];
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

function is_input_enabled(_player) {
	return !_player.is_dead && !has_match_ended && has_begun;
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
		&& !host.is_reloading && host.bullets_count < host.cartrige_capacity
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
		&& !_client.is_reloading && _client.bullets_count < _client.cartrige_capacity
		&& _client.sprite_index != _client.sprites_indexes.draw_gun
		&& _client.sprite_index != _client.sprites_indexes.air) {
		_client.is_reloading = true;
		_client.sprite_index = _client.sprites_indexes.reload;
		_client.cancel_movement();
		
		if (_client.is_aiming)
			_client.remove_aiming_instance();
			
		return { event: SHOOTING_CLIENT_EVENT.RELOAD };
	}
	return noone;
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

function client_shoot_check(_client, _client_input) {
	_client.aiming_instance.image_angle = _client_input.aiming_angle;
	if (_client_input.is_shoot_pressed && _client_input.is_aiming_held) {
		var has_failed = false;
		if (_client.bullets_count > 0) {
			_client.aiming_instance.update();
			_client.aiming_instance.shoot();
			_client.bullets_count--;
			_client.cartrige.spin_next_bullet();
			
			if (_client.aiming_instance.aiming.target.object_index == obj_player_host)
				_client.aiming_instance.aiming.target = _client.aiming_instance.aiming.target.socket;
			else
				_client.aiming_instance.aiming.target = noone;
		} else {
			_client.cartrige.shake();
			
			has_failed = true;
		}
		
		return {
			event: SHOOTING_CLIENT_EVENT.SHOOT,
			has_shoot_failed: has_failed,
			bullets_count: _client.bullets_count,
			aiming: _client.aiming_instance.aiming
		};
	}
	return noone;
}

function update_client(_client, _client_input) {
	if (_client.has_fallen_dead)
		return noone;

	if (!_client.is_aiming && !_client.is_reloading 
		&& _client.sprite_index != _client.sprites_indexes.draw_gun)
		_client.update_movement(_client_input);
	
	if (!self.is_input_enabled(_client))
		return noone;

	var result = client_reload_check(_client, _client_input);
	
	if (!_client.has_gun ||
		!client_aiming_check(_client, _client_input) ||
		_client.aiming_instance == noone ||
		_client.is_reloading)
		return result;
	
	return client_shoot_check(_client, _client_input);
}
