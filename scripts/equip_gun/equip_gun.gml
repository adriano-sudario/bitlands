/// @function equip_gun(owner)

function equip_gun(_owner){
	var weapon = instance_create_layer(_owner.x, _owner.y + 10, layer, obj_aiming_arm);
	weapon.owner = _owner;
	weapon.depth = -1;
	weapon.sprite_index = _owner.sprites_indexes.aiming_gun;
	return weapon;
}