//"%programdata%\GameMakerStudio2\Cache\runtimes\runtime-2022.2.1.491\bin\Igor.exe"  -j=8 -options="%appdata%\Local\GameMakerStudio2\GMS2TEMP\build.bff" -v -- Windows Run
var igor_exe = "%programdata%\\GameMakerStudio2\\Cache\\runtimes\\runtime-2022.2.1.491\\bin\\Igor.exe";
var options = " -j=8 -options=";
var build = "%appdata%\\Local\\GameMakerStudio2\\GMS2TEMP\\build.bff";
var cmd = " -v -- Windows Run";
clipboard_set_text("-j=8 -options='%appdata%\Local\GameMakerStudio2\GMS2TEMP\build.bff' -v -- Windows Run " + working_directory);
//var paro = 0;

//if (debug_mode && keyboard_check(ord("N")))
//	execute_shell(igor_exe + options + build + cmd + working_directory + game_project_name + ".win", 0);