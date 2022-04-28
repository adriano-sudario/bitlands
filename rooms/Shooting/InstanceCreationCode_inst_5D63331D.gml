if (array_length(global.game_state.players) > 2) {
	player = instance_create_layer(x, y, "Players", obj_player);
	with (player) {
		player_info = global.game_state.players[2];
		input = input_manager(player_info.input);
		sprites_indexes = get_character_sprites(player_info.character);
		image_xscale = other.image_xscale;
	}
}