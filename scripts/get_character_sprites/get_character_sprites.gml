/// @function get_character_sprites(character)

function get_character_sprites(_character) {
	switch (_character) {
		case CHARACTER.GERALDO:
			return {
				idle: spr_geraldo_idle,
				run: spr_geraldo_run,
				air: spr_geraldo_air,
				drop_weapon: spr_geraldo_drop_weapon,
				aim: spr_geraldo_aim,
				aiming_gun: spr_geraldo_aiming_gun,
				reload: spr_geraldo_reload,
				dead: spr_geraldo_dead
			};
		
		case CHARACTER.RAIMUNDO:
			return {
				idle: spr_raimundo_idle,
				run: spr_raimundo_run,
				air: spr_raimundo_air,
				drop_weapon: spr_raimundo_drop_weapon,
				aim: spr_raimundo_aim,
				aiming_gun: spr_raimundo_aiming_gun,
				reload: spr_raimundo_reload,
				dead: spr_raimundo_dead
			};
		
		case CHARACTER.SEBASTIAO:
			return {
				idle: spr_sebastiao_idle,
				run: spr_sebastiao_run,
				air: spr_sebastiao_air,
				drop_weapon: spr_sebastiao_drop_weapon,
				aim: spr_sebastiao_aim,
				aiming_gun: spr_sebastiao_aiming_gun,
				reload: spr_sebastiao_reload,
				dead: spr_sebastiao_dead
			};
		
		case CHARACTER.SEVERINO:
			return {
				idle: spr_severino_idle,
				run: spr_severino_run,
				air: spr_severino_air,
				drop_weapon: spr_severino_drop_weapon,
				aim: spr_severino_aim,
				aiming_gun: spr_severino_aiming_gun,
				reload: spr_severino_reload,
				dead: spr_severino_dead
			};
	}
}