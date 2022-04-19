horizontal_force = 0;
is_dead = false;
has_fallen_dead = false;
aiming_instance = noone;
cartridge_capacity = 4;
cartridge = noone;
bullets_count = cartridge_capacity;
player_info = noone;
socket = noone;
image_speed = 0;

function remove_aiming_instance() {
	with (aiming_instance)
		instance_destroy();
	
	with (cartridge)
		instance_destroy();
	
	aiming_instance = noone;
	cartridge = noone;
}

function insert_aiming_instance() {
	if (aiming_instance == noone) {
		aiming_instance = aim(self);
		aiming_instance.is_update_disabled = true;
		var cartridge_x = x;
		var catrige_y = y - 40;
		if (image_xscale > 0)
			cartridge_x += 5;
		cartridge = instance_create_layer(cartridge_x, catrige_y, layer, obj_cartridge);
		with (cartridge) {
			owner = other;
			image_index = other.cartridge_capacity - other.bullets_count;
			angle = 360 - (90 * image_index);
			image_angle = angle;
		}
	}
}

