if (global.client == noone)
	return;

var copulated_input = get_copulated_inputs();
global.client.send_packet_to_server(NETWORK_EVENT.UPDATE, copulated_input);
