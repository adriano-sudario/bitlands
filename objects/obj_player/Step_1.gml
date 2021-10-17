if (has_fallen || obj_shooting_room.has_match_ended)
	return;
	
if (has_gun && controls.is_reload_pressed() 
	&& !is_reloading && bullets_count < cartrige_capacity
	&& sprite_index != sprites_indexes.drop_weapon
	&& sprite_index != sprites_indexes.air ) {
	is_reloading = true;
	sprite_index = sprites_indexes.reload;
	cancel_movement();
	if (is_aiming)
		remove_aiming_instance();
}

if (!is_aiming && !is_reloading && sprite_index != sprites_indexes.drop_weapon)
	update_movement();

if (is_dead)
	return;

update_aim();