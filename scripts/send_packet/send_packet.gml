/// @function send_packet(socket, command, data);
/// @param {socket} socket to send
/// @param {command} event to send
/// @param {data} data to send

function send_packet(_socket, _command, _data = noone) {
	var buffer = buffer_create(256, buffer_grow, 1);
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer , buffer_string, json_stringify({
		command: _command,
		data: _data
	}));
	network_send_packet(_socket, buffer, buffer_tell(buffer));
	buffer_delete(buffer);
}