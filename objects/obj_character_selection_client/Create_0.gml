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
selections = [];
timeout_delay = noone;

for (var i = 0; i < 4; i++;) {
	array_insert(selections, i,
	{
		spawn_point: noone,
		input: noone,
		is_ready: false,
		is_on_room: false,
		character_index: -1,
		index: -1,
		vertical_margin: 15
	});
}

function leave() {
	global.client.send_packet_to_server(NETWORK_EVENT.REMOVE);
	room_goto(Menu);
	instance_destroy();
}

function update(_host_data) {
	can_start = _host_data.can_start;
	
	for (var i = 0; i < array_length(selections); i++) {
		var host_selection = _host_data.selections[i];
		var selection = selections[i];
		var spawn_point = selection.spawn_point;
		
		if (host_selection.character_index >= 0) {
			var sprite = get_character_sprites(characters_list[host_selection.character_index]);
			spawn_point.sprite_index = sprite.idle;
		}
		
		spawn_point.visible = host_selection.visible;
		spawn_point.sprite_index = host_selection.sprite_index;
		spawn_point.image_speed = host_selection.image_speed;
		selection.is_ready = host_selection.is_ready;
		selection.character_index = host_selection.character_index;
		selection.index = host_selection.index;
		selection.vertical_margin = host_selection.vertical_margin;
		selection.is_on_room = host_selection.is_on_room;
	}
}