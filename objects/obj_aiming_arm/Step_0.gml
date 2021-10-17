function set_target(_target) {
	aiming.target = _target;
	
	aiming.length = 0;
	var target_id = _target.id;
	_target = noone
	
	var endline_x = aiming.x + lengthdir_x(aiming.length, image_angle);
	var endline_y = aiming.y + lengthdir_y(aiming.length, image_angle);
	
	while (_target == noone) {
		aiming.length++;
		endline_x = aiming.x + lengthdir_x(aiming.length, image_angle);
		endline_y = aiming.y + lengthdir_y(aiming.length, image_angle);

		_target = collision_line(aiming.x, aiming.y, 
			endline_x, endline_y,
			target_id, false, false);
	}
	
	aiming.endline_x = endline_x;
	aiming.endline_y = endline_y;
}

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

var blocks_found = ds_list_create();
collision_line_list(aiming.x, aiming.y, endline_x, endline_y,
	obj_wall, false, true, blocks_found, true);

for (var i = 0; i < ds_list_size(blocks_found); i++) {
	var item = blocks_found[| i];
	if (item.object_index != obj_plank) {
		target = item;
		break;
	}
}

ds_list_destroy(blocks_found);

var targets_found = ds_list_create();
collision_line_list(aiming.x, aiming.y,
	endline_x, endline_y, obj_player, false, false, targets_found, true);
var enemy_on_target = noone;

for (var i = 0; i < ds_list_size(targets_found); i++) {
	var item = targets_found[| i];
	if (item.id != owner.id) {
		enemy_on_target = item;
		break;
	}
}
	
if (target != noone)
	set_target(target);

if (enemy_on_target != noone && 
	collision_line(aiming.x, aiming.y, endline_x, endline_y,
		enemy_on_target.id, false, false))
	set_target(enemy_on_target);
	
if (image_yscale < 0)
	owner.image_xscale = -1;
else
	owner.image_xscale = 1;