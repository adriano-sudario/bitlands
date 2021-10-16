prepare_text_draw(font, fa_right, fa_bottom);

for (var i = 0; i < array_length(items); i++) {
	var item = items[i];
	var text = i == selected_item && !is_disabled ? "> " + item.text : item.text;
	draw_outlined_text(item.x, item.y, text);
}

draw_set_color(c_black);
draw_rectangle(gui_width, 0, gui_width + starting_position_offset, gui_height, false);