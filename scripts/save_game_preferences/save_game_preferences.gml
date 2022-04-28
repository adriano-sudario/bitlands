/// @function save_game_state()

#macro PREFERENCES_FILE "preferences.bin"

function save_game_preferences() {
	var _json_game_state = json_stringify({
		is_fullscreen: window_get_fullscreen(),
		show_aim: obj_game.show_aim,
		is_muted: obj_game.is_muted
	});
	
	var _length = 0;
	for (var i = 0; i < string_length(_json_game_state); i++)
		_length += 8;
	
	var _buff = buffer_create(_length, buffer_fixed, 1);
	buffer_write(_buff, buffer_text, _json_game_state);
	
	var _compressed_buff = buffer_compress(_buff, 0, buffer_tell(_buff));
	buffer_save(_compressed_buff, PREFERENCES_FILE);
	
	buffer_delete(_buff);
	buffer_delete(_compressed_buff);
}
