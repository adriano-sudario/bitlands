//rollback_define_input({
//	gp_lh_axis: gp_axislh,
//	left: [gp_padl, vk_left, ord("A")],
//	right: [gp_padr, vk_right, ord("D")],
//	//left: [gp_axislh, gp_padl, vk_left, ord("A")],
//	//right: [gp_axislh, gp_padr, vk_right, ord("D")],
//	//up: [gp_axislv, gp_padu, vk_up, ord("W")],
//	//down: [gp_axislv, gp_padd, vk_down, ord("S")],
//	//jump: [gp_face1, vk_space],
//	//aiming: [gp_shoulderr, mb_right],
//	//shooting: [gp_face3, mb_left],
//	//reload: [gp_shoulderl, mb_middle],
//	//select: [gp_face1, gp_start, vk_space, vk_enter],
//	//m_axisx: m_axisx,
//    //m_axisy: m_axisy,
//	select: [gp_face1, vk_space],
//	enter: [gp_start, vk_enter],
//	back: [gp_face2, vk_escape, vk_backspace],
//});

//rollback_use_manual_start();

if (!rollback_join_game())
	rollback_create_game(4, false);

//load_selection();