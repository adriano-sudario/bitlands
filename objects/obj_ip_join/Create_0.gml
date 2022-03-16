gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
horizontal_position = gui_width * .5;
vertical_position = (gui_height * .5);
shown_text = "_ _ _ . _ _ _ . _ _ _ - _ _";
is_next_ip_bar_shown = false;
ip = "";

function get_formatted_ip_text() {
	var formatted_ip_text = "";
	
	for (var i = 1; i < 12; ++i) {
		if (i <= string_length(ip))
			formatted_ip_text += string_char_at(ip, i);
		else
			formatted_ip_text += "_";
	}
	
	formatted_ip_text = string_insert(".", formatted_ip_text, 4);
	formatted_ip_text = string_insert(".", formatted_ip_text, 8);
	formatted_ip_text = string_insert("-", formatted_ip_text, 12);
	return formatted_ip_text;
}

function hide_next_ip_bar_shown() {
	var current_ip_length = string_length(ip);
	var underscores_count = 0;
	
	for (var i = 0; i < string_length(shown_text); i++) {
		var current_char = string_char_at(shown_text, i);
		
		if (current_char == "_")
			underscores_count++;
			
		if (underscores_count == current_ip_length + 1) {
			shown_text = string_replace_at(shown_text, i + 1, " ");
			break;
		}
	}
}

function show_next_ip_bar_shown() {
	var was_previous_char_space = false;
	
	for (var i = 0; i < string_length(shown_text); i++) {
		var current_char = string_char_at(shown_text, i);
		
		if (current_char == " " && was_previous_char_space) {
			shown_text = string_replace_at(shown_text, i, "_");
			break;
		}
		
		was_previous_char_space = current_char == " ";
	}
}

function update_shown_text() {
	if (is_next_ip_bar_shown)
		show_next_ip_bar_shown();
	else
		hide_next_ip_bar_shown();
		
	is_next_ip_bar_shown = !is_next_ip_bar_shown;
	
	wait_for_milliseconds(500, update_shown_text);
}

wait_for_milliseconds(500, update_shown_text);

//update_shown_text();