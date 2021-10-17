window_set_cursor(cr_none);
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
margin = 32;
font = fnt_mono;
outline_border_color = c_black;
font_height = font_get_size(font);
horizontal_position = gui_width - margin;
vertical_position = gui_height - margin;
alpha = 1;
show_arrow = false;
horizontal_align = fa_right;
vertical_align = fa_bottom;

options = get_menu_items();
items = [options.quit, options.fullscreen, options.new_game];

controls = controller(0);
current_up_held = controls.is_up_held();
current_down_held = controls.is_down_held();
previous_up_held = current_up_held;
previous_down_held = current_down_held;

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