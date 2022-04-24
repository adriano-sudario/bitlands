update_host();

for (var i = 0; i < array_length(clients); i++)
	if (clients[i].is_dead)
		clients[i].update_movement();
