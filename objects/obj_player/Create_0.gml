#macro JUMP_FORCE -7

horizontal_force = 0;
vertical_force = 0;
grv = .3;
walk_speed = 4;
flash_frames = 0;
horizontal_direction = 0;
is_dead = false;
has_fallen = false;
is_jump_held = false;
has_jump = false;
is_aiming = false;
is_reloading = false;
cartrige_capacity = 4;
cartrige = noone;
bullets_count = cartrige_capacity;
controls = controller(0, true);
has_gun = false;
aiming_instance = noone;
sprites_indexes = obj_game.get_character_sprites(CHARACTER.SEBASTIAO);

function update_movement() {
	if (!is_dead) {
		if (!controls.is_disabled)
			horizontal_direction = controls.is_right_held() - controls.is_left_held();
		horizontal_force = horizontal_direction * walk_speed;
	}

	var was_on_floor = is_on_floor;
	is_on_floor = place_meeting(x, y + 1, obj_wall);
	var is_holding_jump = controls.is_jump_held();
	var has_released_jump = is_jump_held && !is_holding_jump;
	is_jump_held = is_holding_jump;

	if (!has_jump && was_on_floor && !is_on_floor)
		alarm[1] = 5;

	if (is_on_floor && !is_dead) {
		if (!controls.is_disabled && is_holding_jump && !has_jump) {
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
	
	if (controls.is_aiming_held()) {
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
	
	if (controls.is_disabled) {
		aiming_instance.image_angle = sign(horizontal_direction) > 0 ? 0 : 180;
		return;
	}
	
	controls.update_aiming_angle(x, y);
	aiming_instance.image_angle = controls.aiming_angle;
	if (controls.is_shoot_pressed() && controls.is_aiming_held()) {
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
		if (controls.input >= 0) {
			if (image_xscale < 0) {
				controls.aiming_angle = 180;
				aiming_instance.image_angle = 180;
			}
			else {
				controls.aiming_angle = 0;
				aiming_instance.image_angle = 0;
			}
		}
	}
}


