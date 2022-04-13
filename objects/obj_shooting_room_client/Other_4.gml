for (var i = 0; i < array_length(global.game_state.players); i++) {
	var info = global.game_state.players[i];
	var player_type = obj_player_network;
	
	if (info.socket == global.client.socket)
		player_type = obj_player_client;
	
	var player = instance_create_layer(x, y, "Players", player_type);
	
	with (player) {
		if (player_type == obj_player_client)
			input = input_manager();
		
		player_info = info;
		sprites_indexes = get_character_sprites(player_info.character);
		image_xscale = player_info.spawn_point.image_xscale;
		x = player_info.spawn_point.x;
		y = player_info.spawn_point.y;
		socket = player_info.socket;
	}
	
	if (player_type == obj_player_client)
		client = player;
	
	players[i] = instance_create_layer(x, y, "Players", player_type);
}