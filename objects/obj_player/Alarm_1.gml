if (!controls.is_disabled && controls.is_jump_held() && !has_jump) {
	vertical_force = JUMP_FORCE;
	has_jump = true;
}