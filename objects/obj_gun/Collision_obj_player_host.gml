if (other.has_gun)
	return;

send_packet(other.socket, NETWORK_EVENT.UPDATE, { event: SHOOTING_CLIENT_EVENT.PICKUP_GUN, x: x, y: y });
other.has_gun = true;
instance_destroy();
