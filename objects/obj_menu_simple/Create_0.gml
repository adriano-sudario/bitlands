window_set_cursor(cr_none);
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
margin = 32;
font = fnt_mono;
outline_border_color = c_black;
font_height = font_get_size(font);
horizontal_position = gui_width * .5;
vertical_position = (gui_height * .5) + 100;
alpha = 1;
show_arrow = false;
horizontal_align = fa_center;
vertical_align = fa_center;

options = get_menu_items();
items = [
	options.quit,
	options.options,
	options.join_game,
	options.host_game,
	options.new_game
];

input = input_manager();
current_down_input = input.is_down_held();
current_up_input = input.is_up_held();
previous_down_input = input.is_down_held();
previous_up_input = input.is_up_held();

function mount_items(_vertical_margin = noone) {
	var vertical_margin = (font_height * .5);
	if (_vertical_margin != noone)
		vertical_margin = _vertical_margin;
	for (var i = 0; i < array_length(items); i++) {
		var item = items[i];
		item.x = horizontal_position;
		if (i == 0)
			items[i].y = vertical_position;
		else
			items[i].y = items[i - 1].y - font_height - vertical_margin;
	}

	selected_item = array_length(items) - 1;
}

mount_items();