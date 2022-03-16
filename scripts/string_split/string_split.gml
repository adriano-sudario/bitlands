// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function string_split(_string, _replace_string) {
	var result = [];
	var is_replace_char = string_length(_replace_string) == 1;
	var i = 0;
	
	if (is_replace_char) {
		var replace_char = string_char_at(_replace_string, 1);
		
		while (i <= string_length(_string)) {
			i++;
			var current_char = string_char_at(_string, i);
			if (is_replace_char && current_char == replace_char) {
				result[array_length(result)] = string_copy(_string, 1, i - 1);
				_string = string_delete(_string, 1, i);
				i = 0;
			}
		}
	} else {		
		while (i <= string_length(_string)) {
			i++;
			var current_char = string_char_at(_string, i);
			
			if (current_char == string_char_at(_replace_string, 1)) {
				var replace_index = i;
				var begin_index = i;
				var has_found_replace = true;
				
				while(has_found_replace) {
					//replace_index++;
					current_char = string_char_at(_string, replace_index);
					var current_replace_char = 
						string_char_at(_replace_string, replace_index - begin_index + 1);
					
					if (current_char != current_replace_char) {
						has_found_replace = false;
						break;
					}
				
					replace_index++;
					
					if (replace_index - begin_index >= string_length(_replace_string))
						break;
				}
				
				if (has_found_replace) {
					result[array_length(result)] = 
						string_copy(_string, 1, replace_index - string_length(_replace_string) - 1);
					_string = string_delete(_string, 1, replace_index - 1);
					i = 0;
				}
			}
		}
		for(var i = 1; i < string_length(_string) + 1; i++)
		{
			var current_char = string_char_at(_string, i);
	   
			if (!is_replace_char && current_char == string_char_at(_replace_string, 1)) {
			
			}
		}
	}
	
	result[array_length(result)] = _string;
	
	return result;
}