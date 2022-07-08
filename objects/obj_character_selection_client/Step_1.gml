if (global.client == noone)
	return;

var _populated_input = get_populated_input();
global.client.send_packet_to_server(NETWORK_EVENT.UPDATE, _populated_input);
