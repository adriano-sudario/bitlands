/// @function get_character_sprite_description(character)

function get_character_sprite_description(_character, is_upper_case = true) {
	switch (_character) {
		case CHARACTER.GERALDO:
			return is_upper_case ? "GERALDO" : "Geraldo";
		
		case CHARACTER.RAIMUNDO:
			return is_upper_case ? "RAIMUNDO" : "Raimundo";
		
		case CHARACTER.SEBASTIAO:
			return is_upper_case ? "SEBASTIAO" : "Sebastiao";
		
		case CHARACTER.SEVERINO:
			return is_upper_case ? "SEVERINO" : "Severino";
	}
}