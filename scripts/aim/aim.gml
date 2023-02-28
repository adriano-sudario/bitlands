/// @function aim(owner)

function aim(_owner) {
	var aiming_arm = instance_create_layer(_owner.x, _owner.y + 10, _owner.layer, obj_aiming_arm);
	aiming_arm.owner = _owner;
	aiming_arm.depth = -1;
	aiming_arm.sprite_index = _owner.sprites_indexes.aiming_arm;
	return aiming_arm;
}