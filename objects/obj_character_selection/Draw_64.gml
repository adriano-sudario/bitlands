if (!show_text)
	return;

for (var i = 0; i < array_length(selections); i++;) {
	var selection = selections[i];
	var selection_spawn = selection.spawn_point;
	var text = "START";
	var text_x = selection_spawn.x;
	var text_y = selection_spawn.y - selection.vertical_margin;
	
	if (selection.input != noone) {
		text = "CHOOSING";
	}
	
	if (selection.is_ready) {
		text = "READY";
	}
	
	prepare_text_draw(font, fa_center, fa_center);
	draw_outlined_text(text_x, text_y, text);
}

if (can_start) {
	prepare_text_draw(font_start_match, fa_center, fa_center);
	draw_outlined_text(gui_width * .5, gui_height * .5 + 280, "START MATCH");
}