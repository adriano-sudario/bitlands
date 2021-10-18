if (!has_begun) {
	countdown_scale += countdown_growth_speed;
	if (countdown_scale >= 1) {
		if (!has_bipped) {
			var sfx = countdown == 3 ? sfx_countdown_high : sfx_countdown_low;
			audio_play_sound(sfx, 5, false);
			has_bipped = true;
		}
		countdown_scale = 1;
		current_countdown_fps_stopped++;
		if (current_countdown_fps_stopped >= countdown_fps_stopped) {
			has_bipped = false;
			countdown++;
			if (countdown > 3) {
				has_begun = true;
				audio_play_sound(stk_chaesd_by_teh_rievr, 100, true);
			} else {
				countdown_scale = 0;
				current_countdown_fps_stopped = 0;
			}
		}
	}
	return;
}

var players_length = array_length(players);

if (players_length == 0)
	return;

var players_standing = [];

for (var i = 0; i < players_length; i++) {
	var player = players[i];
	if (!player.has_fallen)
		array_insert(players_standing, array_length(players_standing), player);
}

var players_standing_length = array_length(players_standing);
has_match_ended = players_standing_length <= 1;

if (has_match_ended && !has_menu_appeared
	&& !instance_exists(obj_menu_simple)) {
	if (players_standing_length == 1) {
		winning_player = players_standing[0];
		winning_player.sprite_index = winning_player.sprites_indexes.idle;
		winning_player.cancel_movement();
		if (winning_player.is_aiming)
			winning_player.remove_aiming_instance();
	}
	with (instance_create_layer(0, 0, "Helpers", obj_menu_simple)) {
		margin = 0;
		horizontal_position = gui_width * .5;
		vertical_position = gui_height * .5 - font_height - 25;
		horizontal_align = fa_center;
		vertical_align = fa_center;
		options = get_ending_menu_items();
		items = [options.back_to_main_menu, options.rematch];
		mount_items(0);
	}
	has_menu_appeared = true;
}