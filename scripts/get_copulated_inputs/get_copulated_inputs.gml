/// @function get_copulated_inputs(_input_id);
/// @param {input_id} -1: keyboard / 0~3: gamepads

function get_copulated_inputs(_input_id = noone) {
	var input = input_manager(_input_id);
	var variable_names = variable_struct_get_names(input);
	var ignored_methods_starting_with = [
		"check", "directional", "update", "held", "pressed", "update"
	];
	var copulated_input = {};
	
	for (var i = 0; i < array_length(variable_names); i++;)
	{
		var name = variable_names[i];
		var value = variable_struct_get(input, variable_names[i]);
		
		if (name == "aiming_angle") {
			input.update_aiming_angle(x, y);
			value = input.aiming_angle;
		}
		
		if (typeof(value) != "method" || name == "input_bind")
			variable_struct_set(copulated_input, name, value);
	}
	
	for (var i = 0; i < array_length(variable_names); i++;)
	{
		var name = variable_names[i];
		var value = variable_struct_get(input, variable_names[i]);
		
		if (typeof(value) != "method")
			continue;
		
		var has_found_ignored_method = false;
		
		for (var m = 0; m < array_length(ignored_methods_starting_with); m++;) {
			if (string_starts_with(name, ignored_methods_starting_with[m])) {
				has_found_ignored_method = true;
				break;
			}
		}
		
		if (has_found_ignored_method)
			continue;
		
		var input_method = method(input, value);
		variable_struct_set(copulated_input, name, input_method());
	}
	
	copulated_input.is_gamepad = input.is_gamepad;
	return copulated_input;
}