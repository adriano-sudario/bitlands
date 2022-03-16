gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
is_blink_shown = false;
ip = "";

function get_formatted_ip_text() {
	var formatted_ip_text = "";
	
	for (var i = 1; i < 12; ++i) {
		var current_ip_length = string_length(ip);
		if (i <= current_ip_length)
			formatted_ip_text += string_char_at(ip, i);
		else if (!is_blink_shown && i - 1 == current_ip_length)
			formatted_ip_text += " ";
		else
			formatted_ip_text += "_";
	}
	
	formatted_ip_text = string_insert(".", formatted_ip_text, 4);
	formatted_ip_text = string_insert(".", formatted_ip_text, 8);
	formatted_ip_text = string_insert("-", formatted_ip_text, 12);
	return formatted_ip_text;
}

function update() {
	is_blink_shown = !is_blink_shown;
	wait_for_milliseconds(500, update, STEP_EVENT.BEGIN_STEP);
}

update();