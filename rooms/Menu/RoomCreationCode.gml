var _preferences = load_game_preferences();

obj_game.show_aim = _preferences.show_aim;
obj_game.is_muted = _preferences.is_muted;

window_set_fullscreen(_preferences.is_fullscreen);

if (audio_is_playing(stk_crujoa))
	return;

play_sound(stk_crujoa, 100, true);