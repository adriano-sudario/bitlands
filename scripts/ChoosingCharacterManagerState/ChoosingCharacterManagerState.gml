function ChoosingCharacterManagerState() : ManagerState() constructor {
	show_text = false;
	blink_frames_count = 15;
	blink_current_frame = 0;
	is_GUI_active = false;
	
	function can_start_match() {
		with (owner) {
			var _characters_picked = 0;
			
			for (var i =0; i < array_length(global.characters); i++)
				if (global.characters[i].has_been_picked)
					_characters_picked++;
		
			return players_connected == _characters_picked;
		}
	}
	
	function on_step() {
		var _was_GUI_active = is_GUI_active;
		is_GUI_active = can_start_match();
		
		if (!is_GUI_active)
			return;
		
		if (is_GUI_active && !_was_GUI_active)
			show_text = true;
		
		blink_current_frame++;

		if (blink_current_frame >= blink_frames_count) {
			blink_current_frame = 0;
			show_text = !show_text;
		}
	}
	
	function on_draw_GUI() {
		if (!is_GUI_active || !show_text)
			return;
		
		prepare_text_draw(font, fa_center, fa_center);
		draw_outlined_text(gui_width * .5, gui_height * .5 + 280, "START MATCH");
	}
}