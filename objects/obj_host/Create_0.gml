enum HOST_EVENT { CLIENT_CONNECTED, UPDATE_CLIENT_SELECTION }

handler_object = noone;
socket_list = ds_list_create();
host_ip = "";

function create_server() {
	server_socket = network_create_server(network_socket_tcp, 6510, 4);
	var has_connection_failed = server_socket < 0;
	if (has_connection_failed)
		return;

	host_ip = http_get("https://ipecho.net/plain");
	slide_transition(TRANSITION_MODE.CLOSE, function() {
		room_goto(ShootingCharacterSelectionMultiplayer);
		slide_transition(TRANSITION_MODE.OPEN);
	}, 250);
}

function send_client_connection_packet() {
	if (handler_object == noone) {
		wait_for_milliseconds(300, send_client_connection_packet);
		return;
	}
	
	send_packet(HOST_EVENT.CLIENT_CONNECTED);
}

function send_packet(_command, _data = noone) {
	var buffer = buffer_create(256, buffer_grow, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer , buffer_string, json_stringify({
		command: _command,
		data: _data
	}));
		
	for (var i = 0; i < ds_list_size(socket_list); ++i;)
		network_send_packet(ds_list_find_value(socket_list, i), buffer, buffer_tell(buffer));
		
	buffer_delete(buffer);
}