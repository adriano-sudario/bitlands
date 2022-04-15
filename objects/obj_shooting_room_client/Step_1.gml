if (client.has_fallen_dead || !client.is_input_enabled())
	return;

global.client.send_packet_to_server(NETWORK_EVENT.UPDATE, get_copulated_input(client.input));
