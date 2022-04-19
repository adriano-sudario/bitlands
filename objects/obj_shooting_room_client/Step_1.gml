if (!self.is_input_enabled())
	return;

var _copulated_input = get_copulated_input(input, client);
global.client.send_packet_to_server(NETWORK_EVENT.UPDATE, _copulated_input);
