function MatchManagerState() : ManagerState() constructor {
	players = [];
	has_bipped = false;
	font_height = font_get_size(font);
	countdown = 1;
	countdown_scale = 0;
	countdown_growth_speed = .1;
	countdown_fps_stopped = 45;
	current_countdown_fps_stopped = 0;
	has_begun = false;
	
	function set_players() {
		for (var i = 0; i < instance_number(obj_player_rollback); i++)
			array_push(players, instance_find(obj_player_rollback, i));
	}
	
	set_players();
	
	function update_countdown() {
		countdown_scale += countdown_growth_speed;
		
		if (countdown_scale >= 1) {
			if (!has_bipped) {
				var _sfx = countdown == 3 ? sfx_countdown_high : sfx_countdown_low;
				play_sound(_sfx, 5, false);
				has_bipped = true;
			}
			
			countdown_scale = 1;
			current_countdown_fps_stopped++;
			
			if (current_countdown_fps_stopped >= countdown_fps_stopped) {
				has_bipped = false;
				countdown++;
				
				if (countdown > 3) {
					has_begun = true;
					play_sound(stk_chaesd_by_teh_rievr, 100, true);
				} else {
					countdown_scale = 0;
					current_countdown_fps_stopped = 0;
				}
			}
		}
	}
	
	function on_end_step() {
		if (!has_begun) {
			update_countdown();
			return;
		}

		var _players_length = array_length(players);
		var _players_standing = [];

		for (var i = 0; i < _players_length; i++) {
			var _player = players[i].state;
			
			if (!_player.has_fallen_dead)
				array_insert(_players_standing, array_length(_players_standing), _player);
		}

		var _players_standing_length = array_length(_players_standing);
		var _has_match_ended = _players_standing_length <= 1;

		if (_has_match_ended) {
			if (_players_standing_length == 1) {
				var _winning_player = _players_standing[0];
				_winning_player.owner.sprite_index = _winning_player.sprites_indexes.idle;
				_winning_player.cancel_movement();
				
				if (_winning_player.is_aiming)
					_winning_player.remove_aiming_instance();
			}
			
			for (var i = 0; i < _players_length; i++)
				with (players[i])
					state = new OnMatchEndedState(state.sprites_indexes);
			
			var _winner_description = _players_standing_length == 0 ? "IT'S A DRAW!" 
				: string(_winning_player.owner.player_name) + " WINS!";
			
			with (owner)
				state = new MatchEndedManagerState(_winner_description);
		}
	}
	
	function on_draw_GUI() {
		if (has_begun)
			return;
			
		prepare_text_draw(font_big, fa_center, fa_center);
		draw_outlined_text_transformed(
			gui_width * .5, gui_height * .5 - (font_height * 4),
			string(countdown), countdown_scale);
	}
}