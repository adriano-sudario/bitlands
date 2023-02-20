//if (rollback_event_id == rollback_game_info) {
//    players_in_room_count = rollback_event_param.num_players;
//	//load_selection(rollback_event_param.player_id);
//	can_start = players_in_room_count >= 2;
//}

switch (rollback_event_id) {
	case rollback_game_info:
	case rollback_connected_to_peer:
		players_in_room_count++;
		break;
	
	case rollback_disconnected_from_peer:
		players_in_room_count--;
		break;
}

can_start = players_in_room_count >= 2;