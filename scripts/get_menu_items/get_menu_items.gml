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
		text: "Fs On",
		on_selected: function() {
			obj_game.toggle_fullscreen();
			if (window_get_fullscreen())
				text = "Fs Off";
			else
				text = "Fs On";
		}
	};
	var new_game_item = {
		x: 0,
		y: 0,
		text: "New Game",
		on_selected: function(_menu_id) {
			//with(obj_game) {
			//	audio_sound_gain(current_soundtrack, 0, 500);
			//}
			//with(obj_menu) {
			//	has_all_items_arrived = false;
			//	horizontal_position = gui_width + starting_position_offset;
			//}
			instance_destroy(_menu_id);
		
			slide_transition(TRANSITION_MODE.CLOSE, function() {
				room_goto(Shooting);
				slide_transition(TRANSITION_MODE.OPEN);
			}, 250);
		}
	};
	
	return {
		new_game: new_game_item,
		fullscreen: fullscreen_item,
		quit: quit_item
	};
}