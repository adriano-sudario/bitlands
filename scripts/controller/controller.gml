/// @function controller()

function controller(_input) {
	return {
		aiming_angle: 0,
		input: _input,
		is_left_held: function() {
			if (input >= 0)
				return gamepad_axis_value(input, gp_axislh) < -.5 
					|| gamepad_button_check(input, gp_padl);
			else
				return keyboard_check(vk_left) || keyboard_check(ord("A"));
		},
		is_right_held: function() {
			if (input >= 0)
				return gamepad_axis_value(input, gp_axislh) > .5 
					|| gamepad_button_check(input, gp_padr);
			else
				return keyboard_check(vk_right) || keyboard_check(ord("D"));
		},
		is_up_held: function() {
			if (input >= 0)
				return gamepad_axis_value(input, gp_axislv) < -.5 
					|| gamepad_button_check(input, gp_padu);
			else
				return keyboard_check(vk_up) || keyboard_check(ord("W"));
		},
		is_down_held: function() {
			if (input >= 0)
				return gamepad_axis_value(input, gp_axislv) > .5 
					|| gamepad_button_check(input, gp_padd);
			else
				return keyboard_check(vk_down) || keyboard_check(ord("S"));
		},
		is_jump_held: function() {
			if (input >= 0)
				return gamepad_button_check(input, gp_face1);
			else
				return keyboard_check(vk_space);
		},
		is_aiming_held: function() {
			if (input >= 0)
				return gamepad_button_check(input, gp_shoulderr);
			else
				return mouse_check_button(mb_right);
		},
		is_shoot_pressed: function() {
			if (input >= 0)
				return gamepad_button_check_pressed(input, gp_face3);
			else
				return mouse_check_button_pressed(mb_left);
		},
		is_reload_pressed: function() {
			if (input >= 0)
				return gamepad_button_check_pressed(input, gp_shoulderl);
			else
				return mouse_check_button_pressed(mb_middle);
		},
		update_aiming_angle: function(_x, _y) {
			if (input >= 0) {
				var horizontal_axis = gamepad_axis_value(input, gp_axislh);
				var vertical_axis = gamepad_axis_value(input, gp_axislv);
			
				if (abs(horizontal_axis) > .5 || abs(vertical_axis) > .5)
					aiming_angle = point_direction(0, 0, 
						horizontal_axis, vertical_axis);
			}
			else {
				aiming_angle = point_direction(_x, _y, mouse_x, mouse_y);
			}
		},
		is_select_pressed: function() {
			if (input >= 0)
				return gamepad_button_check_pressed(input, gp_face1);
			else
				return keyboard_check_pressed(vk_space) || 
					keyboard_check_pressed(vk_enter);
		},
		is_enter_pressed: function() {
			if (input >= 0)
				return gamepad_button_check_pressed(input, gp_start);
			else
				return keyboard_check_pressed(vk_enter);
		},
		is_back_pressed: function() {
			if (input >= 0)
				return gamepad_button_check_pressed(input, gp_face2);
			else
				return keyboard_check_pressed(vk_escape);
		}
	};
}