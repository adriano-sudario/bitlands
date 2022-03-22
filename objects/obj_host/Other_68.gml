var network_id = ds_map_find_value(async_load, "id");
if (network_id != server_socket)
	return;

var type = ds_map_find_value(async_load, "type");
var socket = ds_map_find_value(async_load, "socket");
	
switch(type) {
	case network_type_connect:
		ds_list_add(socket_list, socket);
		send_client_connection_packet();
	    break;
	
	case network_type_disconnect:
		handler_object.leave_room(ds_map_find_value(socket_list, socket));
	    ds_map_delete(socket_list, socket);
	    break;
	
	case network_type_data:
		var buffer = ds_map_find_value(async_load, "buffer"); 
		var packet = json_parse(buffer_read(buffer, buffer_string));
		var socket = ds_map_find_value(socket_list, socket);
	
		switch (packet.command) {
		    case CLIENT_EVENT.JOIN_ROOM:
				handler_object.select_input(socket);
				break;
				
			case CLIENT_EVENT.UPDATE_CLIENT:
				handler_object.update_clients_selections(socket, packet.data);
				break;
		}
	    break;
}