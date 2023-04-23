function ChoosingCharacterState() : State() constructor {
	font = fnt_mono_small;
	font_start_match = fnt_mono;
	font_height = font_get_size(font);
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
	
	function get_current_character_sprite() {
		return get_character_sprites(global.characters[character_index].id);
	}

	function go_to_right_character() {
		character_index++;
		if (character_index >= array_length(global.characters))
			character_index = 0;
		
		if (global.characters[character_index].has_been_picked) {
			go_to_right_character();
			return;
		}
				
		var _sprite = get_current_character_sprite();
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
				
		var _sprite = get_current_character_sprite();
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
	
	function can_start_match() {
		with (obj_rollback_manager)
			return state.can_start_match();
	}

	function start_match() {
		audio_stop_sound(stk_crujoa);
		var _number_of_players = instance_number(obj_player_rollback);
		
		var _guns = [];
		
		for (var i = 0; i < instance_number(obj_gun); i++;)
			with (instance_find(obj_gun, i)) {
				if (_number_of_players >= number_of_players_to_appear) {
					instance_create_layer(x, y, layer, obj_gun_rollback);
					array_push(_guns, { x: x, y: y });
				}
			}
		
		global.rollback_guns_on_match = _guns;
		
		for (var i = 0; i < instance_number(obj_gun); i++;)
			with (instance_find(obj_gun, i))
				instance_destroy();
		
		for (var i = 0; i < _number_of_players; i++) {
			var _player = instance_find(obj_player_rollback, i);
			
			with (_player)
				state = new OnMatchState(state.get_current_character_sprite());
		}
		
		with (obj_rollback_manager)
			state = new MatchManagerState();
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
			
			if (input.state.is_enter_pressed && can_start_match())
				start_match();
		}
	}
	
	function on_draw_GUI() {
		if (instanceof(obj_rollback_manager.state) != "ChoosingCharacterManagerState"
			|| !obj_rollback_manager.state.show_text)
			return;
		
		var _text = "";
	
		if (character_index >= 0)
			_text = get_character_sprite_description(global.characters[character_index].id);
	
		if (is_ready)
			_text = "P" + string(owner.player_id + 1) + " READY";
	
		prepare_text_draw(font, fa_center, fa_center);
		draw_outlined_text(owner.x, owner.y - vertical_margin, _text);
	}
}