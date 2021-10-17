/// @function hit_player(player, horizontal_gunpoint, angle)

function hit_player(_player, _horizontal_gunpoint, _angle) {
	_player.horizontal_force = 
		abs(lengthdir_x(6, _angle)) * sign(_player.x - _horizontal_gunpoint);
	_player.vertical_force = lengthdir_y(4, _angle) - 2;
	_player.horizontal_direction = sign(_player.horizontal_force);
	_player.grv = .2;
	if (_player.vertical_force < 0)
		_player.y += _player.vertical_force;
	_player.is_dead = true;
	_player.is_on_floor = false;
}