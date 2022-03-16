/// @function get_menu_items()

function get_menu_items(){
	var quit_item = {
		x: 0,
		y: 0,
		text: "Quit",
		on_selected: function() {
			game_end();
		}
	};
	var fullscreen_item = {
		x: 0,
		y: 0,
		text: window_get_fullscreen() ? "Fullscreen: on" : "Fullscreen: off",
		on_selected: function() {
			obj_game.toggle_fullscreen();
			if (window_get_fullscreen())
				text = "Fullscreen: on";
			else
				text = "Fullscreen: off";
		}
	};
	var show_aim_item = {
		x: 0,
		y: 0,
		text: obj_game.show_aim ? "Show aim: on" : "Show aim: off",
		on_selected: function() {
			obj_game.show_aim = !obj_game.show_aim;
			if (obj_game.show_aim)
				text = "Show aim: on";
			else
				text = "Show aim: off";
		}
	};
	var join_game_item = {
		x: 0,
		y: 0,
		text: "Join match",
		on_selected: function(_menu_id) {
			instance_destroy(_menu_id);
		
			slide_transition(TRANSITION_MODE.CLOSE, function() {
				room_goto(JoinGame);
				slide_transition(TRANSITION_MODE.OPEN);
			}, 250);
		}
	};
	var host_game_item = {
		x: 0,
		y: 0,
		text: "Host match",
		on_selected: function(_menu_id) {
			instance_destroy(_menu_id);
		
			slide_transition(TRANSITION_MODE.CLOSE, function() {
				room_goto(ShootingCharacterSelectionMultiplayer);
				slide_transition(TRANSITION_MODE.OPEN);
			}, 250);
		}
	};
	var new_game_item = {
		x: 0,
		y: 0,
		text: "New match",
		on_selected: function(_menu_id) {
			instance_destroy(_menu_id);
		
			slide_transition(TRANSITION_MODE.CLOSE, function() {
				room_goto(ShootingCharacterSelection);
				slide_transition(TRANSITION_MODE.OPEN);
			}, 250);
		}
	};
	
	return {
		new_game: new_game_item,
		host_game: host_game_item,
		join_game: join_game_item,
		fullscreen: fullscreen_item,
		show_aim: show_aim_item,
		quit: quit_item
	};
}