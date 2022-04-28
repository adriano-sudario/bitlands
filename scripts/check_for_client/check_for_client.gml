/// @function check_for_client()

function check_for_client() {
	var has_host = variable_global_exists("client");
	if (!has_host)
		instance_destroy();
	
	return has_host;
}