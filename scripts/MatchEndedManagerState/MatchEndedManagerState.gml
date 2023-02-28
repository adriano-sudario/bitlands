function MatchEndedManagerState(_winner_description) : ManagerState() constructor {
	winner_description = _winner_description;
	
	function on_draw_GUI() {
		draw_outlined_text(gui_width * .5, gui_height * .5 - (font_height * 4) - 25, winner_description);
		draw_outlined_text(gui_width * .5, gui_height * .5, "press start to rematch");
	}
}