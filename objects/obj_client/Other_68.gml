var network_id = ds_map_find_value(async_load, "id");
if (network_id != socket)
	return;

var buffer = ds_map_find_value(async_load, "buffer"); 
var packet = json_parse(buffer_read(buffer, buffer_string));

switch (packet.command) {
    case HOST_EVENT.CLIENT_CONNECTED:
        slide_transition(TRANSITION_MODE.CLOSE, function() {
			room_goto(ShootingCharacterSelectionMultiplayer);
			slide_transition(TRANSITION_MODE.OPEN);
		}, 250);
		break;
		
	case HOST_EVENT.UPDATE_CLIENT_SELECTION:
		if (handler_object != noone)
			handler_object.update(packet.data);
		break;
}