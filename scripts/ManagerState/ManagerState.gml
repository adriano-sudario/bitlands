function ManagerState() : State() constructor {
	gui_width = display_get_gui_width();
	gui_height = display_get_gui_height();
	font_small = fnt_mono_small;
	font = fnt_mono;
	font_big = fnt_mono_big;
}