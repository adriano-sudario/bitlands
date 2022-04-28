/// @function create_client()

function create_client(_host_ip) {
	var client_socket = network_create_socket(network_socket_tcp);
	var server_socket = network_connect(client_socket , _host_ip, 6510);
	var has_connected = server_socket >= 0;
	
	if (!has_connected)
		return;

	global.client = {
		server: server_socket,
		socket: client_socket,
		host_ip: _host_ip,
		send_packet_to_server: function(_command, _data = noone) {
			send_packet(server, _command, _data);
		}
	};
	
	return true;
}