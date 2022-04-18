if (other.has_gun)
	return;

array_push(obj_shooting_room_host.guns_to_remove, { x: x, y: y })
other.has_gun = true;
instance_destroy();
