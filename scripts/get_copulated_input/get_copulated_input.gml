/// @function get_populated_inputs(_input_id);
/// @param {input_id} -1: keyboard / 0~3: gamepads

function get_populated_input(_input = noone, _player = noone) {
	if (_input == noone)
		_input = input_manager();
	var _variable_names = variable_struct_get_names(_input);
	var _ignored_methods_starting_with = [
		"check", "directional", "update", "held", "pressed", "update"
	];
	var _populated_input = {};
	
	for (var i = 0; i < array_length(_variable_names); i++;)
	{
		var _name = _variable_names[i];
		var _value = variable_struct_get(_input, _variable_names[i]);
		
		if (_name == "aiming_angle") {
			if (_player != noone)
				_input.update_aiming_angle(_player.x, _player.y);
			else
				_input.update_aiming_angle(x, y);
			
			_value = _input.aiming_angle;
		}
		
		if (typeof(_value) != "method" || _name == "input_bind")
			variable_struct_set(_populated_input, _name, _value);
	}
	
	for (var i = 0; i < array_length(_variable_names); i++;)
	{
		var _name = _variable_names[i];
		var _value = variable_struct_get(_input, _variable_names[i]);
		
		if (typeof(_value) != "method")
			continue;
		
		var _has_found_ignored_method = false;
		
		for (var m = 0; m < array_length(_ignored_methods_starting_with); m++;) {
			if (string_starts_with(_name, _ignored_methods_starting_with[m])) {
				_has_found_ignored_method = true;
				break;
			}
		}
		
		if (_has_found_ignored_method)
			continue;
		
		var _input_method = method(_input, _value);
		variable_struct_set(_populated_input, _name, _input_method());
	}
	
	_populated_input.is_gamepad = _input.is_gamepad;
	return _populated_input;
}