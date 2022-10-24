blink_current_frame++;

if (blink_current_frame >= blink_frames_count) {
	blink_current_frame = 0;
	show_text = !show_text;
}