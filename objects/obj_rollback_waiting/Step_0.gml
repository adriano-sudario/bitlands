if (can_start && (keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start))) {
	//rollback_define_player(obj_player_spawn_point_rollback);
	rollback_start_game();
	//room_goto(ShootingCharacterSelectionRollback);
}

//if (keyboard_check_pressed(vk_enter)) {
//	//rollback_start_game();
//	var hm = new InputManagerRollback();
//}