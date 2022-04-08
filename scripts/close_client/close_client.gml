/// @function close_client()

function close_client() {
	network_destroy(global.client.socket);
	global.client = noone;
}