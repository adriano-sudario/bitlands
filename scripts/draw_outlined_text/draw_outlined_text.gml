/// @function draw_outlined_text(x, y, text, text_color, border_color)

function draw_outlined_text(_x, _y, _text){
	var offset = 2;
	var border_color = c_black;
	var text_color = c_white;
	
	if (argument_count > 3)
		text_color = argument[3];
		
	if (argument_count > 4)
		border_color = argument[4];
		
	draw_set_color(border_color);
	for (var o = 0; o < 4; o++) {
		if (o < 2)
			draw_text(_x + (offset * (o % 2 == 0 ? 1 : -1)), _y, _text);
		else
			draw_text(_x, _y + (offset * (o % 2 == 0 ? 1 : -1)), _text);
	}
	
	draw_set_color(text_color);
	draw_text(_x, _y, _text);
}