/// @function check_for_host()

function check_for_host() {
	var has_host = variable_global_exists("host");
	if (!has_host)
		instance_destroy();
	
	return has_host;
}