/// @function get_options_items()

function get_options_items() {
	var back_item = {
		x: 0,
		y: 0,
		text: "Back",
		on_selected: function() {
			room_goto(Menu);
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
	var sound_item = {
		x: 0,
		y: 0,
		text: !obj_game.is_muted ? "Sound: on" : "Sound: off",
		on_selected: function() {
			obj_game.is_muted = !obj_game.is_muted;
			if (obj_game.is_muted) {
				audio_stop_all();
				text = "Sound: off";
			} else {
				play_sound(stk_crujoa, 100, true);
				text = "Sound: on";
			}
		}
	};
	
	return {
		fullscreen: fullscreen_item,
		show_aim: show_aim_item,
		sound: sound_item,
		back: back_item
	};
}