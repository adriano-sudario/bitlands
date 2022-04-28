gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
is_blink_shown = false;
ip = "";
has_joined = false;

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

function insert_clipboard() {
	var clipboard_text = clipboard_get_text();
	var acceptable_chars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."];
	
	for (var i = 1; i <= string_length(clipboard_text); i++) {
		var clip_char = string_char_at(clipboard_text, i);
		var can_insert = false;
		
		for (var c = 0; c < array_length(acceptable_chars); c++) {
			if (clip_char == acceptable_chars[c]) {
				can_insert = true;
				break;
			}
		}
		
		if (!can_insert)
			continue;
		
		if (clip_char != ".") {
			if (!can_insert_number())
				break;
			
			ip += clip_char;
			var ip_split = string_split(ip, ".");
			var ip_last_block = ip_split[array_length(ip_split) - 1];
	
			if (string_length(ip_last_block) == 4 && array_length(ip_split) < 4)
				auto_insert_dot();
		} else if (can_insert_dot()) {
			ip += clip_char;
		}
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