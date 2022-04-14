if (sprite_index == sprites_indexes.draw_gun) {
	begin_aiming();
} else if (sprite_index == sprites_indexes.reload) {
	bullets_count = cartrige_capacity;
	is_reloading = false;
	if (is_aiming)
		begin_aiming();
} else if (sprite_index == sprites_indexes.dead) {
	image_speed = 0;
	image_index = sprite_get_number(sprites_indexes.dead) - 1;
}