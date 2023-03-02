#macro RESOLUTION_WIDTH 816
#macro RESOLUTION_HEIGHT 624

display_set_gui_size(RESOLUTION_WIDTH, RESOLUTION_HEIGHT);

show_aim = false;
is_muted = false;

function toggle_fullscreen() {
	window_set_fullscreen(!window_get_fullscreen());
}

if (os_type == os_gxgames) {
	gx_rollback_setup();
	
	if (rollback_join_game(true))
		room_goto(RollbackRoom);
}