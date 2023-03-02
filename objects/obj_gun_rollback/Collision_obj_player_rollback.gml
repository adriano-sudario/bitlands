if (other.state.has_gun)
	return;

other.state.has_gun = true;
instance_destroy();