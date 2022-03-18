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
input = input_manager();
current_left_input = input.is_left_held();
current_right_input = input.is_right_held();
previous_left_input = current_left_input;
previous_right_input = current_right_input;
players_in_room_count = 0;
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

function select_input(_selection) {
	_selection.input = input_manager();
	_selection.spawn_point = selections[players_in_room_count].spawn_point;
	_selection.spawn_point.visible = true;
	_selection.vertical_margin += 25;
	_selection.character_index = 0;
	var sprite = get_character_sprites(characters_list[0]);
	_selection.spawn_point.sprite_index = sprite.idle;
	_selection.spawn_point.image_speed = 0;
	_selection.index = _selection.spawn_point.order;
	players_in_room_count++;
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
	audio_play_sound(sfx_menu_change, 5, false);
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

function update_selection(_selection) {
	previous_left_input = current_left_input;
	previous_right_input = current_right_input;
	current_left_input = input.is_left_held();
	current_right_input = input.is_right_held();
	
	if (!_selection.is_ready) {
		var is_left_pressed = !previous_left_input && current_left_input;
		var is_right_pressed = !previous_right_input && current_right_input;
			
		if (is_left_pressed)
			go_to_left_character(_selection);
			
		if (is_right_pressed)
			go_to_right_character(_selection);
			
		if (input.is_select_pressed())
			select_character(_selection);
	} else {
		if (input.is_back_pressed())
			back_to_character_selection(_selection);
			
		if (input.is_enter_pressed() && can_start)
			start();
	}
}