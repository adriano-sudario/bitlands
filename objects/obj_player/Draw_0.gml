if (flash_frames > 0) {
	flash_frames--;
	draw_with_fill_color_shader(255, 255, 255);
} else {
	draw_self();
}