previous_down_input = current_down_input;
previous_up_input = current_up_input;
current_down_input = input.is_down_held();
current_up_input = input.is_up_held();
	
var previous_up_held = previous_up_input;
var previous_down_held = previous_down_input;
var current_up_held = current_up_input;
var current_down_held = current_down_input;
var is_up_pressed = !previous_up_held && current_up_held;
var is_down_pressed = !previous_down_held && current_down_held;

if (is_up_pressed || is_down_pressed)
	play_sound(sfx_menu_change, 5, false);

selected_item += is_up_pressed - is_down_pressed;

if (selected_item < 0)
	selected_item = array_length(items) - 1;
else if (selected_item >= array_length(items))
	selected_item = 0;
	
if (input.is_select_pressed()) {
	play_sound(sfx_shoot, 10, false);
	items[selected_item].on_selected(self.id);
}