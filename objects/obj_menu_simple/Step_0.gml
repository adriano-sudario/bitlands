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
	items[selected_item].on_selected(self.id);
}