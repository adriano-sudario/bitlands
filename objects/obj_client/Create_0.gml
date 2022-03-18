socket = network_create_socket(network_socket_tcp);
var server = network_connect(socket , "127.0.0.1", 6510);
var has_connection_failed = server < 0;
handler_object = noone;

if (!has_connection_failed) {
	slide_transition(TRANSITION_MODE.CLOSE, function() {
		room_goto(ShootingCharacterSelectionMultiplayer);
		slide_transition(TRANSITION_MODE.OPEN);
	}, 250);
}

function send_data(_data) {
	var buffer = buffer_create(256, buffer_grow, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_string, _data);
	network_send_packet(socket, buffer, buffer_tell(buffer));
	buffer_delete(buffer);
}