/// @function string_starts_with(string, start_string);
/// @param {string} string to check
/// @param {start_string} string to compare

function string_starts_with(_string, _start_string) {
	if (string_length(_start_string) > string_length(_string))
		return;
	
	for (var i = 1; i <= string_length(_start_string); i++) {
		if (string_char_at(_string, i) != string_char_at(_start_string, i))
			return false;
	}
	
	return true;
}