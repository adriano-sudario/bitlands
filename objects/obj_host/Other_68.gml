var network_id = ds_map_find_value(async_load, "id");
if (network_id != server_socket)
	return;

var type = ds_map_find_value(async_load, "type");
var socket = ds_map_find_value(async_load, "socket");
	
switch(type) {
	case network_type_connect:
	    ds_list_add(socket_list, socket);
	    break;
	case network_type_disconnect:
	    ds_map_delete(socket_list, socket);
	    break;
	case network_type_data:
		var buffer = ds_map_find_value(async_load, "buffer"); 
	    var command_type = buffer_read(buffer, buffer_u16);
	    var socket_id = ds_map_find_value(socket_list, socket);
		handler_object.handle_network_data(command_type, socket_id);
	    break;
}