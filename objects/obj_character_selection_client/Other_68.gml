var network_id = ds_map_find_value(async_load, "id");
if (global.client == noone || network_id != global.client.socket)
	return;
	
//if (room != ShootingCharacterSelectionMultiplayer) {
//	instance_destroy();
//	return;
//}
	
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
		if (!variable_struct_exists(packet.data, "has_match_started"))
			break;
		
		if (packet.data.has_match_started) {
			global.game_state = { players: packet.data.players };
			audio_stop_sound(stk_crujoa);
			room_goto(ShootingMultiplayer);
		} else {
			self.update(packet.data);
		}
		break;
	
	case NETWORK_EVENT.REMOVE:
		global.client.send_packet_to_server(NETWORK_EVENT.REMOVE);
		room_goto(Menu);
		break;
}