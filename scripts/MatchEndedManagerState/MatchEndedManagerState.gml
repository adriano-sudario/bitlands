function MatchEndedManagerState(_winner_description) : ManagerState() constructor {
	winner_description = _winner_description;
	font_height = font_get_size(font);
	
	function on_draw_GUI() {
		prepare_text_draw(font_big, fa_center, fa_center);
		draw_outlined_text(gui_width * .5, 150, winner_description);
		prepare_text_draw(font, fa_center, fa_center);
		draw_outlined_text(gui_width * .5, 150 + (font_height * 2), "press start to rematch");
	}
}