/// @description string_replace_at(str, pos, insert)
/// @param _value
/// @param _index
/// @param _replace_text

function string_replace_at(_string, _position, _replace_text) {
	if (_position > string_length(_string) || _position <= 0)
		return _string;
	
	return string_copy(_string, 1, _position - 1) + _replace_text + string_delete(_string, 1, _position);
}