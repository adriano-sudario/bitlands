function ChoosingCharacterState() constructor {
	owner = other;
	font = fnt_mono_small;
	font_start_match = fnt_mono;
	font_height = font_get_size(font);
	blink_frames_count = 15;
	blink_current_frame = 0;
	show_text = true;
	input = new InputManagerRollback(owner.player_id, other);
	spawn_point = noone;
	is_ready = false;
	character_index = 0;
	index = -1;
	vertical_margin = 40;
	
	function spawn() {
		for (var i = 0; i < array_length(global.spawn_points); i++) {
			var _spawn_point = global.spawn_points[i];
		
			if (owner.player_id == i) {
				owner.x = _spawn_point.x;
				owner.y = _spawn_point.y;
				owner.image_xscale = _spawn_point.image_xscale;
				break;
			}
		}
	}
	
	spawn();

	function go_to_right_character() {
		character_index++;
		if (character_index >= array_length(global.characters))
			character_index = 0;
		
		if (global.characters[character_index].has_been_picked) {
			go_to_right_character();
			return;
		}
				
		var _sprite = get_character_sprites(global.characters[character_index].id);
		owner.sprite_index = _sprite.idle;
	}

	function go_to_left_character() {
		character_index--;
		if (character_index < 0)
			character_index = array_length(global.characters) - 1;
		
		if (global.characters[character_index].has_been_picked) {
			go_to_left_character();
			return;
		}
				
		var _sprite = get_character_sprites(global.characters[character_index].id);
		owner.sprite_index = _sprite.idle;
	}

	function select_character() {
		play_sound(sfx_menu_change, 5, false);
		is_ready = true;
		global.characters[character_index].has_been_picked = true;
		owner.image_speed = 1;
		
		for (var i = 0; i < instance_number(obj_player_rollback); i++) {
			with (instance_find(obj_player_rollback, i)) {
				if (other.owner != self && state.character_index == other.character_index)
					state.go_to_right_character();
			}
		}
	}

	function back_to_character_selection() {
		is_ready = false;
		global.characters[character_index].has_been_picked = false;
		owner.image_speed = 0;
		owner.image_index = 0;
	}

	function back_to_menu() {
		//transition_to_room(Menu);
	}
	
	function can_start() {
		with (obj_rollback_manager) {
			var _characters_picked = 0;
			
			for (var i =0; i < array_length(global.characters); i++)
				if (global.characters[i].has_been_picked)
					_characters_picked++;
		
			return players_connected == _characters_picked;
		}
	}

	function start() {
		return;
		//var _players = [];
		//global.game_state = { players: _players };
		audio_stop_sound(stk_crujoa);
		//room_goto(ShootingMultiplayer);
	}

	function on_begin_step() {
		input.Update();
	
		if (!is_ready) {
			if (input.state.is_left_pressed)
				go_to_left_character();
			
			if (input.state.is_right_pressed)
				go_to_right_character();
			
			if (input.state.is_select_pressed)
				select_character();
		
			//if (_input.back_pressed)
			//	back_to_menu();
		} else {
			if (input.state.is_back_pressed)
				back_to_character_selection();
			
			if (input.state.is_enter_pressed && can_start())
				start();
		}
	}
	
	function on_step() {
		blink_current_frame++;

		if (blink_current_frame >= blink_frames_count) {
			blink_current_frame = 0;
			show_text = !show_text;
		}
	}
	
	function on_draw_GUI() {
		var _text = "";
	
		if (character_index >= 0)
			_text = get_character_sprite_description(global.characters[character_index].id);
	
		if (is_ready)
			_text = "P" + string(owner.player_id + 1) + " READY";
	
		prepare_text_draw(font, fa_center, fa_center);
		draw_outlined_text(owner.x, owner.y - vertical_margin, _text);
	}
}