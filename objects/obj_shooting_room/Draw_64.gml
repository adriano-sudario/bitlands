if (!has_begun) {
	prepare_text_draw(font_countdown, fa_center, fa_center);
	draw_outlined_text_transformed(
		gui_width * .5, gui_height * .5 - (font_height * 4),
		string(countdown), countdown_scale);
	return;
}

if (has_match_ended && instance_exists(obj_menu_simple)) {
	var text = winning_player == noone ? "IT'S A DRAW!" 
		: "PLAYER " + string(winning_player.player_info.index) + " WINS!";
	prepare_text_draw(font, fa_center, fa_center);
	draw_outlined_text(gui_width * .5, gui_height * .5 - (font_height * 4) - 25, text);
}