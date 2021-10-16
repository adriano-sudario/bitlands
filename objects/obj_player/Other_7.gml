if (sprite_index == spr_drop_weapon) {
	begin_aiming();
} else if (sprite_index == spr_reload) {
	bullets_count = cartrige_capacity;
	is_reloading = false;
	if (is_aiming)
		begin_aiming();
}