with (instance_create_layer(0, 0, "Objects", obj_menu_simple)) {
	options = get_options_items();
	items = [options.back, options.sound, options.show_aim, options.fullscreen];
	mount_items(0);
}
