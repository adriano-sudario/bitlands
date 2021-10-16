spinning_speed = 15;
angle = 360;
owner = noone;
shake_params = noone;
image_angle = angle;

function spin_next_bullet() {
	if (angle <= 0) {
		return;
	}
	angle -= 90;
	image_index++;
}

function shake() {
	var _magnitude = 2;
	var _frames = 10;
	
	if (shake_params != noone && shake_params.current_magnitude > _magnitude)
		return;
			
	shake_params = {
		frames: _frames,
		magnitude: _magnitude,
		current_magnitude: _magnitude
	};
}