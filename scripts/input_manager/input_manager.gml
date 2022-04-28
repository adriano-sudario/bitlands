/// @function input_manager(input_id);
/// @param {input_id} -1: keyboard / 0~3: gamepads

function input_manager(_input_id = noone) {
	return {
		input_id: _input_id,
		input_id_used: _input_id,
		is_gamepad: _input_id != noone && _input_id >= 0,
		aiming_angle: 0,
		check_all_inputs: function(_bind_type, _gamepad_check, _keyboard_check) {
			var inputs = [-1, 0, 1, 2, 3];
			var is_true = false;
			
			for (var i = 0; i < array_length(inputs); i++) {
				input_id = inputs[i];
				
				if (input_id < 0) {
					is_true = _keyboard_check(_bind_type.keyboard);
					if (is_true)
						is_gamepad = false;
					input_id_used = input_id;
				} else {
					is_true = _gamepad_check(_bind_type.gamepad);
					if (is_true)
						is_gamepad = true;
					is_gamepad = is_true;
					input_id_used = input_id;
				}
				
				if (is_true)
					break;
			}
			
			input_id = noone;
			return is_true;
		},
		update_all_aiming_angle: function(_x, _y) {
			var _inputs = [-1, 0, 1, 2, 3];
			
			for (var i = 0; i < array_length(_inputs); i++) {
				var _input_id = _inputs[i];
				if (_input_id < 0) {
					if (is_gamepad)
						continue;
					update_keyboard_aiming_angle(_x, _y);
					input_id_used = _input_id;
				} else if (update_gamepad_aiming_angle(_input_id)) {
					input_id_used = _input_id;
					break;
				}
			}
		},
		update_gamepad_aiming_angle: function(_input_id) {
			var horizontal_axis = gamepad_axis_value(_input_id, gp_axislh);
			var vertical_axis = gamepad_axis_value(_input_id, gp_axislv);
			
			if (abs(horizontal_axis) > .5 || abs(vertical_axis) > .5) {
				aiming_angle = point_direction(0, 0, horizontal_axis, vertical_axis);
				return true;
			}
		},
		update_keyboard_aiming_angle: function(_x, _y) {
			aiming_angle = point_direction(_x, _y, mouse_x, mouse_y);
		},
		update_aiming_angle: function(_x, _y) {
			if (input_id == noone)
				update_all_aiming_angle(_x, _y);
			else if (input_id >= 0)
				update_gamepad_aiming_angle(input_id);
			else
				update_keyboard_aiming_angle(_x, _y);
		},
		directional_gamepad_check: function(_bind_key) {
			if (_bind_key[1] == gp_padl || _bind_key[1] == gp_padu)
				var axis_result = gamepad_axis_value(input_id, _bind_key[0]) < -.5;
			else
				var axis_result = gamepad_axis_value(input_id, _bind_key[0]) > .5;
			
			return axis_result || gamepad_button_check(input_id, _bind_key[1]);
		},
		directional_keyboard_check: function(_bind_key) {
			return keyboard_check(_bind_key[0]) || keyboard_check(ord(_bind_key[1]));
		},
		directional_check: function(_bind_type) {
			if (input_id == noone)
				return check_all_inputs(_bind_type,
					directional_gamepad_check, directional_keyboard_check);
			else if (input_id >= 0)
				return directional_gamepad_check(_bind_type.gamepad);
			else
				return directional_keyboard_check(_bind_type.keyboard);
		},
		held_gamepad_check: function(_bind_key) {
			if (typeof(_bind_key) == "array") {
				for (var i = 0; i < array_length(_bind_key); i++)
					if (gamepad_button_check(input_id, _bind_key[i]))
						return true;
					
				return false;
			}
				
			return gamepad_button_check(input_id, _bind_key);
		},
		held_keyboard_check: function(_bind_key) {
			if (_bind_key == mb_any || _bind_key == mb_left || _bind_key == mb_middle  ||
				_bind_key == mb_none || _bind_key == mb_right || _bind_key == mb_side1 || 
				_bind_key == mb_side2)
				var check_function = mouse_check_button;
			else
				var check_function = keyboard_check;
			
			if (typeof(_bind_key) == "array") {
				for (var i = 0; i < array_length(_bind_key); i++) {
					var type = typeof(_bind_key);
					if ((type == "string" && check_function(ord(_bind_key[i]))) ||
						(type != "string" && check_function(_bind_key[i])))
						return true;
				}
					
				return false;
			}
				
			if (typeof(_bind_key) == "string")
				return check_function(ord(_bind_key));
			else
				return check_function(_bind_key);
		},
		held_check: function(_bind_type) {
			if (input_id == noone)
				return check_all_inputs(_bind_type, held_gamepad_check, held_keyboard_check);
			else if (input_id >= 0)
				return held_gamepad_check(_bind_type.gamepad);
			else
				return held_keyboard_check(_bind_type.keyboard);
		},
		pressed_gamepad_check: function(_bind_key) {
			if (typeof(_bind_key) == "array") {
				for (var i = 0; i < array_length(_bind_key); i++)
					if (gamepad_button_check_pressed(input_id, _bind_key[i]))
						return true;
					
				return false;
			}
				
			return gamepad_button_check_pressed(input_id, _bind_key);
		},
		pressed_keyboard_check: function(_bind_key) {
			if (_bind_key == mb_any || _bind_key == mb_left || _bind_key == mb_middle  ||
				_bind_key == mb_none || _bind_key == mb_right || _bind_key == mb_side1 || 
				_bind_key == mb_side2)
				var check_function = mouse_check_button_pressed;
			else
				var check_function = keyboard_check_pressed;
			
			if (typeof(_bind_key) == "array") {
				for (var i = 0; i < array_length(_bind_key); i++) {
					var type = typeof(_bind_key);
					if ((type == "string" && check_function(ord(_bind_key[i]))) ||
						(type != "string" && check_function(_bind_key[i])))
						return true;
				}
					
				return false;
			}
				
			if (typeof(_bind_key) == "string")
				return check_function(ord(_bind_key));
			else
				return check_function(_bind_key);
		},
		pressed_check: function(_bind_type) {
			if (input_id == noone)
				return check_all_inputs(_bind_type, pressed_gamepad_check, pressed_keyboard_check);
			else if (input_id >= 0)
				return pressed_gamepad_check(_bind_type.gamepad);
			else
				return pressed_keyboard_check(_bind_type.keyboard);
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
		is_left_held: function() { return directional_check(input_bind.left); },
		is_right_held: function() { return directional_check(input_bind.right); },
		is_up_held: function() { return directional_check(input_bind.up); },
		is_down_held: function() { return directional_check(input_bind.down); },
		is_jump_held: function() { return held_check(input_bind.jump); },
		is_aiming_held: function() { return held_check(input_bind.aiming); },
		is_shoot_pressed: function() { return pressed_check(input_bind.shooting); },
		is_reload_pressed: function() { return pressed_check(input_bind.reload); },
		is_select_pressed: function() { return pressed_check(input_bind.select); },
		is_enter_pressed: function() { return pressed_check(input_bind.enter); },
		is_back_pressed: function() { return pressed_check(input_bind.back); }
	};
}