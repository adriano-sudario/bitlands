if (array_length(global.game_state.players) > 3) {
	with (instance_create_layer(x, y, "Players", obj_player)) {
		player_info = global.game_state.players[3];
		controls = controller(player_info.input);
		sprites_indexes = obj_game.get_character_sprites(player_info.character);
		image_xscale = other.image_xscale; 
	}
}

instance_destroy();