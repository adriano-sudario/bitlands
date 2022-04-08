var type = ds_map_find_value(async_load, "type");

switch(type) {
	case network_type_connect:
		var socket = ds_map_find_value(async_load, "socket");
		connect_client(socket);
	    break;
	
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket");
		disconnect_client(socket);
	    break;
	
	case network_type_data:
		var socket = ds_map_find_value(async_load, "id");
		var buffer = ds_map_find_value(async_load, "buffer");
		var packet = json_parse(buffer_read(buffer, buffer_string));
		
		switch (packet.command) {
			case NETWORK_EVENT.UPDATE:
				update_clients_selections(socket, packet.data);
				break;
			
			case NETWORK_EVENT.REMOVE:
				disconnect_client(socket);
				break;
		}
	    break;
}