/// @function get_rollback_input_binds();

function get_rollback_input_binds() {
	var _default_input_binds = input_manager().input_bind;
	var _input_bind_names = variable_struct_get_names(_default_input_binds);
	
	for (var i = 0; i < array_length(_input_bind_names); i++) {
		var _gamepad_binds = _default_input_binds[$ _input_bind_names[i]].gamepad;
		var _new_gamepad_binds = [];
		
		if (is_array(_gamepad_binds)) {
			for (var g = 0; g < array_length(_gamepad_binds); g++) {
				var _gamepad_bind_name = "gp_" + string(_gamepad_binds[g]);
				if (_gamepad_binds[g] == gp_axislh)
					_gamepad_bind_name = "gp_axislh";
				else if (_gamepad_binds[g] == gp_axislv)
					_gamepad_bind_name = "gp_axislv";
				array_push(_new_gamepad_binds, _gamepad_bind_name);
			}
		} else {
			var _gamepad_bind_name = "gp_" + string(_gamepad_binds);
			if (_gamepad_binds == gp_axislh)
				_gamepad_bind_name = "gp_axislh";
			else if (_gamepad_binds == gp_axislv)
				_gamepad_bind_name = "gp_axislv";
			array_push(_new_gamepad_binds, _gamepad_bind_name);
		}
		
		_default_input_binds[$ _input_bind_names[i]].gamepad = _new_gamepad_binds;
		
		var _keyboard_binds = _default_input_binds[$ _input_bind_names[i]].keyboard;
		var _new_keyboard_binds = [];
		
		if (is_array(_keyboard_binds)) {
			for (var k = 0; k < array_length(_keyboard_binds); k++) {
				var _keyboard_bind_name = "km_" + string(_keyboard_binds[k]);
				array_push(_new_keyboard_binds, _keyboard_bind_name);
			}
		} else {
			var _keyboard_bind_name = "km_" + string(_keyboard_binds);
			array_push(_new_keyboard_binds, _keyboard_bind_name);
		}
		
		_default_input_binds[$ _input_bind_names[i]].keyboard = _new_keyboard_binds;
	}
	
	return _default_input_binds;
}