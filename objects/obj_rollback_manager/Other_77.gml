//players_in_room_count = rollback_event_param.num_players;

//if (rollback_event_param.first_start) {
//	var _spawn_points =  [];
	
//	for (var i = 0; i < instance_number(obj_player_spawn_point); i++;)
//		_spawn_points[i] = instance_find(obj_player_spawn_point, i);

//	_spawn_points = array_order_by(_spawn_points, "order");
	
//	for (var i = 0; i < array_length(_spawn_points); i++;) {
//		with (_spawn_points[i]) {
//			with (instance_find(obj_player_rollback, i)) {
//				x = other.x;
//				y = other.y;
//				show_message(string(x) + " ~ " + string(other.x));
//			}
			
//			instance_destroy();
//		}
//	}
//}