recoil = 0;
owner = noone;
aiming = {
	x: 0,
	y: 0,
	length: 3,
	target: noone
};

function shoot() {
	if (recoil == 0)
		recoil = 4;
		
	if (aiming.target == noone)
		return;
	
	//audio_sound_pitch(sfxShoot, choose(.8, 1, 1.2));
	//audio_play_sound(sfxShoot, 5, false);
	
	if (!layer_exists("Dusts"))
		layer_create(-1, "Dusts");
	
	var dust_x = aiming.x + lengthdir_x(aiming.length, image_angle);
	var dust_y = aiming.y + lengthdir_y(aiming.length, image_angle);
	
	var dust_direction = image_angle - 180;
	var direction_margin = 20;
	repeat(round(random_range(4, 7)))
		with (instance_create_layer(dust_x, dust_y, "Dusts", obj_particle)) {
			var dust_speed = random_range(1, 3);
			var dir = random_range(
				dust_direction - direction_margin,
				dust_direction + direction_margin);
			horizontal_speed = lengthdir_x(dust_speed, dir);
			vertical_speed = lengthdir_y(dust_speed, dir);
			set_type(other.aiming.target.terrain);
		}
}