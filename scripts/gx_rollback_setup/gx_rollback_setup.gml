function gx_rollback_setup() {
	//rollback_use_late_join();
	rollback_define_player(obj_player_rollback);
	InputManagerRollback.Setup();
	rollback_use_manual_start();
}