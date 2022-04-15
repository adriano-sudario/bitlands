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
