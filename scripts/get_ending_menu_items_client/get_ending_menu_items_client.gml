/// @function get_ending_menu_items_client()

function get_ending_menu_items_client() {
	var rematch_item = {
		x: 0,
		y: 0,
		text: "Rematch",
		on_selected: function() {
			global.client.send_packet_to_server(NETWORK_EVENT.REMATCH);
		}
	};
	var back_to_main_menu_item = {
		x: 0,
		y: 0,
		text: "Back to main menu",
		on_selected: function(_menu_id) {
			global.client.send_packet_to_server(NETWORK_EVENT.REMOVE);
			audio_stop_all();
			instance_destroy(_menu_id);
			transition_to_room(Menu);
		}
	};
	
	return {
		rematch: rematch_item,
		back_to_main_menu: back_to_main_menu_item
	};
}
