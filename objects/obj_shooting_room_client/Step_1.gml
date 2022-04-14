if (client.has_fallen_dead || !client.is_input_enabled())
	return;

client.update_aim();

var copulated_input = get_copulated_input(client.input);
global.client.send_packet_to_server(NETWORK_EVENT.UPDATE, copulated_input);
