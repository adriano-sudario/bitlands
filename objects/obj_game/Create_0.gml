#macro RESOLUTION_WIDTH 816
#macro RESOLUTION_HEIGHT 624

display_set_gui_size(RESOLUTION_WIDTH, RESOLUTION_HEIGHT);

current_soundtrack = noone;

global.game_state = {
	current_room: noone,
	weapons: [],
	kills: 0
}

function reset_game_state() {
	global.game_state = {
		current_room: noone,
		weapons: [],
		kills: 0
	}
}

function toggle_fullscreen() {
	window_set_fullscreen(!window_get_fullscreen());
}

function play_soundtrack(_soundtrack) {
	if (_soundtrack == current_soundtrack)
		return;
	
	if (_soundtrack == noone) {
		stop_soundtrack();
		return;
	}
	
	audio_stop_all();
	audio_sound_gain(_soundtrack, 1, 0);
	audio_play_sound(_soundtrack, 1000, true);
	current_soundtrack = _soundtrack;
}

function stop_soundtrack() {
	audio_stop_all();
	current_soundtrack = noone;
}