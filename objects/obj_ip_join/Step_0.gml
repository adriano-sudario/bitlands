if (!has_joined && keyboard_check_pressed(vk_enter) && is_valid_ip_format()) {
	has_joined = create_client(ip);
	if (has_joined) {
		transition_to_room(ShootingCharacterSelectionMultiplayer);
	}
	return;
}

if (keyboard_check_pressed(vk_backspace) && string_length(ip) != 0)
	ip = string_copy(ip, 1, string_length(ip) - 1);

if (!can_insert_number())
	return;

var number_keys = [
	["0", vk_numpad0],
	["1", vk_numpad1],
	["2", vk_numpad2],
	["3", vk_numpad3],
	["4", vk_numpad4],
	["5", vk_numpad5],
	["6", vk_numpad6],
	["7", vk_numpad7],
	["8", vk_numpad8],
	["9", vk_numpad9],
];

for (var i = 0; i < array_length(number_keys); i++) {
	if (keyboard_check_pressed(ord(number_keys[i][0])) || keyboard_check_pressed(number_keys[i][1])) {
		ip += number_keys[i][0];
		auto_insert_dot();
		break;
	}
}

if (keyboard_check_pressed(190) && can_insert_dot())
	ip += ".";
	
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
	insert_clipboard();