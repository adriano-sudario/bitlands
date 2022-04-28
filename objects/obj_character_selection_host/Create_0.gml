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
clients_in_room_count = 0;
selections = [];
host_ip = http_get("https://ipecho.net/plain");

for (var i = 0; i < 4; i++;) {
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

function select_input(_client_socket = noone) {
	var selection = selections[0];
	
	if (_client_socket != noone) {
		for (var i = 1; i < array_length(selections); i++) {
			if (selections[i].client == noone) {
				selection = selections[i];
				break;
			}
		}
	}
	
	selection.spawn_point.visible = true;
	selection.vertical_margin += 25;
	selection.character_index = 0;
	var sprite = get_character_sprites(characters_list[0]);
	selection.spawn_point.sprite_index = sprite.idle;
	selection.spawn_point.image_speed = 0;
	selection.index = selection.spawn_point.order;
	
	if (_client_socket != noone)
		selection.client = {
			socket: _client_socket,
			previous_left_input: false,
			previous_right_input: false,
			current_left_input: false,
			current_right_input: false,
		};
	
	clients_in_room_count++;
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

function get_client_selection(_client_socket) {
	return array_find(selections, function(s, cs) {
		return s.client != noone && s.client.socket == cs
	}, _client_socket);
}

function connect_client(_client_socket) {
	array_push(global.host.client_sockets, _client_socket);
	select_input(_client_socket);
}

function disconnect_client(_client_socket) {
	leave_room(_client_socket);
	for (var i = 0; i < array_length(global.host.client_sockets);i++)
		if (global.host.client_sockets[i] == _client_socket)
			array_delete(global.host.client_sockets, i, 1);
	
	clients_in_room_count--;
	network_destroy(_client_socket);
}

function leave_room(_client_socket) {
	var selection = get_client_selection(_client_socket);
	if (selection == noone)
		return;
	selection.client = noone;
	selection.spawn_point.visible = false;
	selection.vertical_margin -= 25;
	selection.character_index = -1;
}

function back_to_character_selection(_selection) {
	_selection.is_ready = false;
	array_delete(chosen_characters, _selection.chosen_index, 1);
	_selection.chosen_index = array_length(chosen_characters);
	_selection.spawn_point.image_speed = 0;
}

function back_to_menu(_socket = noone) {
	if (_socket == noone) {
		close_server();
		transition_to_room(Menu);
		instance_destroy();
	} else {
		send_packet(_socket, NETWORK_EVENT.REMOVE);
	}
}

function update_clients() {
	var selection_raw = [];

	for (var i = 0; i < array_length(selections); i++) {
		var selection = selections[i];
		selection_raw[i] = {
			visible: selection.spawn_point.visible,
			sprite_index: selection.spawn_point.sprite_index,
			image_speed: selection.spawn_point.image_speed,
			spawn_point: noone,
			is_ready: selection.is_ready,
			is_on_room: selection.client != noone,
			character_index: selection.character_index,
			index: selection.index,
			vertical_margin: selection.vertical_margin
		};
	}

	global.host.send_packet_to_clients(NETWORK_EVENT.UPDATE, {
		selections: selection_raw,
		can_start: can_start,
		has_match_started: false
	});
}

function start() {
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
		
		if (input.is_back_pressed())
			back_to_menu();
	} else {
		if (input.is_back_pressed())
			back_to_character_selection(_selection);
			
		if (input.is_enter_pressed() && can_start)
			start();
	}
}

function update_clients_selections(_client_socket, _client_input) {
	var selection = get_client_selection(_client_socket);
	
	if (selection == noone)
		return;
		
	var client = selection.client;
	client.previous_left_input = client.current_left_input;
	client.previous_right_input = client.current_right_input;
	client.current_left_input = _client_input.is_left_held;
	client.current_right_input = _client_input.is_right_held;
	
	if (!selection.is_ready) {
		var is_left_pressed = !client.previous_left_input && client.current_left_input;
		var is_right_pressed = !client.previous_right_input && client.current_right_input;
			
		if (is_left_pressed)
			go_to_left_character(selection);
			
		if (is_right_pressed)
			go_to_right_character(selection);
			
		if (_client_input.is_select_pressed)
			select_character(selection);
		
		if (_client_input.is_back_pressed)
			back_to_menu(_client_socket);
	} else {
		if (_client_input.is_back_pressed)
			back_to_character_selection(selection);
			
		if (_client_input.is_enter_pressed && can_start)
			start();
	}
}