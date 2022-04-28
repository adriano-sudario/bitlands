/// @function array_order_by(array, variable_name)
/// @param {array} array to be ordered
/// @param {variable_name} name of variable to compare

function array_order_by(_array, _variable_name) {
	if (array_length(_array) == 0)
		return _array;
	
	var ordered_array = [];
	
	while(array_length(_array) > 0) {
		var minimum = noone;
		var minimum_index = 0;
		
		for (var i = 0; i < array_length(_array); i++) {
			if (minimum == noone) {
				minimum = _array[i];
				minimum_index = i;
				continue;
			}
			
			var current_value = variable_struct_get_deep(_array[i], _variable_name);
			
			if (current_value < variable_struct_get_deep(minimum, _variable_name)) {
				minimum = _array[i];
				minimum_index = i;
			}
		}
		
		array_insert(ordered_array, array_length(ordered_array), minimum);
		array_delete(_array, minimum_index, 1);
	}
	
	return ordered_array;
}