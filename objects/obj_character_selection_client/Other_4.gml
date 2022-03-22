if (!instance_exists(obj_client)) {
	instance_destroy();
	return;
}

for (var i = 0; i < 4; i++;)
	selections[i].spawn_point = instance_find(obj_player_spawn_point, i);

selections = array_order_by(selections, "spawn_point.order");

client = instance_find(obj_client, 0);
client.handler_object = self;