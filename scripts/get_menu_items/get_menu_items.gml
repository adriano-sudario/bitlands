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
		text: "Fullscreen: on",
		on_selected: function() {
			obj_game.toggle_fullscreen();
			if (window_get_fullscreen())
				text = "Fullscreen: off";
			else
				text = "Fullscreen: on";
		}
	};
	var show_aim_item = {
		x: 0,
		y: 0,
		text: "Show aim: off",
		on_selected: function() {
			obj_game.show_aim = !obj_game.show_aim;
			if (obj_game.show_aim)
				text = "Show aim: on";
			else
				text = "Show aim: off";
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
		fullscreen: fullscreen_item,
		show_aim: show_aim_item,
		quit: quit_item
	};
}