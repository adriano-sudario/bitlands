var network_id = ds_map_find_value(async_load, "id");
if (network_id != socket)
	return;

var buffer = ds_map_find_value(async_load, "buffer"); 
var packet = json_parse(buffer_read(buffer, buffer_string));

if (room == ShootingCharacterSelectionMultiplayer) {
	switch (packet.command) {
		case HOST_EVENT.UPDATE_CLIENT:
			if (handler_object != noone)
				handler_object.update(packet.data);
			break;
	}
}