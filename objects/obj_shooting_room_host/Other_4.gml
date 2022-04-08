for (var i = 0; i < array_length(global.game_state.players); i++) {
	var player = instance_create_layer(x, y, "Players", obj_player_host);
	
	with (player) {
		player_info = global.game_state.players[i];
		input = input_manager();
		sprites_indexes = get_character_sprites(player_info.character);
		image_xscale = player_info.spawn_point.image_xscale;
		x = player_info.spawn_point.x;
		y = player_info.spawn_point.y;
		socket = player_info.client.socket;
	}
	
	if (player.player_info.client == noone)
		host = player;
	else
		clients[array_length(clients)] = player;
}