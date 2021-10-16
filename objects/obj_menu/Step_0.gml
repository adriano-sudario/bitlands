if (window_get_fullscreen())
	fullscreen_item.text = "Fs Off";
else
	fullscreen_item.text = "Fs On";

if (!has_all_items_arrived) {
	var last_item = items[array_length(items) - 1];
	var last_item_previous_x = last_item.x;
	for (var i = array_length(items) - 1; i >= 0; i--) {
		var item = items[i];
		var is_leaving = item.x < horizontal_position;
		var is_moving = i == array_length(items) - 1
			|| (!is_leaving && 
				items[i + 1].x < gui_width + (starting_position_offset * .5))
			|| (is_leaving && 
				items[i + 1].x > gui_width + (starting_position_offset * .5));
		
		var previous_x = item.x;
		
		if (is_moving) {
			item.x += (horizontal_position - item.x) / items_speed;
		}
		
		if (ceil(item.x) - ceil(previous_x) > 0)
			is_disabled = false;
	}
	has_all_items_arrived = last_item.x == horizontal_position;
	is_disabled = is_leaving || floor(last_item_previous_x - last_item.x) > 1;
}

if (is_disabled) {
	return;
}

previous_up_held = current_up_held;
previous_down_held = current_down_held;
current_up_held = controls.is_up_held();
current_down_held = controls.is_down_held();
var is_up_pressed = !previous_up_held && current_up_held;
var is_down_pressed = !previous_down_held && current_down_held;

//if (is_up_pressed || is_down_pressed)
//	audio_play_sound(sfxMenuChange, 5, false);

selected_item += is_up_pressed - is_down_pressed;

if (selected_item < 0)
	selected_item = array_length(items) - 1;
else if (selected_item >= array_length(items))
	selected_item = 0;
	
if (controls.is_select_pressed()) {
	//if (selected_item > 1)
	//	audio_play_sound(sfxMenuConfirm, 10, false);
	items[selected_item].on_selected();
}