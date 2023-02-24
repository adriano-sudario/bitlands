switch (rollback_event_id) {
	case rollback_game_info:
	case rollback_connected_to_peer:
		players_connected++;
		break;
	
	case rollback_disconnected_from_peer:
		players_connected--;
		break;
}