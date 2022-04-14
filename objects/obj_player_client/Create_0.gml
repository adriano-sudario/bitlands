is_dead = false;
has_fallen_dead = false;
is_aiming = false;
is_reloading = false;
cartrige_capacity = 4;
cartrige = noone;
bullets_count = cartrige_capacity;
has_gun = false;
aiming_instance = noone;
sprites_indexes = noone;
player_info = noone;
input = input_manager();
socket = noone;

function update_aim() {
	if (!has_gun)
		return;
	
	if (input.is_aiming_held()) {
		if (is_reloading)
			is_aiming = true;
		else if (sprite_index != sprites_indexes.draw_gun
			&& sprite_index != sprites_indexes.air
			&& !is_aiming) {
			sprite_index = sprites_indexes.draw_gun;
			cancel_movement();
		}
	} else {
		if (is_aiming) {
			is_aiming = false;
			if (!is_reloading) {
				sprite_index = sprites_indexes.idle;
				remove_aiming_instance()
			}
		}
		return;
	}
	
	if (aiming_instance == noone || is_reloading)
		return;
	
	input.update_aiming_angle(x, y);
	aiming_instance.image_angle = input.aiming_angle;
	if (input.is_shoot_pressed() && input.is_aiming_held()) {
		if (bullets_count > 0) {
			aiming_instance.shoot();
			bullets_count--;
			cartrige.spin_next_bullet();
		} else {
			cartrige.shake();
		}
	}
}

function remove_aiming_instance() {
	with (aiming_instance)
		instance_destroy();
	aiming_instance = noone;
	
	with (cartrige)
		instance_destroy();
	cartrige = noone;
	
	if (!input.is_gamepad && obj_game.show_aim)
		with(obj_target)
			instance_destroy();
}

function begin_aiming() {
	if (aiming_instance == noone) {
		is_aiming = true;
		aiming_instance = aim(self);
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
		sprite_index = sprites_indexes.aim;
		if (input.is_gamepad) {
			if (image_xscale < 0) {
				input.aiming_angle = 180;
				aiming_instance.image_angle = 180;
			}
			else {
				input.aiming_angle = 0;
				aiming_instance.image_angle = 0;
			}
		} else if (obj_game.show_aim) {
			instance_create_layer(mouse_x, mouse_y, layer, obj_target);
		}
	}
}


