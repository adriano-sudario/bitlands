prepare_text_draw(fnt_mono, fa_center, fa_center);

var screen_center_x = gui_width * .5;
var screen_center_y = gui_height * .5;

draw_outlined_text(screen_center_x, screen_center_y, ip, c_white, 1, c_black);
draw_outlined_text(screen_center_x, screen_center_y + 60, "HOST IP", c_white, 1, c_black);
	
if (!is_blink_shown)
	return;

draw_outlined_text(screen_center_x, screen_center_y + 10, get_underscores(), c_white, 1, c_black);

if (is_valid_ip_format())
	draw_outlined_text(
		gui_width * .5, gui_height * .95,
		"PRESS ENTER TO JOIN", c_white, 1, c_black);