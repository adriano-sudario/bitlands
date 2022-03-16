if (string_length(ip) == 11 && keyboard_check_pressed(vk_enter)) {
	room_goto(ShootingCharacterSelectionMultiplayer);
	return;
}

if (keyboard_check_pressed(vk_backspace))
	ip = string_copy(ip, 1, string_length(ip) - 1);

if (string_length(ip) >= 11)
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
	if (keyboard_check_pressed(ord(number_keys[i][0])) || keyboard_check_pressed(number_keys[i][1]))
		ip += number_keys[i][0];
}

if (string_length(ip) > 11)
	ip = string_copy(ip, 1, 11);