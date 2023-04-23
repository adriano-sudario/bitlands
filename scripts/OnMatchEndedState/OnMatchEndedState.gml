function OnMatchEndedState(_sprites_indexes) : State() constructor {
	sprites_indexes = _sprites_indexes;
	input = new InputManagerRollback(owner.player_id, owner);
	
	function rematch() {
		var _players = [];
		
		for (var i = 0; i < instance_number(obj_player_rollback); i++) {
			var _player = instance_find(obj_player_rollback, i);
			array_push(_players, _player);
			
			with (_player) {
				state = new OnMatchState(state.sprites_indexes);
				
				for (var s = 0; s < array_length(global.spawn_points); s++) {
					var _spawn_point = global.spawn_points[s];
		
					if (player_id == s) {
						x = _spawn_point.x;
						y = _spawn_point.y;
						image_xscale = _spawn_point.image_xscale;
						break;
					}
				}
			}
		}
		
		with (obj_rollback_manager)
			state = new MatchManagerState();
		
		for (var i = 0; i < instance_number(obj_gun_rollback); i++)
			with (instance_find(obj_gun_rollback, i))
				instance_destroy();
		
		for (var i = 0; i < array_length(global.rollback_guns_on_match); i++) {
			var _gun = global.rollback_guns_on_match[i];
			instance_create_layer(_gun.x, _gun.y, "Pickups", obj_gun_rollback);
		}
	}
	
	function on_step() {
		input.Update();
		
		if (input.state.is_enter_pressed)
			rematch();
	}
	
	function on_animation_end() {
		if (owner.sprite_index == sprites_indexes.dead) {
			owner.image_speed = 0;
			owner.image_index = sprite_get_number(sprites_indexes.dead) - 1;
		}
	}
}