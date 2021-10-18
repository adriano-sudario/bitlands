#macro RESOLUTION_WIDTH 816
#macro RESOLUTION_HEIGHT 624

display_set_gui_size(RESOLUTION_WIDTH, RESOLUTION_HEIGHT);

current_soundtrack = noone;

//global.game_state = {
//	players: [
//		{
//			input: 0,
//			character: CHARACTER.GERALDO,
//			index: 1
//		},
//		{
//			input: 1,
//			character: CHARACTER.RAIMUNDO,
//			index: 2
//		},
//		//{
//		//	input: 2,
//		//	character: CHARACTER.SEBASTIAO,
//		//	index: 3
//		//}
//	]
//}

function toggle_fullscreen() {
	window_set_fullscreen(!window_get_fullscreen());
}