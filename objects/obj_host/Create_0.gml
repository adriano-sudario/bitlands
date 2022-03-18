server_socket = network_create_server(network_socket_tcp, 6510, 4);
var has_connection_failed = server_socket < 0;
handler_object = noone;
socket_list = ds_list_create();

if (!has_connection_failed) {
	slide_transition(TRANSITION_MODE.CLOSE, function() {
		room_goto(ShootingCharacterSelectionMultiplayer);
		slide_transition(TRANSITION_MODE.OPEN);
	}, 250);
}

get = http_get("https://ipecho.net/plain");
host_ip = "";

function send_data(_data) {
	var buffer = buffer_create(256, buffer_grow, 1);
	buffer_write(buffer , buffer_string, _data);
		
	for (var i = 0; i < ds_list_size(socket_list); ++i;)
		network_send_packet(ds_list_find_value(socket_list, i), buffer, buffer_tell(buffer));
		
	buffer_delete(buffer);
}