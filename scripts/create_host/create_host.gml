/// @function create_host()

function create_host() {
	var server_socket = network_create_server(network_socket_tcp, 6510, 4);
	var has_connection_failed = server_socket < 0;
	if (has_connection_failed)
		return false;
	
	global.host = {
		server: server_socket,
		client_sockets: [],
		send_packet_to_clients: function(_command, _data = noone) {
			var buffer = buffer_create(256, buffer_grow, 1);
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer , buffer_string, json_stringify({
				command: _command,
				data: _data
			}));
		
			for (var i = 0; i < array_length(client_sockets); ++i;)
				network_send_packet(client_sockets[i], buffer, buffer_tell(buffer));
		
			buffer_delete(buffer);
		}
	};
	
	return true;
}