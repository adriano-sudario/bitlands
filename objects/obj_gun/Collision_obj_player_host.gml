if (other.has_gun)
	return;

array_push(obj_shooting_room_host.guns_to_remove, { x: starting_position.x, y: starting_position.y });
other.has_gun = true;
instance_destroy();
