global.characters = [
	{ id: CHARACTER.SEVERINO, has_been_picked: false },
	{ id: CHARACTER.GERALDO, has_been_picked: false },
	{ id: CHARACTER.RAIMUNDO, has_been_picked: false },
	{ id: CHARACTER.SEBASTIAO, has_been_picked: false }
];
global.spawn_points = [];
	
for (var i = 0; i < instance_number(obj_player_spawn_point); i++;)
	with (instance_find(obj_player_spawn_point, i)) {
		global.spawn_points[i] = {
			order: order,
			x: x,
			y: y,
			image_xscale: image_xscale
		};
			
		instance_destroy();
	}

global.spawn_points = array_order_by(global.spawn_points, "order");

if (!rollback_join_game())
	rollback_create_game(4, false);