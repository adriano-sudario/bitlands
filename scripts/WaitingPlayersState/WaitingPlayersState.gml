function WaitingPlayersState() constructor {
	owner = other;
	gui_width = display_get_gui_width();
	gui_height = display_get_gui_height();
	font_small = fnt_mono_small;
	font = fnt_mono;
	is_selecting_characters = false;
	
	function can_start_selection() {
		return owner.players_connected >= 2;
	}
	
	function on_step() {
		if (can_start_selection()
			&& (keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start))) {
			is_selecting_characters = true;
			rollback_start_game();
		}
	}
	
	function on_draw_GUI() {
		if (is_selecting_characters)
			return;
		
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