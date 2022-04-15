if (!has_begun) {
	countdown_scale += countdown_growth_speed;
	if (countdown_scale >= 1) {
		if (!has_bipped) {
			var sfx = countdown == 3 ? sfx_countdown_high : sfx_countdown_low;
			audio_play_sound(sfx, 5, false);
			has_bipped = true;
		}
		countdown_scale = 1;
		current_countdown_fps_stopped++;
		if (current_countdown_fps_stopped >= countdown_fps_stopped) {
			has_bipped = false;
			countdown++;
			if (countdown > 3) {
				has_begun = true;
				audio_play_sound(stk_chaesd_by_teh_rievr, 100, true);
			} else {
				countdown_scale = 0;
				current_countdown_fps_stopped = 0;
			}
		}
	}
	global.host.send_packet_to_clients(NETWORK_EVENT.UPDATE, {
		event: SHOOTING_CLIENT_EVENT.COUNTDOWN,
		has_begun: has_begun,
		countdown: {
			scale: countdown_scale,
			value: countdown
		}
	});
	return;
}

var players_length = array_length(players);

if (players_length == 0)
	return;

var players_standing = [];

for (var i = 0; i < players_length; i++) {
	var player = players[i];
	if (!player.has_fallen_dead)
		array_insert(players_standing, array_length(players_standing), player);
}

var players_standing_length = array_length(players_standing);
has_match_ended = players_standing_length <= 1;

if (has_match_ended && !has_menu_appeared
	&& !instance_exists(obj_menu_simple)) {
	if (players_standing_length == 1) {
		winning_player = players_standing[0];
		winning_player.sprite_index = winning_player.sprites_indexes.idle;
		winning_player.cancel_movement();
		if (winning_player.is_aiming)
			winning_player.remove_aiming_instance();
	}
	with (instance_create_layer(0, 0, "Helpers", obj_menu_simple)) {
		margin = 0;
		horizontal_position = gui_width * .5;
		vertical_position = gui_height * .5 - font_height - 25;
		horizontal_align = fa_center;
		vertical_align = fa_center;
		options = get_ending_menu_items();
		items = [options.back_to_main_menu, options.rematch];
		mount_items(0);
	}
	has_menu_appeared = true;
	
	global.host.send_packet_to_clients(NETWORK_EVENT.UPDATE, {
		event: SHOOTING_CLIENT_EVENT.END_MATCH,
		winner: winning_player != noone ? winning_player.socket : noone
	});
}

if (has_match_ended)
	return;

var teste = host.aiming_instance == noone;
var teste = host.cartrige == noone;
var states = [{
	x: host.x,
	y: host.y,
	image_xscale: host.image_xscale,
	is_dead: host.is_dead,
	is_aiming: host.is_aiming,
	is_reloading: host.is_reloading,
	has_gun: host.has_gun,
	bullets_count: host.bullets_count,
	socket: global.host.server,
	animation: {
		sprite_index: host.sprite_index,
		image_index: host.image_index
	},
	aiming_instance: host.aiming_instance == noone ? noone : {
		angle: host.aiming_instance.image_angle,
		recoil: host.aiming_instance.recoil,
		aiming: host.aiming_instance.aiming
	},
	cartrige: host.cartrige == noone ? noone : {
		shake_params: host.cartrige.shake_params
	}
}];

for (var i = 0; i < array_length(clients); i++) {
	var _client = clients[i];
	array_push(states, {
		x: _client.x,
		y: _client.y,
		image_xscale: _client.image_xscale,
		is_dead: _client.is_dead,
		is_aiming: _client.is_aiming,
		is_reloading: _client.is_reloading,
		has_gun: _client.has_gun,
		bullets_count: _client.bullets_count,
		socket: _client.socket,
		animation: {
			sprite_index: _client.sprite_index,
			image_index: _client.image_index
		},
		aiming_instance: _client.aiming_instance == noone ? noone : {
			angle: _client.aiming_instance.image_angle,
			recoil: _client.aiming_instance.recoil,
			aiming: _client.aiming_instance.aiming
		},
		cartrige: _client.cartrige == noone ? noone : {
			shake_params: _client.cartrige.shake_params
		}
	});
}

global.host.send_packet_to_clients(NETWORK_EVENT.UPDATE, {
	event: noone,
	states: states
});
