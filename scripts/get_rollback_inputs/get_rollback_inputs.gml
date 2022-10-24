/// @function get_rollback_inputs();

function get_rollback_inputs() {
	var _rollback_inputs = {
		gp_axislh: gp_axislh,
		gp_axislv: gp_axislv,
		km_axisx: m_axisx,
		km_axisy: m_axisy,
	};
	var _default_input_binds = input_manager().input_bind;
	var _input_bind_names = variable_struct_get_names(_default_input_binds);
	
	for (var i = 0; i < array_length(_input_bind_names); i++) {
		var _gamepad_binds = _default_input_binds[$ _input_bind_names[i]].gamepad;
		
		if (is_array(_gamepad_binds)) {
			for (var g = 0; g < array_length(_gamepad_binds); g++) {
				var _gamepad_bind_name = "gp_" + string(_gamepad_binds[g]);
				if (variable_struct_exists(_rollback_inputs, _gamepad_bind_name))
					continue;
			
				variable_struct_set(_rollback_inputs, _gamepad_bind_name, _gamepad_binds[g]);
			}
		} else {
			var _gamepad_bind_name = "gp_" + string(_gamepad_binds);
			if (!variable_struct_exists(_rollback_inputs, _gamepad_bind_name))
				variable_struct_set(_rollback_inputs, _gamepad_bind_name, _gamepad_binds);
		}
		
		var _keyboard_binds = _default_input_binds[$ _input_bind_names[i]].keyboard;
		
		if (is_array(_keyboard_binds)) {
			for (var k = 0; k < array_length(_keyboard_binds); k++) {
				var _value = _keyboard_binds[k];
				var _keyboard_bind_name = "km_" + string(_value);
				if (variable_struct_exists(_rollback_inputs, _keyboard_bind_name))
					continue;
			
				variable_struct_set(_rollback_inputs, _keyboard_bind_name,
					is_string(_value) ? ord(_value) : _value);
			}
		} else {
			var _value = _keyboard_binds;
			var _keyboard_bind_name = "km_" + string(_value);
			if (!variable_struct_exists(_rollback_inputs, _keyboard_bind_name))
				variable_struct_set(_rollback_inputs, _keyboard_bind_name,
					is_string(_value) ? ord(_value) : _value);
		}
	}
	
	return _rollback_inputs;
}