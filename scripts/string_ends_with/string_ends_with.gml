/// @function string_ends_with(string, end_string);
/// @param {string} string to check
/// @param {end_string} string to compare

function string_ends_with(_string, _end_string) {
	if (string_length(_end_string) > string_length(_string))
		return false;
	
	for (var i = string_length(_end_string); i >= 1; i--) {
		if (string_char_at(_string, i) != string_char_at(_end_string, i))
			return false;
	}
	
	return true;
}