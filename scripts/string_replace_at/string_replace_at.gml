/// @function string_replace_at(string, position, replace_text);
/// @param {string} string to be replaced
/// @param {position} position of replacement
/// @param {replace_text} text to replace

function string_replace_at(_string, _position, _replace_text) {
	if (_position > string_length(_string) || _position <= 0)
		return _string;
	
	return string_copy(_string, 1, _position - 1) + _replace_text + string_delete(_string, 1, _position);
}