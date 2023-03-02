/// @function get_menu_items()

function get_menu_items() {
	var quit_item = {
		x: 0,
		y: 0,
		text: "Quit",
		on_selected: function() {
			game_end();
		}
	};
	var options_item = {
		x: 0,
		y: 0,
		text: "Options",
		on_selected: function() {
			room_goto(MenuOptions);
		}
	};
	var multiplayer_item = {
		x: 0,
		y: 0,
		text: "Multiplayer",
		on_selected: function(_menu_id) {
			instance_destroy(_menu_id);
			transition_to_room(RollbackRoom);
		}
	};
	var join_game_item = {
		x: 0,
		y: 0,
		text: "Join match",
		on_selected: function(_menu_id) {
			instance_destroy(_menu_id);
			transition_to_room(JoinGame);
		}
	};
	var host_game_item = {
		x: 0,
		y: 0,
		text: "Host match",
		on_selected: function(_menu_id) {
			instance_destroy(_menu_id);
			transition_to_room(ShootingCharacterSelectionMultiplayer);
		}
	};
	var new_game_item = {
		x: 0,
		y: 0,
		text: "Local match",
		on_selected: function(_menu_id) {
			instance_destroy(_menu_id);
			transition_to_room(ShootingCharacterSelection);
		}
	};
	
	return {
		new_game: new_game_item,
		multiplayer: multiplayer_item,
		host_game: host_game_item,
		join_game: join_game_item,
		options: options_item,
		quit: quit_item
	};
}