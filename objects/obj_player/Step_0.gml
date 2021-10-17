if (has_fallen)
	return;
	
if (is_passing_through_plank)
	is_passing_through_plank = place_meeting(x, y, obj_plank);

var horizontal_blocks = ds_list_create();
instance_place_list(x + horizontal_force, y, obj_wall, horizontal_blocks, false);

for (var i = 0; i < ds_list_size(horizontal_blocks); ++i;)
{
	var horizontal_block = horizontal_blocks[| i];
	if (horizontal_block.object_index == obj_plank) {
		is_passing_through_plank = true;
	} else {
		if (horizontal_direction < 0)
			x = horizontal_block.bbox_right + (x - bbox_left) + 1;
		else if (horizontal_direction > 0)
			x = horizontal_block.bbox_left - (bbox_right - x) - 1;
	
		horizontal_force = 0;
	}
}

var vertical_blocks = ds_list_create();
instance_place_list(x, y + vertical_force, obj_wall, vertical_blocks, false);

for (var i = 0; i < ds_list_size(vertical_blocks); ++i;)
{
	var vertical_block = vertical_blocks[| i];
	var vertical_direction = sign(vertical_force);
	if (vertical_direction < 0) {
		if (vertical_block.object_index == obj_plank)
			is_passing_through_plank = true;
		else
			y = vertical_block.bbox_bottom - (bbox_top - y) + 1;
	} else if (vertical_direction > 0 && !is_passing_through_plank) {
		y = vertical_block.bbox_top + (y - bbox_bottom) - 1;
	}
	
	if (!is_passing_through_plank) {
		vertical_force = 0;
		is_on_floor = vertical_direction > 0;
	}
}

ds_list_destroy(horizontal_blocks);
ds_list_destroy(vertical_blocks);

x += horizontal_force;
y += vertical_force;

if (is_dead && is_on_floor) {
	has_fallen = true;
	alarm[0] = 30;
}

if (is_dead) {
	sprite_index = sprites_indexes.dead;
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
	sprite_index = sprites_indexes.air;
	image_speed = 0;
	image_index = vertical_force > 0 ? 1 : 0;
} else {
	if (sprite_index == sprites_indexes.air && !is_passing_through_plank) {
		//audio_sound_pitch(sfxLand, choose(.8, 1, 1.2));
		//audio_play_sound(sfxLand, 5, false);
		repeat(round(random_range(4, 7)))
			with (instance_create_layer(x, bbox_bottom, layer, obj_particle))
				vertical_speed = 0;
	}
	
	image_speed = 1;
	
	if (horizontal_direction != 0)
		sprite_index = sprites_indexes.run;
	else if (!is_aiming && !is_reloading 
		&& sprite_index != sprites_indexes.drop_weapon)
		sprite_index = sprites_indexes.idle;
	
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