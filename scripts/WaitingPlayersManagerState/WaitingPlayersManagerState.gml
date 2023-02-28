function WaitingPlayersManagerState() : ManagerState() constructor {
	function can_start_selection() {
		return owner.players_connected >= 2;
	}
	
	function on_step() {
		if (can_start_selection()
			&& (keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start)))
			rollback_start_game();
	}
	
	function on_draw_GUI() {
		prepare_text_draw(font, fa_center, fa_center);
		draw_outlined_text(gui_width * .5, gui_height * .5 - 170,
			"waiting for players... " + string(owner.players_connected) + "/4");

		if (can_start_selection()) {
			prepare_text_draw(font_small, fa_center, fa_center);
			draw_outlined_text(gui_width * .5, gui_height * .5 - 135,
				"press start to begin with " + string(owner.players_connected) + " players");
		}
	}
}