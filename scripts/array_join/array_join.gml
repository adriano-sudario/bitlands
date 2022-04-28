/// @function array_join(string_array, text)

function array_join(_string_array, _text) {
	var joined_text = "";
	
	for (var i = 0; i < array_length(_string_array); i++) {
		if (i == array_length(_string_array) -1)
			joined_text += _string_array[i];
		else
			joined_text += _string_array[i] + _text;
	}
	
	return joined_text;
}