function ChoosingCharacterManagerState() : ManagerState() constructor {
	show_text = false;
	blink_frames_count = 15;
	blink_current_frame = 0;
	is_choosing_characters = false;
	
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
		var _was_choosing_characters = is_choosing_characters;
		is_choosing_characters = can_start_match();
		
		if (!is_choosing_characters)
			return;
		
		if (is_choosing_characters && !_was_choosing_characters)
			show_text = true;
		
		blink_current_frame++;

		if (blink_current_frame >= blink_frames_count) {
			blink_current_frame = 0;
			show_text = !show_text;
		}
	}
	
	function on_draw_GUI() {
		if (!show_text)
			return;
		
		prepare_text_draw(font, fa_center, fa_center);
		var _text = is_choosing_characters ? "CHOOSING CHARACTERS" : "START MATCH";
		draw_outlined_text(gui_width * .5, gui_height * .5 + 280, _text);
	}
}