gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
font = fnt_mono_small;
font_start_match = fnt_mono;
font_height = font_get_size(font);
show_text = false;
blink_frames_count = 15;
blink_current_frame = 0;
can_start = false;
characters_list = [
	CHARACTER.SEVERINO, CHARACTER.GERALDO,
	CHARACTER.RAIMUNDO, CHARACTER.SEBASTIAO
];
chosen_characters = [];
input_managers = [
	input_manager(-1), input_manager(0),
	input_manager(1), input_manager(2),
	input_manager(3)
];

current_left_inputs = [];
current_right_inputs = [];
previous_left_inputs = [];
previous_right_inputs = [];

for (var i = 0; i < array_length(input_managers); i++;) {
	array_insert(current_left_inputs, i, input_managers[i].is_left_held());
	array_insert(current_right_inputs, i, input_managers[i].is_right_held());
	array_insert(previous_left_inputs, i, input_managers[i].is_left_held());
	array_insert(previous_right_inputs, i, input_managers[i].is_right_held());
}

selections = [];

for (var i = 0; i < 4; i++;) {
	array_insert(selections, i,
	{
		spawn_point: noone,
		input: noone,
		is_ready: false,
		character_index: -1,
		chosen_index: -1,
		index: -1,
		vertical_margin: 15
	});
}

function select_input(_input) {
	var last_selection_with_input = noone;
	var last_spawn_with_input = noone;
		
	for (var i = 0; i < array_length(selections); i++;) {
		var selection = selections[i];
		var selection_spawn = selection.spawn_point;
		if (selection.input == noone &&
			(last_selection_with_input == noone ||
			selection_spawn.order < last_spawn_with_input.order)) {
			last_selection_with_input = selection;
			last_spawn_with_input = selection_spawn;
		}
	}
	
	if (last_selection_with_input != noone) {
		play_sound(sfx_menu_change, 5, false);
		last_selection_with_input.input = _input;
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

function go_to_right_character(_selection) {
	_selection.character_index++;
	if (_selection.character_index >= array_length(characters_list))
		_selection.character_index = 0;
				
	var sprite = get_character_sprites(
		characters_list[_selection.character_index]);
	_selection.spawn_point.sprite_index = sprite.idle;
}

function go_to_left_character(_selection) {
	_selection.character_index--;
	if (_selection.character_index < 0)
		_selection.character_index = 
			array_length(characters_list) - 1;
				
	var sprite = get_character_sprites(
		characters_list[_selection.character_index]);
	_selection.spawn_point.sprite_index = sprite.idle;
}

function select_character(_selection) {
	play_sound(sfx_menu_change, 5, false);
	_selection.is_ready = true;
	_selection.chosen_index = array_length(chosen_characters);
	array_insert(chosen_characters, _selection.chosen_index,
		characters_list[_selection.character_index]);
	_selection.spawn_point.image_speed = 1;
}

function back_to_input_selection(_selection) {
	_selection.input = noone;
	_selection.spawn_point.visible = false;
	_selection.vertical_margin -= 25;
	_selection.character_index = -1;
}

function back_to_character_selection(_selection) {
	_selection.is_ready = false;
	array_delete(chosen_characters, _selection.chosen_index, 1);
	_selection.chosen_index = array_length(chosen_characters);
	_selection.spawn_point.image_speed = 0;
}

function start() {
	var _players = [];
	for (var i = 0; i < array_length(selections); i++;) {
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

function can_input_back_to_room(_input) {
	if (_input == noone || _input.input_id_used == noone || _input.input_id == noone)
		return true;
	
	var is_backing_to_room = true;
				
	for (var i = 0; i < array_length(selections); i++) {
		var selection = selections[i];
		var selection_input = selection.input;
		
		if (selection_input != noone && _input.input_id_used == selection_input.input_id) {
			is_backing_to_room = false;
			break;
		}
	}
				
	return is_backing_to_room;
}

function update_selection() {
	for (var i = 0; i < array_length(input_managers); i++;) {
		var input = input_managers[i];
		previous_left_inputs[i] = current_left_inputs[i];
		previous_right_inputs[i] = current_right_inputs[i];
		current_left_inputs[i] = input.is_left_held();
		current_right_inputs[i] = input.is_right_held();
		
		var selection_with_input = array_find(selections, function(s, c) {
			return s.input != noone && s.input.input_id == c.input_id;
		}, input);
		
		if (input.is_back_pressed() &&
			(selection_with_input == noone || can_input_back_to_room(input))) {
			transition_to_room(Menu);
			return;
		}
		
		if (input.is_enter_pressed() && selection_with_input == noone)
			select_input(input);
	
		if (selection_with_input != noone) {
			if (!selection_with_input.is_ready) {
				var is_left_pressed = !previous_left_inputs[i] 
					&& current_left_inputs[i];
				var is_right_pressed = !previous_right_inputs[i] 
					&& current_right_inputs[i];
			
				if (is_left_pressed)
					go_to_left_character(selection_with_input);
			
				if (is_right_pressed)
					go_to_right_character(selection_with_input);
			
				if (input.is_select_pressed())
					select_character(selection_with_input);
			
				if (input.is_back_pressed())
					back_to_input_selection(selection_with_input);
			} else {
				if (input.is_back_pressed())
					back_to_character_selection(selection_with_input);
			
				if (input.is_enter_pressed() && can_start)
					start();
			}
		}
	}
}