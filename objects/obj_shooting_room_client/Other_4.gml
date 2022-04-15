if (!check_for_client())
	return;

for (var i = 0; i < array_length(global.game_state.players); i++) {
	var info = global.game_state.players[i];
	var is_client = info.socket == global.client.socket;
	
	var player = instance_create_layer(x, y, "Players", obj_player_client);
	
	with (player) {
		player_info = info;
		sprites_indexes = get_character_sprites(player_info.character);
		image_xscale = player_info.spawn_point.image_xscale;
		x = player_info.spawn_point.x;
		y = player_info.spawn_point.y;
		socket = player_info.socket;
	}
	
	if (is_client)
		client = player;
	
	players[i] = player;
}