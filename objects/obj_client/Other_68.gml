var network_id = ds_map_find_value(async_load, "id");
if (network_id != socket)
	return;
	
var buffer = ds_map_find_value(async_load, "buffer"); 
var command_type = buffer_read(buffer, buffer_u16);
handler_object.handle_network_data(command_type);