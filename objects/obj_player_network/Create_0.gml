horizontal_force = 0;
is_dead = false;
has_fallen_dead = false;
aiming_instance = noone;
cartrige_capacity = 4;
cartrige = noone;
bullets_count = cartrige_capacity;
player_info = noone;
socket = noone;
image_speed = 0;

function remove_aiming_instance() {
	with (aiming_instance)
		instance_destroy();
	
	with (cartrige)
		instance_destroy();
	
	aiming_instance = noone;
	cartrige = noone;
}

function insert_aiming_instance() {
	if (aiming_instance == noone) {
		aiming_instance = equip_gun(self);
		aiming_instance.is_manual_update = true;
		var cartrige_x = x;
		var catrige_y = y - 40;
		if (image_xscale > 0)
			cartrige_x += 5;
		cartrige = instance_create_layer(cartrige_x, catrige_y, layer, obj_cartrige);
		with (cartrige) {
			owner = other;
			image_index = other.cartrige_capacity - other.bullets_count;
			angle = 360 - (90 * image_index);
			image_angle = angle;
		}
	}
}

