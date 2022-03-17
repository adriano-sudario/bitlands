gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
font = fnt_mono_small;
font_start_match = fnt_mono;
font_height = font_get_size(font);
show_text = false;
blink_frames_count = 15;
blink_current_frame = 0;
can_start = false;
characters_list = [
	CHARACTER.SEVERINO, CHARACTER.GERALDO,
	CHARACTER.RAIMUNDO, CHARACTER.SEBASTIAO
];
chosen_characters = [];
controls = [
	input_manager(-1), input_manager(0),
	input_manager(1), input_manager(2),
	input_manager(3)
];

current_left_controls = [];
current_right_controls = [];
previous_left_controls = [];
previous_right_controls = [];

for (var i = 0; i < array_length(controls); i++;) {
	array_insert(current_left_controls, i, controls[i]);
	array_insert(current_right_controls, i, controls[i]);
	array_insert(previous_left_controls, i, controls[i]);
	array_insert(previous_right_controls, i, controls[i]);
}

selections = [
	{
		spawn_point: noone,
		input: noone,
		is_ready: false,
		character_index: -1,
		chosen_index: -1,
		index: -1,
		vertical_margin: 15
	},
	{
		spawn_point: noone,
		input: noone,
		is_ready: false,
		character_index: -1,
		chosen_index: -1,
		index: -1,
		vertical_margin: 15
	},
	{
		spawn_point: noone,
		input: noone,
		is_ready: false,
		character_index: -1,
		chosen_index: -1,
		index: -1,
		vertical_margin: 15
	},
	{
		spawn_point: noone,
		input: noone,
		is_ready: false,
		character_index: -1,
		chosen_index: -1,
		index: -1,
		vertical_margin: 15
	}
];