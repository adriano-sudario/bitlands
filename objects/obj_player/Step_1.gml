if (has_fallen)
	return;
	
if (has_gun && controls.is_reload_pressed() 
	&& !is_reloading && bullets_count < cartrige_capacity
	&& sprite_index != spr_drop_weapon && sprite_index != sPlayerA ) {
	is_reloading = true;
	sprite_index = spr_reload;
	cancel_movement();
	if (is_aiming)
		remove_aiming_instance();
}

if (!is_aiming && !is_reloading && sprite_index != spr_drop_weapon)
	update_movement();

if (is_dead)
	return;

update_aim();