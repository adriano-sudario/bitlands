prepare_text_draw(fnt_mono, fa_center, fa_center);

draw_outlined_text(
	gui_width * .5, gui_height * .5,
	get_formatted_ip_text(), c_white, 1, c_black);
	
draw_outlined_text(
	gui_width * .5, (gui_height * .5) + 50,
	"HOST IP", c_white, 1, c_black);
	
if (string_length(ip) == 11 && is_blink_shown)
	draw_outlined_text(
		gui_width * .5, gui_height * .95,
		"PRESS ENTER TO JOIN", c_white, 1, c_black);