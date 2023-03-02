/// @function aim(owner)

function aim(_owner, _is_rollback = false) {
	var _aiming_arm = instance_create_layer(_owner.x, _owner.y + 10, _owner.layer, obj_aiming_arm);
	_aiming_arm.owner = _owner;
	_aiming_arm.depth = -1;
	_aiming_arm.sprite_index = _is_rollback ? _owner.state.sprites_indexes.aiming_arm
		: _owner.sprites_indexes.aiming_arm;
	
	return _aiming_arm;
}