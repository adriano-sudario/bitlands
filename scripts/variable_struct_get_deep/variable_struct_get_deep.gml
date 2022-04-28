/// @function variable_struct_get_deep(struct, name);

function variable_struct_get_deep(_struct, _name) {
	var split = string_split(_name, ".");
	var deeper_struct = _struct;
	
	for (var i = 0; i < array_length(split); i++)
		deeper_struct = variable_struct_get(deeper_struct, split[i]);
		
	return deeper_struct;
}