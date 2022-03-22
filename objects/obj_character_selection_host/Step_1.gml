host.send_packet(HOST_EVENT.UPDATE_CLIENT_SELECTION, {
	chosen_characters: chosen_characters,
	selections: selections,
	can_start: can_start
});