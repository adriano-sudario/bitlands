blink_current_frame++;

if (blink_current_frame >= blink_frames_count) {
	blink_current_frame = 0;
	show_text = !show_text;
}

if (obj_transition.mode != TRANSITION_MODE.CLOSE)
	self.update_selection();

can_start = array_length(chosen_characters) >= 2;