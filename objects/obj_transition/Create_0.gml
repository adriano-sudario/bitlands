gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
rectangle_max_height = gui_height * .5;
is_on_hold = true;
elapsed_time = 0;
milliseconds_before_start = 500;
mode = TRANSITION_MODE.OFF;
percent = 0;
on_finish = function() { };
send_back_object = noone;
depth = -999;