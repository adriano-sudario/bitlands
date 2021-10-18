previous_up_held = current_up_held;
previous_down_held = current_down_held;
current_up_held = controls.is_up_held();
current_down_held = controls.is_down_held();
var is_up_pressed = !previous_up_held && current_up_held;
var is_down_pressed = !previous_down_held && current_down_held;

if (is_up_pressed || is_down_pressed)
	audio_play_sound(sfx_menu_change, 5, false);

selected_item += is_up_pressed - is_down_pressed;

if (selected_item < 0)
	selected_item = array_length(items) - 1;
else if (selected_item >= array_length(items))
	selected_item = 0;
	
if (controls.is_select_pressed()) {
	audio_play_sound(sfx_shoot, 10, false);
	items[selected_item].on_selected(self.id);
}