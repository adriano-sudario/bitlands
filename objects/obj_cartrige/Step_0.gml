if (owner != noone) {
	if (owner.image_xscale > 0)
		x = owner.x + 5;
	else
		x = owner.x - 2;
	y = owner.y - 40;
}

if (image_angle != angle) {
	image_angle -= spinning_speed;
	if (image_angle < angle)
		image_angle = angle;
}

if (shake_params != noone) {
	x += random_range(-shake_params.current_magnitude,
		shake_params.current_magnitude);
	y += random_range(-shake_params.current_magnitude,
		shake_params.current_magnitude);
	shake_params.current_magnitude -= max(0, (1 / shake_params.frames) 
		* shake_params.magnitude);
	if (shake_params.current_magnitude <= 0)
		shake_params = noone;
}