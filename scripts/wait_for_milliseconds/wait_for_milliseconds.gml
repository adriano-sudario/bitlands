/// @function src_wait_for_milliseconds(duration, on_finished, step_to_check);
/// @param {duration} duration in milliseconds
/// @param {on_finished} action on finished timout
/// @param {step_to_check} step on which to check timeout (optional)

function wait_for_milliseconds(_duration, _on_finished,
	_step_to_check = undefined, _is_replay = false)
{
	var routine = instance_create_layer(0, 0, layer, obj_wait_for_milliseconds);
	routine.duration = _duration;
	routine.on_finished = _on_finished;
	routine.caller = self;
	routine.is_replay = _is_replay;
	if (_step_to_check != undefined)
		routine.step_to_check = _step_to_check;
	return routine;
}