/// @function hit_player_rollback(player, horizontal_gunpoint, angle)

function hit_player_rollback(_player, _horizontal_gunpoint, _angle) {
	_player.state.horizontal_force = 
		abs(lengthdir_x(6, _angle)) * sign(_player.x - _horizontal_gunpoint);
	_player.state.vertical_force = lengthdir_y(4, _angle) - 2;
	_player.state.horizontal_direction = sign(_player.state.horizontal_force);
	
	if (_player.state.vertical_force < 0)
		_player.y += _player.state.vertical_force;
	
	_player.state.is_dead = true;
	_player.sprite_index = _player.state.sprites_indexes.dead;
	
	if (_player.state.is_on_floor)
		_player.state.is_on_floor = false;
	
	if (_player.state.is_aiming) {
		_player.state.is_aiming = false;
		_player.state.remove_aiming_instance();
	}
}