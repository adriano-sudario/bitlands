var _socket = ds_map_find_value(async_load, "id");
if (global.client == noone || _socket != global.client.socket)
	return;
	
if (obj_transition.mode == TRANSITION_MODE.OFF) {
	if (timeout_delay != noone)
		timeout_delay.reset();
	else
		timeout_delay = wait_for_milliseconds(5000, leave);
}

var buffer = ds_map_find_value(async_load, "buffer"); 
var packet = json_parse(buffer_read(buffer, buffer_string));

switch (packet.command) {
	case NETWORK_EVENT.UPDATE:
		if (packet.data.event != noone) {
			var _player = array_find(players, function(c, s) {
				return c.socket == s;
			}, _socket);
			on_event(packet.data, _player);
			break;
		}
		
		for (var i = 0; i < array_length(packet.data.states); i++) {
			var _state = packet.data.states[i];
			var _player = array_find(players, function(c, s) {
				return c.socket == s;
			}, _state.socket);
			update_player_state(_player, _state);
		}
		break;
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
			
	if (_player.player_info.socket == global.client.socket)
		break;
			
	if (_player.aiming_instance == noone && _state.aiming_instance != noone)
		_player.insert_aiming_instance();
	else if (_player.aiming_instance != noone && _state.aiming_instance == noone)
		_player.remove_aiming_instance();
			
	if (_player.aiming_instance != noone) {
		_player.aiming_instance.image_angle = _state.angle;
		_player.aiming_instance.recoil = _state.recoil;
		_player.aiming_instance.aiming = _state.aiming;
		_player.cartrige.shake_params = _state.cartrige.shake_params;
	}
}

function on_reload(_player) {
	_player.is_reloading = true;
	_player.sprite_index = _player.sprites_indexes.reload;
}

function on_shoot(_player, _data) {
	if (_data.has_shoot_failed) {
		_player.cartrige.shake();
		break;
	}
		
	if (_data.aiming.target != noone)
		_data.aiming.target = array_find(players, function(c, s) {
			return c.socket == s;
		}, _data.aiming.target);
			
	_player.aiming_instance.aiming = _data.aiming;
	_player.aiming_instance.shoot();
	_player.bullets_count = _data.bullets_count;
	_player.cartrige.spin_next_bullet();
}

function on_countdown(_data) {
	countdown = _data.countdown.value;
	countdown_scale = _data.countdown.scale;
	has_begun = _data.has_begun;
}

function on_end_match(_data) {
	if (has_match_ended)
		break;
			
	has_match_ended = true;
	if (_data.winner != noone)
		winner = array_find(players, function(c, s) {
			return c.socket == s;
		}, _data.winner);
}

function on_event(_data, _player) {
	switch (_data.event) {
		case SHOOTING_CLIENT_EVENT.RELOAD:
			on_reload(_player);
			break;
	
		case SHOOTING_CLIENT_EVENT.SHOOT:
			on_shoot(_player, _data);
			break;
		
		case SHOOTING_CLIENT_EVENT.COUNTDOWN:
			on_countdown(_data);
			break;
	
		case SHOOTING_CLIENT_EVENT.END_MATCH:
			on_end_match(_data);
			break;
	}
}
