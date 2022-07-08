if (!self.is_input_enabled() || global.client == noone)
	return;

var _populated_input = get_populated_input(input, client);
global.client.send_packet_to_server(NETWORK_EVENT.UPDATE, _populated_input);
