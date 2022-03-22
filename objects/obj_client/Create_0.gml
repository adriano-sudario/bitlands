enum CLIENT_EVENT { UPDATE_CLIENT, JOIN_ROOM }

socket = network_create_socket(network_socket_tcp);
host_ip = "";
handler_object = noone;

function connect(_host_ip) {
	host_ip = _host_ip;
	var server = network_connect(socket , _host_ip, 6510);
	return server < 0;
}

function send_packet(_data) {
	var buffer = buffer_create(256, buffer_grow, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_string, _data);
	network_send_packet(socket, buffer, buffer_tell(buffer));
	buffer_delete(buffer);
}