if (image_angle > 90 && image_angle <= 270)
	image_yscale = -1;
else
	image_yscale = 1;

recoil = max(0, recoil -1);

x -= lengthdir_x(recoil, image_angle);
y -= lengthdir_y(recoil, image_angle);

aiming = {
	x: x + lengthdir_x(sprite_width, image_angle)
		+ (image_yscale > 0 ? lengthdir_y(4, image_angle)
			: -lengthdir_y(1, image_angle)),
	y: y + lengthdir_y(sprite_width, image_angle) 
		+ (image_yscale > 0 ? -lengthdir_x(4, image_angle)
		: lengthdir_x(1, image_angle)),
	length: room_width,
	target: noone
};

if (owner == noone)
	return;
	
var endline_x = aiming.x + lengthdir_x(aiming.length, image_angle);
var endline_y = aiming.y + lengthdir_y(aiming.length, image_angle);

var target = noone;
	
var list = ds_list_create();
var targets_found_count = collision_line_list(aiming.x, aiming.y,
	endline_x, endline_y, obj_wall, false, true, list, true);
if (targets_found_count > 0)
	target = list[| 0];
	
if (target != noone) {
	aiming.target = target;
	
	aiming.length = 0;
	var wall_id = target.id;
	target = noone
	
	while (target == noone) {
		aiming.length++;
		endline_x = aiming.x + lengthdir_x(aiming.length, image_angle);
		endline_y = aiming.y + lengthdir_y(aiming.length, image_angle);

		target = collision_line(aiming.x, aiming.y, 
			endline_x, endline_y,
			wall_id, true, false);
	}
}
	
if (image_yscale < 0)
	owner.image_xscale = -1;
else
	owner.image_xscale = 1;