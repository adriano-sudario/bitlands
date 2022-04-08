/// @function check_for_client()

function check_for_client() {
	var has_no_host = !variable_global_exists("client");
	if (has_no_host)
		instance_destroy();
	
	return has_no_host;
}