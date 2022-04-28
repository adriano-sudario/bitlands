/// @function get_ending_menu_items_host()

function get_ending_menu_items_host() {
	var rematch_item = {
		x: 0,
		y: 0,
		text: "Rematch",
		on_selected: function() {
			global.host.send_packet_to_clients(NETWORK_EVENT.REMATCH);
			audio_stop_all();
			room_restart();
		}
	};
	var back_to_main_menu_item = {
		x: 0,
		y: 0,
		text: "Back to main menu",
		on_selected: function(_menu_id) {
			global.host.send_packet_to_clients(NETWORK_EVENT.REMOVE);
			close_server();
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
