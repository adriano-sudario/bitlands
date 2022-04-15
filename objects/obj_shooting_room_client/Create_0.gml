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

function is_input_enabled(_player) {
	return !client.is_dead && !has_match_ended && has_begun;
}

function leave() {
	global.client.send_packet_to_server(NETWORK_EVENT.REMOVE);
	room_goto(Menu);
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
		return;
			
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
		return;
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

function on_pickup_gun(_data) {
	for (var i = 0; i < instance_number(obj_gun); ++i;)
	{
	    var gun = instance_find(obj_gun, i);
		if (gun.x == _data.x && gun.y == _data.y) {
			instance_destroy(gun);
			break;
		}
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
		case SHOOTING_CLIENT_EVENT.RELOAD:
			on_reload(_player);
			break;
	
		case SHOOTING_CLIENT_EVENT.SHOOT:
			on_shoot(_player, _data);
			break;
		
		case SHOOTING_CLIENT_EVENT.COUNTDOWN:
			on_countdown(_data);
			break;
			break;
		
		case SHOOTING_CLIENT_EVENT.PICKUP_GUN:
			on_pickup_gun(_data);
			break;
	
		case SHOOTING_CLIENT_EVENT.END_MATCH:
			on_end_match(_data);
			break;
	}
}
