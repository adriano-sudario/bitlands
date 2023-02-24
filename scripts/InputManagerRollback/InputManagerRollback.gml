function InputManagerRollback(_id = undefined, _owner = other) constructor {
	owner = _owner;
	input_id = _id;
	is_gamepad = false;
	dead_zone = .5;
	rollback_previous_input = undefined;
	rollback_input = undefined;
	state = undefined;
	
	function _updateRollbackInput() {
		rollback_previous_input = rollback_input;
		
		if (input_id == undefined)
			with (owner)
				other.rollback_input = rollback_get_input();
		else
			rollback_input = rollback_get_input(input_id);
	}
	
	if (_id != noone)
		_updateRollbackInput();
	
	state = undefined;
	
	static Setup = function() {
		rollback_define_input({
			gamepad_left_horizontal_axis: gp_axislh,
			gamepad_left_vertical_axis: gp_axislv,
			gamepad_right_horizontal_axis: gp_axisrh,
			gamepad_right_vertical_axis: gp_axisrv,
			gamepad_directional_left: gp_padl,
			gamepad_directional_right: gp_padr,
			gamepad_directional_up: gp_padu,
			gamepad_directional_down: gp_padd,
			gamepad_shoulder_right: gp_shoulderr,
			gamepad_shoulder_left: gp_shoulderl,
			gamepad_face_one: gp_face1,
			gamepad_face_two: gp_face2,
			gamepad_face_three: gp_face3,
			gamepad_start: gp_start,
			
			mouse_horizontal_axis: m_axisx,
		    mouse_vertical_axis: m_axisy,
		    mouse_button_left: mb_left,
			mouse_button_middle: mb_middle,
		    mouse_button_right: mb_right,
			
			keyboard_left: vk_left,
			keyboard_right: vk_right,
			keyboard_up: vk_up,
			keyboard_down: vk_down,
			keyboard_a: ord("A"),
			keyboard_d: ord("D"),
			keyboard_w: ord("W"),
			keyboard_s: ord("S"),
			keyboard_space: vk_space,
			keyboard_enter: vk_enter,
			keyboard_escape: vk_escape,
			keyboard_backspace: vk_backspace,
		});
	}
	
	bind = {
		left: {
			gamepad: ["gamepad_left_horizontal_axis", "gamepad_directional_left"],
			keyboard_and_mouse: ["keyboard_left", "keyboard_a"]
		},
		right: {
			gamepad: ["gamepad_left_horizontal_axis", "gamepad_directional_right"],
			keyboard_and_mouse: ["keyboard_right", "keyboard_d"]
		},
		up: {
			gamepad: ["gamepad_left_vertical_axis", "gamepad_directional_up"],
			keyboard_and_mouse: ["keyboard_up", "keyboard_w"]
		},
		down: {
			gamepad: ["gamepad_left_vertical_axis", "gamepad_directional_down"],
			keyboard_and_mouse: ["keyboard_down", "keyboard_s"]
		},
		select: {
			gamepad: ["gamepad_face_one", "gamepad_start"],
			keyboard_and_mouse: ["keyboard_space", "keyboard_enter"]
		},
		jump: { gamepad: "gamepad_face_one", keyboard_and_mouse: "keyboard_space" },
		aiming: { gamepad: "gamepad_shoulder_right", keyboard_and_mouse: "mouse_button_right" },
		shooting: { gamepad: "gamepad_face_three", keyboard_and_mouse: "mouse_button_left" },
		reload: { gamepad: "gamepad_shoulder_left", keyboard_and_mouse: "mouse_button_middle" },
		enter: { gamepad: "gamepad_start", keyboard_and_mouse: "keyboard_enter" },
		back: {
			gamepad: "gamepad_face_two", keyboard_and_mouse: ["keyboard_escape", "keyboard_backspace"]
		},
	};
	
	function GetInputValue(_bind_value,
		_is_previous = false, _is_negative_dead_zone = false)
	{
		var _input = _is_previous ? rollback_previous_input : rollback_input;
		
		if (typeof(_bind_value) == "array") {
			for (var i = 0; i < array_length(_bind_value); i++) {
				var _value = _input[$ _bind_value[i]];
				
				if (string_contains(_bind_value[i], "axis")) {
					if (_is_negative_dead_zone)
						_value = _value <= -dead_zone;
					else
						_value = _value >= dead_zone;
				}
				
				if (_value)
					return true;
			}
			
			return false;
		} else {
			var _value = _input[$ _bind_value];
			
			if (string_contains(_bind_value, "axis")) {
				if (_is_negative_dead_zone)
					return _value <= -dead_zone;
				else
					return _value >= dead_zone;
			} else
				return _value;
		}
	}
	
	function _isInputHeld(_bind_value, _is_negative_dead_zone = false) {
		var _is_gamepad_value_held = GetInputValue(_bind_value.gamepad, , _is_negative_dead_zone);
		var _is_keyboard_value_held =
			GetInputValue(_bind_value.keyboard_and_mouse, , _is_negative_dead_zone);
		
		if (_is_gamepad_value_held)
			is_gamepad = true;
		else if (_is_keyboard_value_held)
			is_gamepad = false;
		
		return _is_gamepad_value_held || _is_keyboard_value_held;
	}
	
	function _isInputPressed(_bind_value, _is_negative_dead_zone = false) {
		var _is_gamepad_value_pressed =
			GetInputValue(_bind_value.gamepad, , _is_negative_dead_zone)
			&& !GetInputValue(_bind_value.gamepad, true, _is_negative_dead_zone);
		var _is_keyboard_value_pressed =
			GetInputValue(_bind_value.keyboard_and_mouse, , _is_negative_dead_zone)
			&& !GetInputValue(_bind_value.keyboard_and_mouse, true, _is_negative_dead_zone);
		
		if (_is_gamepad_value_pressed)
			is_gamepad = true;
		else if (_is_keyboard_value_pressed)
			is_gamepad = false;
		
		return _is_gamepad_value_pressed || _is_keyboard_value_pressed;
	}
	
	function _isInputReleased(_bind_value, _is_negative_dead_zone = false) {
		var _is_gamepad_value_released =
			GetInputValue(_bind_value.gamepad, true, _is_negative_dead_zone)
			&& !GetInputValue(_bind_value.gamepad, , _is_negative_dead_zone);
		var _is_keyboard_value_released =
			GetInputValue(_bind_value.keyboard_and_mouse, true, _is_negative_dead_zone)
			&& !GetInputValue(_bind_value.keyboard_and_mouse, , _is_negative_dead_zone);
		
		return _is_gamepad_value_released || _is_keyboard_value_released;
	}
	
	function Update() {
		_updateRollbackInput();
		state = {
			is_left_held: _isInputHeld(bind.left, true),
			is_right_held: _isInputHeld(bind.right),
			is_up_held: _isInputHeld(bind.up, true),
			is_down_held: _isInputHeld(bind.down),
			
			is_left_pressed: _isInputPressed(bind.left, true),
			is_right_pressed: _isInputPressed(bind.right),
			is_up_pressed: _isInputPressed(bind.up, true),
			is_down_pressed: _isInputPressed(bind.down),
			
			is_jump_held: _isInputHeld(bind.jump),
			is_aiming_held: _isInputHeld(bind.aiming),
			is_shoot_pressed: _isInputPressed(bind.shooting),
			is_reload_pressed: _isInputPressed(bind.reload),
			
			is_select_pressed: _isInputPressed(bind.select),
			is_enter_pressed: _isInputPressed(bind.enter),
			is_back_pressed: _isInputPressed(bind.back)
		}
	}
}

var _ = new InputManagerRollback(noone);