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

host.send_packet(HOST_EVENT.UPDATE_CLIENT, {
	selections: selection_raw,
	can_start: can_start
});