if (debug_mode && keyboard_check(vk_control)) {
	//var macros = "C:\\\\Users\\\\adriano.sudario\\\\AppData\\\\Roaming\\\\GameMakerStudio2\\\\Cache\\\\GMS2CACHE\\\\bitlands_9C82AED5\\\\macros.json";
	//var project_dir = "C:\\\\Users\\\\adriano.sudario\\\\Repos\\\\bitlands";
	//var preferences = "C:\\\\Users\\\\adriano.sudario\\\\AppData\\\\Roaming\\\\GameMakerStudio2\\\\Cache\\\\GMS2CACHE\\\\bitlands_9C82AED5\\\\preferences.json";
	//var project_path = "C:\\\\Users\\\\adriano.sudario\\\\Repos\\\\bitlands\\\\bitlands.yyp";
	//var temp_folder_unmapped = "C:\\\\Users\\\\adriano.sudario\\\\AppData\\\\Local\\\\GameMakerStudio2\\\\GMS2TEMP";
	//var user_dir = "C:\\\\Users\\\\adriano.sudario\\\\AppData\\\\Roaming/GameMakerStudio2\\\\adriano_sudario_2823029";
	//var target_options = "C:\\\\Users\\\\adriano.sudario\\\\AppData\\\\Roaming\\\\GameMakerStudio2\\\\Cache\\\\GMS2CACHE\\\\bitlands_9C82AED5\\\\targetoptions.json";
	
	//if (!variable_instance_exists(self, "help_port"))
	//	help_port = 51291;
	//else
	//	help_port++;
	
	//var build_options_string = "{ \"debug\": \"False\", " +
	//	"\"compile_output_file_name\": \"Y:/bitlands_3979EC32_VM/bitlands.win\", " + 
	//	"\"projectName\": \"bitlands\", \"useShaders\": \"True\", \"config\": \"Default\", " +
	//	"\"outputFolder\": \"Y:/bitlands_3979EC32_VM/\", \"projectName\": \"bitlands\", " +
	//	"\"macros\": \"" + macros + "\", " +
	//	"\"projectDir\": \"" + project_dir + "\", " +
	//	"\"preferences\": \"" + preferences + "\", " +
	//	"\"projectPath\": \"" + project_path + "\", " +
	//	"\"tempFolder\": \"Y:/\", " + 
	//	"\"tempFolderUnmapped\": \"" + temp_folder_unmapped + "\", " +
	//	"\"userDir\": \"" + user_dir + "\", " +
	//	"\"runtimeLocation\": \"X:/\", " +
	//	"\"targetOptions\": \"" + target_options + "\", " +
	//	"\"targetMask\": \"64\", " + 
	//	"\"applicationPath\": \"C:\\\\Program Files\\\\GameMaker Studio 2\\\\GameMakerStudio.exe\", " +
	//	"\"verbose\": \"False\", \"SteamIDE\": \"False\", " + 
	//	"\"helpPort\": \"" + string(help_port) + "\" }";
	//var file = file_text_open_write("build.tff");
	//file_text_write_string(file, build_options_string);
	//file_text_close(file);
	//var igor_exe = "C:/ProgramData/GameMakerStudio2/Cache/runtimes/runtime-" 
	//	+ GM_runtime_version + "/bin/Igor.exe";
	//var options_path = game_save_id  + "/build.tff";
	//var args = "-j=8 -options=\"" + options_path + "\" -v -- Windows Run";
	//var new_bff_cmd = @'
	//$file = "$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build2.bff"

	//if (-not(Test-Path -Path $file -PathType Leaf)) { $file = "$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build.bff" }

	//$a = Get-Content $file | ConvertFrom-Json

	//$a.debug = "False"
	//$a.helpPort = [string]([int]$a.helpPort + 1)
	//$a.debuggerPort = [string]([int]$a.debuggerPort + 1)

	//$a | ConvertTo-Json | set-content "$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build2.bff"';
	//var new_bff_cmd = "$file = \"$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build2.bff\"";
	//new_bff_cmd += "\n";
	//new_bff_cmd += "if (-not(Test-Path -Path $file -PathType Leaf)) { $file = \"$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build.bff\" }";
	//new_bff_cmd += "\n";
	//new_bff_cmd += "$a = Get-Content $file | ConvertFrom-Json";
	//new_bff_cmd += "\n";
	//new_bff_cmd += "$a.debug = \"False\"";
	//new_bff_cmd += "\n";
	//new_bff_cmd += "$a.helpPort = [string]([int]$a.helpPort + 1)";
	//new_bff_cmd += "\n";
	//new_bff_cmd += "$a.debuggerPort = [string]([int]$a.debuggerPort + 1)";
	//new_bff_cmd += "\n";
	//new_bff_cmd += "$a | ConvertTo-Json | set-content \"$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build2.bff\"";
	//new_bff_cmd += "\n";
	show_debug_message(new_game_instance(GM_runtime_version));
	var teste = true;
	//new_game_instance(GM_runtime_version);
	//clipboard_set_text(execute_shell_simple(@'Foreach ($line in get-content "$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build.bff") { echo $line }'));
	//var vixi = execute_shell_simple(new_bff_cmd);
	//var igor_exe = "%programdata%/GameMakerStudio2/Cache/runtimes/runtime-" 
	//	+ GM_runtime_version + "/bin/Igor.exe";
	//var options_path = game_save_id  + "/build.tff";
	//var args = "-j=8 -options=\"$env:LOCALAPPDATA\GameMakerStudio2\GMS2TEMP\build2.bff\" -v -- Windows Run";
	//execute_shell_simple(igor_exe, args);
}
