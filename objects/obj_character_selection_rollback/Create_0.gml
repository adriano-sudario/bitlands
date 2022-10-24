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
current_left_inputs = [];
current_right_inputs = [];
previous_left_inputs = [];
previous_right_inputs = [];
players_in_room_count = 0;
selections = [];

for (var i = 0; i < 4; i++;) {
	array_insert(current_left_inputs, i, false);
	array_insert(current_right_inputs, i, false);
	array_insert(previous_left_inputs, i, false);
	array_insert(previous_right_inputs, i, false);
	
	array_insert(selections, i,
	{
		spawn_point: noone,
		is_ready: false,
		character_index: -1,
		chosen_index: -1,
		index: -1,
		vertical_margin: 15,
		client: noone
	});
}

function load_selection(_player_id) {
	var _selection = selections[_player_id];
	_selection.spawn_point.visible = true;
	_selection.vertical_margin += 25;
	_selection.character_index = 0;
	var _sprite = get_character_sprites(characters_list[0]);
	_selection.spawn_point.sprite_index = _sprite.idle;
	_selection.spawn_point.image_speed = 0;
	_selection.index = _player_id;
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

function get_client_selection() {
	return array_find(selections, function(s, cs) {
		return s.index == player_id
	});
}

function back_to_character_selection(_selection) {
	_selection.is_ready = false;
	array_delete(chosen_characters, _selection.chosen_index, 1);
	_selection.chosen_index = array_length(chosen_characters);
	_selection.spawn_point.image_speed = 0;
}

function back_to_menu() {
	transition_to_room(Menu);
}

function start() {
	show_message("not implemented yet..");
	return;
	var _players = [];
	for (var i = 0; i < array_length(selections); i++;) {
		var selection_ready = array_find(selections, function(s, i) {
			return s.is_ready && s.index == i;
		}, i);
		if (selection_ready != noone)
			array_insert(_players, array_length(_players), {
				character: characters_list[selection_ready.character_index],
				index: selection_ready.index,
				is_client: false,
				socket: selection_ready.client == noone ? global.host.server :
					selection_ready.client.socket,
				spawn_point: {
					image_xscale: selection_ready.spawn_point.image_xscale,
					x: selection_ready.spawn_point.x,
					y: selection_ready.spawn_point.y
				}
			});
		else
			break;
	}
	
	for (var i = 0; i < array_length(global.host.client_sockets); i++;) {
		var _previous_client = array_find(_players, function(c, s) {
			return c.is_client == true;
		});
		
		if (_previous_client != noone)
			_previous_client.is_client = false;
		
		var _client = array_find(_players, function(c, s) {
			return c.socket == s;
		}, global.host.client_sockets[i]);
		
		_client.is_client = true;
		
		send_packet(global.host.client_sockets[i], NETWORK_EVENT.UPDATE, {
			players: _players,
			has_match_started: true
		})
	}
	
	global.game_state = { players: _players };
	audio_stop_sound(stk_crujoa);
	room_goto(ShootingMultiplayer);
}

function update_selection(_player_id) {
	var _input = rollback_get_input(_player_id);
	var _selection = selections[_player_id];
	previous_left_input = current_left_input[_player_id];
	previous_right_input = current_right_input[_player_id];
	current_left_input = _input.left;
	current_right_input = _input.right;
	
	if (!_selection.is_ready) {
		var is_left_pressed = !previous_left_input && current_left_input;
		var is_right_pressed = !previous_right_input && current_right_input;
			
		if (is_left_pressed)
			go_to_left_character(_selection);
			
		if (is_right_pressed)
			go_to_right_character(_selection);
			
		if (_input.select_pressed)
			select_character(_selection);
		
		if (_input.back_pressed)
			back_to_menu();
	} else {
		if (_input.back_pressed)
			back_to_character_selection(_selection);
			
		if (_input.enter_pressed && can_start)
			start();
	}
}