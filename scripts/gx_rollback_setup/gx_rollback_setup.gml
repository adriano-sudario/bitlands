function gx_rollback_setup() {
	//rollback_use_late_join();
	rollback_define_player(obj_player_spawn_point_rollback);
	
	//InputManagerRollback.Setup();
	
	rollback_define_input({
		gamepad_left_horizontal_axis: gp_axislh,
		gamepad_left_vertical_axis: gp_axislv,
		gamepad_right_horizontal_axis: gp_axisrh,
		gamepad_right_vertical_axis: gp_axisrv,
		gamepad_directional_left: gp_padl,
		gamepad_directional_right: gp_padr,
		gamepad_directional_up: gp_padu,
		gamepad_directional_down: gp_padd,
		gamepad_shoulder_right: gp_shoulderr,
		gamepad_shoulder_left: gp_shoulderl,
		gamepad_face_one: gp_face1,
		gamepad_face_two: gp_face2,
		gamepad_face_three: gp_face3,
		gamepad_start: gp_start,
			
		mouse_horizontal_axis: m_axisx,
		mouse_vertical_axis: m_axisy,
		mouse_button_left: mb_left,
		mouse_button_middle: mb_middle,
		mouse_button_right: mb_right,
			
		keyboard_left: vk_left,
		keyboard_right: vk_right,
		keyboard_up: vk_up,
		keyboard_down: vk_down,
		keyboard_a: ord("A"),
		keyboard_d: ord("D"),
		keyboard_w: ord("W"),
		keyboard_s: ord("S"),
		keyboard_space: vk_space,
		keyboard_enter: vk_enter,
		keyboard_escape: vk_escape,
		keyboard_backspace: vk_backspace,
	});

	rollback_use_manual_start();
}