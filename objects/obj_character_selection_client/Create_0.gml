gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
font = fnt_mono_small;
font_start_match = fnt_mono;
font_height = font_get_size(font);
show_text = false;
blink_frames_count = 15;
blink_current_frame = 0;
can_start = false;
chosen_characters = [];
selections = [];
client = noone;

function update(_host_data) {
	chosen_characters = _host_data.chosen_characters;
	selections = _host_data.selections;
	can_start = _host_data.can_start;
}