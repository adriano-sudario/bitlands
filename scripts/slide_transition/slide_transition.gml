/// @function slide_transition(mode, on_finish, delay, send_back_object)

function slide_transition(_mode, _on_finish = noone, _delay = 500, _send_back_object = noone) {
	with (obj_transition) {
		mode = _mode;
		on_finish = _on_finish;
		milliseconds_before_start = _delay;
		send_back_object = _send_back_object;
	}
}