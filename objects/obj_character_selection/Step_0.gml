blink_current_frame++;

if (blink_current_frame >= blink_frames_count) {
	blink_current_frame = 0;
	show_text = !show_text;
}

for (var i = 0; i < array_length(controls); i++;) {
	var control = controls[i];
	previous_left_controls[i] = current_left_controls[i];
	previous_right_controls[i] = current_right_controls[i];
	current_left_controls[i] = control.is_left_held();
	current_right_controls[i] = control.is_right_held();
	
	var selection_with_input = array_find(selections, function(s, c) {
		return s.input != noone && s.input.input_id == c.input_id;
	}, control);
	
	if (control.is_enter_pressed() && selection_with_input == noone) {
		var last_selection_with_input = noone;
		var last_spawn_with_input = noone;
		
		for (var i = 0; i < array_length(selections); i++;) {
			var selection = selections[i];
			var selection_spawn = selection.spawn_point;
			if (selection.input == noone) {
				if (last_selection_with_input == noone) {
					last_selection_with_input = selection;
					last_spawn_with_input = selection_spawn;
				} else if (selection_spawn.order < last_spawn_with_input.order) {
					last_selection_with_input = selection;
					last_spawn_with_input = selection_spawn;
				}
			}
		}
		if (last_selection_with_input != noone) {
			audio_play_sound(sfx_menu_change, 5, false);
			last_selection_with_input.input = control;
			last_selection_with_input.spawn_point = last_spawn_with_input;
			last_selection_with_input.spawn_point.visible = true;
			last_selection_with_input.vertical_margin += 25;
			last_selection_with_input.character_index = 0;
			var sprite = get_character_sprites(characters_list[0]);
			last_selection_with_input.spawn_point.sprite_index = sprite.idle;
			last_selection_with_input.spawn_point.image_speed = 0;
			last_selection_with_input.index =
				last_selection_with_input.spawn_point.order;
		}
	}
	
	if (selection_with_input != noone) {
		if (!selection_with_input.is_ready) {
			var is_left_pressed = !previous_left_controls[i] 
				&& current_left_controls[i];
			var is_right_pressed = !previous_right_controls[i] 
				&& current_right_controls[i];
			
			if (is_left_pressed) {
				selection_with_input.character_index--;
				if (selection_with_input.character_index < 0)
					selection_with_input.character_index = 
						array_length(characters_list) - 1;
				
				var sprite = get_character_sprites(
					characters_list[selection_with_input.character_index]);
				selection_with_input.spawn_point.sprite_index = sprite.idle;
			}
			
			if (is_right_pressed) {
				selection_with_input.character_index++;
				if (selection_with_input.character_index >= array_length(characters_list))
					selection_with_input.character_index = 0;
				
				var sprite = get_character_sprites(
					characters_list[selection_with_input.character_index]);
				selection_with_input.spawn_point.sprite_index = sprite.idle;
			}
			
			if (control.is_select_pressed() || control.is_enter_pressed()) {
				audio_play_sound(sfx_menu_change, 5, false);
				selection_with_input.is_ready = true;
				selection_with_input.chosen_index = array_length(chosen_characters);
				array_insert(chosen_characters, selection_with_input.chosen_index,
					characters_list[selection_with_input.character_index]);
				selection_with_input.spawn_point.image_speed = 1;
			}
			
			if (control.is_back_pressed()) {
				selection_with_input.input = noone;
				selection_with_input.spawn_point.visible = false;
				selection_with_input.vertical_margin -= 25;
				selection_with_input.character_index = -1;
				last_selection_with_input.index = -1;
			}
		} else {
			if (control.is_back_pressed()) {
				selection_with_input.is_ready = false;
				array_delete(chosen_characters, selection_with_input.chosen_index, 1);
				selection_with_input.chosen_index = array_length(chosen_characters);
				selection_with_input.spawn_point.image_speed = 0;
			}
			
			if (control.is_enter_pressed() && can_start) {
				var _players = [];
				for (var i = 0; i < array_length(selections); i++;) {
					var selection = selections[i];
					var selection_ready = array_find(selections, function(s, i) {
						return s.is_ready && s.index == i;
					}, i);
					if (selection_ready != noone)
						array_insert(_players, array_length(_players), {
							input: selection_ready.input.input_id,
							character: characters_list[selection_ready.character_index],
							index: selection_ready.index
						});
					else
						break;
				}
				
				global.game_state = { players: _players };
				audio_stop_sound(stk_crujoa);
				room_goto(Shooting);
			}
		}
	}
}

can_start = array_length(chosen_characters) >= 2;