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
		&& host.sprite_index != host.sprites_indexes.drop_weapon)
		host.update_movement();
	
	if (!self.is_input_enabled(host))
		return;

	if (host.has_gun && host.input.is_reload_pressed() 
		&& !host.is_reloading && host.bullets_count < host.cartrige_capacity
		&& host.sprite_index != host.sprites_indexes.drop_weapon
		&& host.sprite_index != host.sprites_indexes.air ) {
		host.is_reloading = true;
		host.sprite_index = host.sprites_indexes.reload;
		host.cancel_movement();
		
		if (host.is_aiming)
			host.remove_aiming_instance();
	}

	host.update_aim();
}

function update_client(_client, _data) {
	var result = noone;
	
	if (_client.has_fallen_dead)
		return result;

	if (!_client.is_aiming && !_client.is_reloading 
		&& !_data.is_droping_weapon)
		_client.update_movement(_data.input);
	
	if (!is_input_enabled(_client))
		return result;

	if (_client.has_gun && _data.input.is_reload_pressed 
		&& !_client.is_reloading && _client.bullets_count < _client.cartrige_capacity
		&& !_data.is_droping_weapon
		&& !_data.is_on_air) {
		result = { event: SHOOTING_CLIENT_EVENT.RELOAD };
		_client.is_reloading = true;
		_client.sprite_index = _client.sprites_indexes.reload;
		_client.cancel_movement();
	}
	
	if (!_client.has_gun)
		return result;
	
	//if (_data.input.is_aiming_held) {
	//	if (_client.is_reloading)
	//		_client.is_aiming = true;
	//	else if (_data.is_droping_weapon && _data.is_on_air && !_client.is_aiming) {
	//		_client.sprite_index = _client.sprites_indexes.drop_weapon;
	//		_client.cancel_movement();
	//	}
	//} else {
	//	if (_client.is_aiming) {
	//		_client.is_aiming = false;
	//		if (!_client.is_reloading) {
	//			_client.sprite_index = _client.sprites_indexes.idle;
	//			_client.remove_aiming_instance()
	//		}
	//	}
	//	return;
	//}
	
	if (_client.aiming_instance == noone || _client.is_reloading)
		return result;
	
	//input.update_aiming_angle(x, y);
	_client.aiming_instance.image_angle = _data.input.aiming_angle;
	if (_data.input.is_shoot_pressed && _data.input.is_aiming_held) {
		var has_failed = false;
		if (_client.bullets_count > 0) {
			_client.aiming_instance.update();
			_client.aiming_instance.shoot();
			_client.bullets_count--;
			_client.cartrige.spin_next_bullet();
			
			if (_client.aiming_instance.target.object_index == obj_player_host)
				_client.aiming_instance.target = _client.aiming_instance.target.socket;
			else
				_client.aiming_instance.target = noone;
		} else {
			_client.cartrige.shake();
			
			has_failed = true;
		}
		
		result = {
			event: SHOOTING_CLIENT_EVENT.SHOOT,
			has_shoot_failed: has_failed,
			bullets_count: _client.bullets_count,
			aiming: _client.aiming_instance
		};
	}
	
	return result;
}
