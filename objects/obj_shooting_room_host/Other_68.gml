var type = ds_map_find_value(async_load, "type");

switch(type) {
	case network_type_disconnect:
		var socket = ds_map_find_value(async_load, "socket");
		disconnect_client(socket);
	    break;
	
	case network_type_data:
		var socket = ds_map_find_value(async_load, "id");
		var buffer = ds_map_find_value(async_load, "buffer");
		var packet = json_parse(buffer_read(buffer, buffer_string));
		
		switch (packet.command) {
			case NETWORK_EVENT.UPDATE:
				var _client = array_find(clients, function(c, s) {
					return c.socket == s;
				}, socket);
				var _result = update_client(_client, packet.data);
				if (_result != noone) {
					switch (_result.event) {
						case SHOOTING_CLIENT_EVENT.RELOAD:
							send_packet(socket, NETWORK_EVENT.UPDATE, { event: _result.event });
							break;
						
						case SHOOTING_CLIENT_EVENT.SHOOT:
							send_packet(socket, NETWORK_EVENT.UPDATE, {
								event: _result.event,
								has_shoot_failed: _result.has_shoot_failed,
								bullets_count: _result.bullets_count,
								aiming: _result.aiming
							});
							break;
					}
				}
				break;
		}
	    break;
}
