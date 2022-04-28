var _socket = ds_map_find_value(async_load, "id");
if (global.client == noone || _socket != global.client.socket)
	return;

var buffer = ds_map_find_value(async_load, "buffer"); 
var packet = json_parse(buffer_read(buffer, buffer_string));

switch (packet.command) {
	case NETWORK_EVENT.UPDATE:
		if (packet.data.event != noone)
			on_event(packet.data);
		
		for (var i = 0; i < array_length(packet.data.particles); i++)
			instantiate_particle(packet.data.particles[i]);
			
		for (var i = 0; i < array_length(packet.data.sounds); i++) {
			var _sound = packet.data.sounds[i];
			audio_sound_pitch(_sound.index, _sound.pitch);
			play_sound(_sound.index, _sound.priority, _sound.is_loop);
		}
		
		for (var i = 0; i < array_length(packet.data.states); i++) {
			var _state = packet.data.states[i];
			var _player = array_find(players, function(c, s) {
				return c.socket == s;
			}, _state.socket);
			update_player_state(_player, _state);
		}
		break;
	
	case NETWORK_EVENT.REMATCH:
		audio_stop_all();
		room_restart();
		break;
	
	case NETWORK_EVENT.SET_PLAYERS:
		global.game_state = { players: packet.data.players };
		break;
	
	case NETWORK_EVENT.REMOVE:
		audio_stop_all();
		room_goto(Menu);
		instance_destroy();
		break;
}
