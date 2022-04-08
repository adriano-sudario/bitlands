for (var i = 0; i < array_length(global.game_state.players); i++) {
	players[i] = instance_create_layer(x, y, "Players", obj_player_host);
	with (player) {
		player_info = global.game_state.players[i];
		input = input_manager();
		sprites_indexes = get_character_sprites(player_info.character);
		client = player_info.client;
		image_xscale = player_info.image_xscale;
		x = player_info.x;
		y = player_info.y;
	}
}