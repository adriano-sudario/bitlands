/// @function get_character_sprites(character)

function transition_to_room(_room){
	slide_transition(TRANSITION_MODE.CLOSE, function(r) {
		room_goto(r);
		slide_transition(TRANSITION_MODE.OPEN);
	}, 250, _room);
}