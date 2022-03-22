var type = ds_map_find_value(async_load, "type");

switch(type) {
	case network_type_connect:
		var socket = ds_map_find_value(async_load, "socket");
		ds_list_add(socket_list, socket);
		handler_object.select_input(socket);
	    break;
	
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket");
		handler_object.leave_room(socket);
	    ds_map_delete(socket_list, socket);
	    break;
	
	case network_type_data:
		var socket = ds_map_find_value(async_load, "id");
		var buffer = ds_map_find_value(async_load, "buffer");
		var packet = json_parse(buffer_read(buffer, buffer_string));
		
		if (room == ShootingCharacterSelectionMultiplayer) {
			switch (packet.command) {
				case CLIENT_EVENT.UPDATE_CLIENT_SELECTION:
					handler_object.update_clients_selections(socket, packet.data);
					break;
			}
		}
	    break;
}