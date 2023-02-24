state = new ChoosingCharacterState();
image_speed = 0;
image_index = 0;

//font = fnt_mono_small;
//font_start_match = fnt_mono;
//font_height = font_get_size(font);
//blink_frames_count = 15;
//blink_current_frame = 0;
//show_text = true;
//characters_list = [
//	CHARACTER.SEVERINO, CHARACTER.GERALDO,
//	CHARACTER.RAIMUNDO, CHARACTER.SEBASTIAO
//];
//input = new InputManagerRollback();
//spawn_point = noone;
//is_ready = false;
//character_index = 0;
//chosen_index = -1;
//index = -1;
//vertical_margin = 25;
//client = noone;

//function spawn() {
//	for (var i = 0; i < array_length(global.spawn_points); i++) {
//		var _spawn_point = global.spawn_points[i];
		
//		if (player_id == i) {
//			x = _spawn_point.x;
//			y = _spawn_point.y;
//			image_xscale = _spawn_point.image_xscale;
//			break;
//		}
//	}
//}
	
//spawn();

//function load_selection() {
//	var _sprite = get_character_sprites(characters_list[0]);
//	sprite_index = _sprite.idle;
//	image_speed = 0;
//	//_selection.index = _player_id;
//}

//function go_to_right_character() {
//	character_index++;
//	if (character_index >= array_length(characters_list))
//		character_index = 0;
				
//	var _sprite = get_character_sprites(characters_list[character_index]);
//	sprite_index = _sprite.idle;
//}

//function go_to_left_character() {
//	character_index--;
//	if (character_index < 0)
//		character_index = array_length(characters_list) - 1;
				
//	var _sprite = get_character_sprites(characters_list[character_index]);
//	sprite_index = _sprite.idle;
//}

//function select_character() {
//	play_sound(sfx_menu_change, 5, false);
//	is_ready = true;
//	//chosen_index = array_length(chosen_characters);
//	//array_insert(chosen_characters, chosen_index, characters_list[character_index]);
//	image_speed = 1;
//}

//function back_to_character_selection() {
//	is_ready = false;
//	//array_delete(chosen_characters, _selection.chosen_index, 1);
//	chosen_index = -1;
//	image_speed = 0;
//}

//function back_to_menu() {
//	//transition_to_room(Menu);
//}

//function start() {
//	show_message("not implemented yet..");
//	return;
//	var _players = [];
//	for (var i = 0; i < array_length(selections); i++;) {
//		var selection_ready = array_find(selections, function(s, i) {
//			return s.is_ready && s.index == i;
//		}, i);
//		if (selection_ready != noone)
//			array_insert(_players, array_length(_players), {
//				character: characters_list[selection_ready.character_index],
//				index: selection_ready.index,
//				is_client: false,
//				socket: selection_ready.client == noone ? global.host.server :
//					selection_ready.client.socket,
//				spawn_point: {
//					image_xscale: selection_ready.spawn_point.image_xscale,
//					x: selection_ready.spawn_point.x,
//					y: selection_ready.spawn_point.y
//				}
//			});
//		else
//			break;
//	}
	
//	for (var i = 0; i < array_length(global.host.client_sockets); i++;) {
//		var _previous_client = array_find(_players, function(c, s) {
//			return c.is_client == true;
//		});
		
//		if (_previous_client != noone)
//			_previous_client.is_client = false;
		
//		var _client = array_find(_players, function(c, s) {
//			return c.socket == s;
//		}, global.host.client_sockets[i]);
		
//		_client.is_client = true;
		
//		send_packet(global.host.client_sockets[i], NETWORK_EVENT.UPDATE, {
//			players: _players,
//			has_match_started: true
//		})
//	}
	
//	global.game_state = { players: _players };
//	audio_stop_sound(stk_crujoa);
//	room_goto(ShootingMultiplayer);
//}

//function update() {
//	input.Update();
	
//	if (!is_ready) {
//		if (input.state.is_left_pressed)
//			go_to_left_character();
			
//		if (input.state.is_right_pressed)
//			go_to_right_character();
			
//		//if (input.state.is_select_pressed)
//		//	select_character();
		
//		//if (_input.back_pressed)
//		//	back_to_menu();
//	} else {
//		//if (_input.back_pressed)
//		//	back_to_character_selection(_selection);
			
//		//if (_input.enter_pressed && can_start)
//		//	start();
//	}
//}