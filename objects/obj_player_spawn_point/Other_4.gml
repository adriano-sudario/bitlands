if (player != noone)
	array_insert(obj_shooting_room.players, 
		array_length(obj_shooting_room.players), player);
		
instance_destroy();