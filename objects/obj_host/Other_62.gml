if (ds_map_find_value(async_load, "id") == get &&
	(ds_map_find_value(async_load, "status") == 0))
    host_ip = ds_map_find_value(async_load, "result");