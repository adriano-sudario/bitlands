/// @function input_rollback_manager(player_id, is_gamepad);
/// @param {player_id} player's id
/// @param {is_gamepad} true if is using gamepad

function input_rollback_manager(_player_id, _is_gamepad) {
	return {
		is_gamepad: _is_gamepad,
		aiming_angle: 0,
		player_id: _player_id,
		current_input_state: rollback_get_input(_player_id),
		update_state: function() {
			current_input_state = rollback_get_input(player_id);
		},
		update_aiming_angle: function(_x, _y) {
			if (is_gamepad) {
				var _horizontal_axis = gamepad_axis_value(_input_id, current_input_state.gp_axislh);
				var _vertical_axis = gamepad_axis_value(_input_id, current_input_state.gp_axislv);
			
				if (abs(_horizontal_axis) > .5 || abs(_vertical_axis) > .5)
					aiming_angle = point_direction(0, 0, _horizontal_axis, _vertical_axis);
			} else {
				aiming_angle = point_direction(_x, _y,
					current_input_state.km_axisx, current_input_state.km_axisy);
			}
		},
		directional_check: function(_bind_keys, _is_left_or_up) {
			for (var i = 0; i < array_length(_bind_keys); i++) {
				var _is_checking_for_gp_axis = _bind_keys[i] == "gp_axislh"
					|| _bind_keys[i] == "gp_axislv";
				if (_is_checking_for_gp_axis) {
					if (_is_left_or_up && current_input_state[$ _bind_keys[i]] < -.5)
						return true;
					else if (!_is_left_or_up && current_input_state[$ _bind_keys[i]] > .5)
						return true;
				} else if (current_input_state[$ _bind_keys[i]]) {
					return true;
				}
			}
			
			return false;
		},
		held_check: function(_bind_keys) {
			for (var i = 0; i < array_length(_bind_keys); i++)
				if (current_input_state[$ _bind_keys[i]])
					return true;
					
			return false;
		},
		pressed_check: function(_bind_keys) {
			for (var i = 0; i < array_length(_bind_keys); i++)
				if (current_input_state[$ _bind_keys[i] + "_pressed"])
					return true;
					
			return false;
		},
		input_bind: {
			left: { gamepad: [gp_axislh, gp_padl], keyboard: [vk_left, "A"] },
			right: { gamepad: [gp_axislh, gp_padr], keyboard: [vk_right, "D"] },
			up: { gamepad: [gp_axislv, gp_padu], keyboard: [vk_up, "W"] },
			down: { gamepad: [gp_axislv, gp_padd], keyboard: [vk_down, "S"] },
			jump: { gamepad: gp_face1, keyboard: vk_space },
			aiming: { gamepad: gp_shoulderr, keyboard: mb_right },
			shooting: { gamepad: gp_face3, keyboard: mb_left },
			reload: { gamepad: gp_shoulderl, keyboard: mb_middle },
			select: { gamepad: [gp_face1, gp_start], keyboard: [vk_space, vk_enter] },
			enter: { gamepad: gp_start, keyboard: vk_enter },
			back: { gamepad: gp_face2, keyboard: [vk_escape, vk_backspace] },
		},
		is_left_held: function() { return directional_check(input_bind.left, true); },
		is_right_held: function() { return directional_check(input_bind.right, false); },
		is_up_held: function() { return directional_check(input_bind.up, true); },
		is_down_held: function() { return directional_check(input_bind.down, false); },
		is_jump_held: function() { return held_check(input_bind.jump); },
		is_aiming_held: function() { return held_check(input_bind.aiming); },
		is_shoot_pressed: function() { return pressed_check(input_bind.shooting); },
		is_reload_pressed: function() { return pressed_check(input_bind.reload); },
		is_select_pressed: function() { return pressed_check(input_bind.select); },
		is_enter_pressed: function() { return pressed_check(input_bind.enter); },
		is_back_pressed: function() { return pressed_check(input_bind.back); }
	};
}