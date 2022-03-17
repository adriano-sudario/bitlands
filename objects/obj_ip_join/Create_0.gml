gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
is_blink_shown = false;
ip = "";

function get_underscores() {
	if (string_length(ip) == 0) {
		return "_";
	} else {
		var underscores = "";
		for (var i = 0; i < string_length(ip); i++)
			underscores += "_";
		return underscores;
	}
}

function can_insert_number() {
	var ip_split = string_split(ip, ".");
	var ip_last_block = ip_split[array_length(ip_split) - 1];
	
	return (array_length(ip_split) == 4 && string_length(ip_last_block) < 3) ||
		array_length(ip_split) < 4;
}

function auto_insert_dot() {
	var ip_split = string_split(ip, ".");
	var ip_last_block = ip_split[array_length(ip_split) - 1];
	
	if (string_length(ip_last_block) == 4 && array_length(ip_split) < 4) {
		ip_split[array_length(ip_split) - 1] = string_copy(ip_last_block, 1, 3);
		ip_split[array_length(ip_split)] = string_copy(ip_last_block, 4, 1);
	}
	else {
		return;
	}
		
	var new_ip = "";
	
	for (var i = 0; i < array_length(ip_split); i++)
		new_ip += i == array_length(ip_split) - 1 ? ip_split[i] : ip_split[i] + ".";
		
	ip = new_ip;
}

function can_insert_dot() {
	var ip_split = string_split(ip, ".");
	
	if (array_length(ip_split) >= 4)
		return false;
		
	for (var i = 0; i < array_length(ip_split); i++) {
		if (string_length(ip_split[i]) == 0 || string_length(ip_split[i]) > 3)
			return false;
	}
	
	return true;
}

function is_valid_ip_format() {
	var ip_split = string_split(ip, ".");
	
	if (array_length(ip_split) != 4)
		return false;
		
	for (var i = 0; i < array_length(ip_split); i++)
		if (string_length(ip_split[i]) == 0 || string_length(ip_split[i]) > 3)
			return false;
	
	return true;
}

function toggle_blink() {
	is_blink_shown = !is_blink_shown;
	wait_for_milliseconds(500, toggle_blink, STEP_EVENT.BEGIN_STEP);
}

toggle_blink();