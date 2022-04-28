/// @function load_game_preferences()

function load_game_preferences() {
	if (!file_exists(PREFERENCES_FILE))
		return {
			is_fullscreen: false,
			show_aim: false,
			is_muted: false
		}
	
	var _buffer = buffer_load(PREFERENCES_FILE);
	var _decompressed_buffer = buffer_decompress(_buffer);
	var _json_game_state = buffer_read(_decompressed_buffer, buffer_string);
	var _preferences = json_parse(_json_game_state);
	buffer_delete(_buffer);
	buffer_delete(_decompressed_buffer);
	return _preferences;
}
