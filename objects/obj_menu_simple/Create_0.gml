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
items = [options.quit, options.show_aim, options.fullscreen, options.new_game];

controls = [
	controller(-1), controller(0),
	controller(1), controller(2),
	controller(3)
];

current_down_controls = [];
current_up_controls = [];
previous_down_controls = [];
previous_up_controls = [];

for (var i = 0; i < array_length(controls); i++;) {
	array_insert(current_down_controls, i, controls[i]);
	array_insert(current_up_controls, i, controls[i]);
	array_insert(previous_down_controls, i, controls[i]);
	array_insert(previous_up_controls, i, controls[i]);
}

function mount_items() {
	var vertical_margin = (font_height * .5);
	if (argument_count > 0)
		vertical_margin = argument0;
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