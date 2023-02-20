/// @function string_starts_with(string, substring);
/// @param {string} string to check
/// @param {substring} string to compare

function string_contains(_string, _substring) {
	if (string_length(_substring) > string_length(_string))
		return false;
	
	var _string_length = string_length(_string);
	
	for (var i = 1; i <= _string_length; i++) {
		if (string_char_at(_string, i) == string_char_at(_substring, 1)) {
			var _contains = true;
			
			for (var s = 0; s < string_length(_substring); s++) {
				if (i + s > _string_length
					|| string_char_at(_string, i + s) != string_char_at(_substring, s + 1)) {
					_contains = false;
					i += s;
					break;
				}
			}
			
			if (_contains)
				return true;
		}
	}
	
	return false;
}