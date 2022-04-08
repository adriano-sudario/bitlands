horizontal_force = 0;
vertical_force = 0;
grv = .3;
walk_speed = 4;
horizontal_direction = 0;
is_dead = false;
has_fallen_dead = false;
is_jump_held = false;
has_jump = false;
is_aiming = false;
is_reloading = false;
cartrige_capacity = 4;
cartrige = noone;
is_passing_through_plank = false;
bullets_count = cartrige_capacity;
has_gun = false;
aiming_instance = noone;
sprites_indexes = noone;
input = noone;
player_info = noone;

function is_input_enabled() {
	return !is_dead && !obj_shooting_room.has_match_ended && obj_shooting_room.has_begun;
}

function update_movement() {
	if (is_input_enabled()) {
		horizontal_direction = input.is_right_held() - input.is_left_held();
		horizontal_force = horizontal_direction * walk_speed;
	}

	var platform = instance_place(x, y + 1, obj_wall);
	is_on_floor = platform != noone && !is_passing_through_plank;
	var is_holding_jump = input.is_jump_held() && is_input_enabled();
	var is_leaving_plank = is_on_floor && platform.object_index == obj_plank
		&& is_holding_jump && input.is_down_held();
	
	if (is_leaving_plank) {
		is_on_floor = false;
		is_passing_through_plank = true;
		y++;
	}
	
	if (!is_input_enabled()) {
		vertical_force += grv;
		return;
	}
	
	var has_released_jump = is_jump_held && !is_holding_jump;
	is_jump_held = is_holding_jump;

	if (is_on_floor && !input.is_aiming_held()) {
		if (is_holding_jump && !has_jump) {
			vertical_force = JUMP_FORCE;
			has_jump = true;
		} else {
			if (has_jump && has_released_jump)
				has_jump = false;
			vertical_force = 0;
		}
	} else {
		vertical_force += grv;
		if (has_jump && has_released_jump) {
			var minimal_jump_force = -1.5;
			if (vertical_force < minimal_jump_force)
				vertical_force = minimal_jump_force;
			has_jump = false;
		}
	}
}

function update_aim() {
	if (!has_gun)
		return;
	
	if (input.is_aiming_held()) {
		if (is_reloading)
			is_aiming = true;
		else if (sprite_index != sprites_indexes.drop_weapon
			&& sprite_index != sprites_indexes.air
			&& !is_aiming) {
			sprite_index = sprites_indexes.drop_weapon;
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

function cancel_movement() {
	horizontal_force = 0;
	horizontal_direction = 0;
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
		aiming_instance = equip_gun(self);
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


