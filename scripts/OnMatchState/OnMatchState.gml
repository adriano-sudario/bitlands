function OnMatchState(_sprites_indexes) : State() constructor {
	horizontal_force = 0;
	vertical_force = 0;
	grv = .3;
	walk_speed = 4;
	horizontal_direction = 0;
	is_dead = false;
	has_fallen_dead = false;
	is_jump_held = false;
	
	with (owner)
		other.is_on_floor = place_meeting(x, y + 1, obj_wall);
	
	has_jump = false;
	is_aiming = false;
	aiming_angle = 0;
	is_reloading = false;
	cartridge_capacity = 4;
	cartridge = noone;
	is_passing_through_plank = false;
	bullets_count = cartridge_capacity;
	has_gun = false;
	aiming_instance = noone;
	sprites_indexes = _sprites_indexes;
	input = new InputManagerRollback(owner.player_id, owner);

	function is_input_enabled() {
		return !is_dead && obj_rollback_manager.state.has_begun;
	}

	function update_movement() {
		if (is_input_enabled()) {
			horizontal_direction = input.state.is_right_held - input.state.is_left_held;
			horizontal_force = horizontal_direction * walk_speed;
		}

		var _platform = noone;
		
		with (owner)
			_platform = instance_place(x, y + 1, obj_wall);
		
		is_on_floor = _platform != noone && !is_passing_through_plank;
		var _is_holding_jump = input.state.is_jump_held && is_input_enabled();
		var _is_leaving_plank = is_on_floor && _platform.object_index == obj_plank
			&& _is_holding_jump && input.state.is_down_held;
	
		if (_is_leaving_plank) {
			is_on_floor = false;
			is_passing_through_plank = true;
			owner.y++;
		}
	
		if (!is_input_enabled()) {
			vertical_force += grv;
			return;
		}
	
		var _has_released_jump = is_jump_held && !_is_holding_jump;
		is_jump_held = _is_holding_jump;

		if (is_on_floor && !input.state.is_aiming_held) {
			if (_is_holding_jump && !has_jump) {
				vertical_force = JUMP_FORCE;
				has_jump = true;
			} else {
				if (has_jump && _has_released_jump)
					has_jump = false;
				
				vertical_force = 0;
			}
		} else {
			vertical_force += grv;
			
			if (has_jump && _has_released_jump) {
				var minimal_jump_force = -1.5;
				
				if (vertical_force < minimal_jump_force)
					vertical_force = minimal_jump_force;
				
				has_jump = false;
			}
		}
	}
	
	function update_aiming_angle() {
		if (input.is_gamepad) {
			var _horizontal_axis = input.rollback_input[$ input.bind.aiming_angle_horizontal.gamepad];
			var _vertical_axis = input.rollback_input[$ input.bind.aiming_angle_vertical.gamepad];
			
			if (abs(_horizontal_axis) > .5 || abs(_vertical_axis) > .5)
				aiming_angle = point_direction(0, 0, _horizontal_axis, _vertical_axis);
		} else {
			var _mouse_x = input.rollback_input[$ input.bind.aiming_angle_horizontal.keyboard_and_mouse];
			var _mouse_y = input.rollback_input[$ input.bind.aiming_angle_vertical.keyboard_and_mouse];
			aiming_angle = point_direction(owner.x, owner.y, _mouse_x, _mouse_y);
		}
	}

	function update_aim() {
		if (!has_gun)
			return;
	
		if (input.state.is_aiming_held) {
			if (is_reloading) {
				is_aiming = true;
			} else if (owner.sprite_index != sprites_indexes.draw_gun
				&& owner.sprite_index != sprites_indexes.air
				&& !is_aiming) {
				owner.sprite_index = sprites_indexes.draw_gun;
				cancel_movement();
			}
		} else {
			if (is_aiming) {
				is_aiming = false;
				
				if (!is_reloading) {
					owner.sprite_index = sprites_indexes.idle;
					remove_aiming_instance()
				}
			}
			
			return;
		}
	
		if (aiming_instance == noone || is_reloading)
			return;
		
		update_aiming_angle();
		aiming_instance.image_angle = aiming_angle;
		
		if (input.state.is_shoot_pressed && input.state.is_aiming_held) {
			if (bullets_count > 0) {
				aiming_instance.shoot(true);
				bullets_count--;
				cartridge.spin_next_bullet();
			} else {
				cartridge.shake();
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
	
		with (cartridge)
			instance_destroy();
		
		cartridge = noone;
	
		if (instance_exists(obj_target))
			with(obj_target)
				instance_destroy();
	}

	function begin_aiming() {
		if (aiming_instance != noone)
			return;
		
		is_aiming = true;
		aiming_instance = aim(owner, true);
		var _cartridge_x = owner.x;
		var _catrige_y = owner.y - 40;
			
		if (owner.image_xscale > 0)
			_cartridge_x += 5;
			
		cartridge = instance_create_layer(_cartridge_x, _catrige_y, owner.layer, obj_cartridge);
			
		with (cartridge) {
			owner = other.owner;
			image_index = owner.state.cartridge_capacity - owner.state.bullets_count;
			angle = 360 - (90 * image_index);
			image_angle = angle;
		}
			
		owner.sprite_index = sprites_indexes.aim;
			
		if (input.is_gamepad) {
			if (owner.image_xscale < 0) {
				aiming_angle = 180;
				aiming_instance.image_angle = 180;
			} else {
				aiming_angle = 0;
				aiming_instance.image_angle = 0;
			}
		} else if (owner.player_local) {
			instance_create_layer(mouse_x, mouse_y, "Helpers", obj_target);
		}
	}

	function on_begin_step() {
		if (has_fallen_dead || instanceof(obj_rollback_manager.state) != "MatchManagerState")
			return;
		
		input.Update();
		
		if (!is_aiming && !is_reloading 
			&& owner.sprite_index != sprites_indexes.draw_gun)
			update_movement();
	
		if (!is_input_enabled())
			return;

		if (has_gun && input.state.is_reload_pressed
			&& !is_reloading && bullets_count < cartridge_capacity
			&& owner.sprite_index != sprites_indexes.draw_gun
			&& owner.sprite_index != sprites_indexes.air) {
			is_reloading = true;
			owner.sprite_index = sprites_indexes.reload;
			cancel_movement();
			
			if (is_aiming)
				remove_aiming_instance();
		}

		update_aim();
	}
	
	function on_step() {
		if (has_fallen_dead)
			return;

		if (is_passing_through_plank)
			with(owner)
				other.is_passing_through_plank = place_meeting(x, y, obj_plank);

		var _horizontal_blocks = ds_list_create();
		
		with (owner)
			instance_place_list(
				x + other.horizontal_force, y, obj_wall, _horizontal_blocks, false);

		for (var i = 0; i < ds_list_size(_horizontal_blocks); ++i;)
		{
			var _horizontal_block = _horizontal_blocks[| i];
			
			if (_horizontal_block.object_index == obj_plank) {
				is_passing_through_plank = true;
			} else {
				if (horizontal_direction < 0)
					owner.x = _horizontal_block.bbox_right + (owner.x - owner.bbox_left) + 1;
				else if (horizontal_direction > 0)
					owner.x = _horizontal_block.bbox_left - (owner.bbox_right - owner.x) - 1;
	
				horizontal_force = 0;
			}
		}

		var _vertical_blocks = ds_list_create();
		
		with (owner)
			instance_place_list(x, y + other.vertical_force, obj_wall, _vertical_blocks, false);

		for (var i = 0; i < ds_list_size(_vertical_blocks); ++i;)
		{
			var _vertical_block = _vertical_blocks[| i];
			var _vertical_direction = sign(vertical_force);
			
			if (_vertical_direction < 0) {
				if (_vertical_block.object_index == obj_plank)
					is_passing_through_plank = true;
				else
					y = _vertical_block.bbox_bottom - (owner.bbox_top - owner.y) + 1;
			} else if (_vertical_direction > 0 && !is_passing_through_plank) {
				y = _vertical_block.bbox_top + (owner.y - owner.bbox_bottom) - 1;
			}
	
			if (!is_passing_through_plank) {
				vertical_force = 0;
				is_on_floor = _vertical_direction > 0;
			}
		}

		ds_list_destroy(_horizontal_blocks);
		ds_list_destroy(_vertical_blocks);

		owner.x += horizontal_force;
		owner.y += vertical_force;

		if (is_dead && is_on_floor) {
			has_fallen_dead = true;
			owner.image_speed = 1;
			cancel_movement();
		}

		if (is_dead) {
			owner.sprite_index = sprites_indexes.dead;
	
			if (vertical_force < 0) {
				if (owner.image_index > 2)
					owner.image_index = 2;
			} else {
				if (owner.image_index < 3 || owner.image_index > 4)
					owner.image_index = 3;
			}
		} else if (!is_on_floor) {
			owner.sprite_index = sprites_indexes.air;
			owner.image_speed = 0;
			owner.image_index = vertical_force > 0 ? 1 : 0;
		} else {
			if (owner.sprite_index == sprites_indexes.air && !is_passing_through_plank) {
				repeat(round(random_range(4, 7)))
					with (instance_create_layer(
						owner.x, owner.bbox_bottom, owner.layer, obj_particle))
						vertical_speed = 0;
			}
	
			owner.image_speed = 1;
	
			if (horizontal_direction != 0)
				owner.sprite_index = sprites_indexes.run;
			else if (!is_aiming && !is_reloading 
				&& owner.sprite_index != sprites_indexes.draw_gun)
				owner.sprite_index = sprites_indexes.idle;
		}

		if (horizontal_direction != 0) {
			owner.image_xscale = is_dead ? -horizontal_direction : horizontal_direction;
	
			if (!is_dead && aiming_instance != noone) {
				var _is_looking_right = sign(aiming_instance.image_yscale) > 0;
				var _is_walking_right = sign(horizontal_direction) > 0;
	
				if (_is_looking_right != _is_walking_right) {
					owner.image_xscale = -owner.image_xscale;
					owner.image_speed = -1;
				}
			}
		}
	}
	
	function on_animation_end() {
		if (owner.sprite_index == sprites_indexes.draw_gun) {
			begin_aiming();
		} else if (owner.sprite_index == sprites_indexes.reload) {
			bullets_count = cartridge_capacity;
			is_reloading = false;
			
			if (is_aiming)
				begin_aiming();
		} else if (owner.sprite_index == sprites_indexes.dead) {
			owner.image_speed = 0;
			owner.image_index = sprite_get_number(sprites_indexes.dead) - 1;
		}
	}
}