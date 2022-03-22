if (!instance_exists(obj_client)) {
	instance_destroy();
	return;
}

client = instance_find(obj_client, 0);
client.handler_object = self;
client.send_packet(CLIENT_EVENT.JOIN_ROOM);