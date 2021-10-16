game_set_speed(60, gamespeed_fps);
slide_transition(TRANSITION_MODE.CLOSE, function() {
	room_goto(room);
	slide_transition(TRANSITION_MODE.OPEN);
}, 0);