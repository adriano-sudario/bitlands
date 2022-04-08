/// @function close_server()

function close_server() {
	network_destroy(global.host.server);
	global.host = noone;
}