blink_current_frame++;

if (blink_current_frame >= blink_frames_count) {
	blink_current_frame = 0;
	show_text = !show_text;
}

var host_selection = selections[0];
self.update_selection(host_selection);

can_start = array_length(chosen_characters) >= 2;