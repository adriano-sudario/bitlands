if (has_fallen)
	return;

var wall = instance_place(x + horizontal_force, y, obj_wall);
if (wall != noone) {
	if (horizontal_direction < 0)
		x = wall.bbox_right + (x - bbox_left) + 1;
	else if (horizontal_direction > 0)
		x = wall.bbox_left - (bbox_right - x) - 1;
	
	horizontal_force = 0;
}

wall = instance_place(x, y + vertical_force, obj_wall);
	
if (wall != noone) {
	var vertical_direction = sign(vertical_force);
	if (vertical_direction < 0)
		y = wall.bbox_bottom - (bbox_top - y) + 1;
	else if (vertical_direction > 0)
		y = wall.bbox_top + (y - bbox_bottom) - 1;
	
	vertical_force = 0;
	is_on_floor = vertical_direction > 0;
}

x += horizontal_force;
y += vertical_force;

if (is_dead && is_on_floor) {
	has_fallen = true;
	alarm[0] = 30;
}

if (is_dead) {
	sprite_index = sPlayerD;
	image_speed = 0;
	image_index = has_fallen ? 1 : 0;
	if (has_fallen) {
		//audio_sound_pitch(sfxLand, .5);
		//audio_play_sound(sfxLand, 5, false);
		repeat(30)
			with (instance_create_layer(x, bbox_bottom, layer, obj_particle)) {
				vertical_speed = 0;
				horizontal_speed = random_range(-10, 10);
				set_type(PARTICLE_TYPE.BLOOD);
			}
	}
} else if (!is_on_floor) {
	sprite_index = sPlayerA;
	image_speed = 0;
	image_index = vertical_force > 0 ? 1 : 0;
} else {
	if (sprite_index == sPlayerA) {
		//audio_sound_pitch(sfxLand, choose(.8, 1, 1.2));
		//audio_play_sound(sfxLand, 5, false);
		repeat(round(random_range(4, 7)))
			with (instance_create_layer(x, bbox_bottom, layer, obj_particle))
				vertical_speed = 0;
	}
	
	image_speed = 1;
	
	if (horizontal_direction != 0)
		sprite_index = sPlayerR;
	else if (!is_aiming && !is_reloading && sprite_index != spr_drop_weapon)
		sprite_index = sPlayer;
	
	//if (sprite_index == sPlayerR && image_index == 0)
	//	audio_play_sound(choose(sfxFoot1, sfxFoot2, sfxFoot3, sfxFoot4), 2, false);
}

if (horizontal_direction != 0) {
	image_xscale = horizontal_direction;
	
	if (!is_dead && aiming_instance != noone && !controls.is_disabled) {
		var is_looking_right = sign(aiming_instance.image_yscale) > 0;
		var is_walking_right = sign(horizontal_direction) > 0;
	
		if (is_looking_right != is_walking_right) {
			image_xscale = -image_xscale;
			image_speed = -1;
		}
	}
}