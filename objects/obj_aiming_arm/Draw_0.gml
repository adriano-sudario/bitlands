draw_self();
if (obj_game.show_aim)
	draw_sprite_ext(spr_aim, 0, aiming.x, aiming.y,
		(1 / 3) * aiming.length, 1, image_angle, image_blend, image_alpha);