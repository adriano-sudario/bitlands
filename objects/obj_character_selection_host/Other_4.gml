for (var i = 0; i < 4; i++;)
	selections[i].spawn_point = instance_find(obj_player_spawn_point, i);

selections = array_order_by(selections, "spawn_point.order");

var client_selection = selections[0];
select_input(client_selection);