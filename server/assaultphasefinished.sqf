//assaultphasefinished.sqf
//by tankbuster
_myscript = "assaultphasefinished.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_ruinstartcount","_ruinendcount","_heartandmindscore"];
if (cpt_type != 1) exitWith {nul = execVM "server\primarytargetcleared.sqf"};
_ruinstartcount = nextpt getVariable "targetruincount";
_ruinendcount = (count (cpt_position nearObjects ["Ruins", cpt_radius]));
_heartandmindscore = (_ruinendcount - _ruinstartcount) + civkillcount + reinforcementcounter;
diag_log format ["****h&m = %1, ruinend %2 ruinstart %3 civkill %4 reinfcntr %5", _heartandmindscore, _ruinendcount, _ruinstartcount,civkillcount, reinforcementcounter];
sleep 3;
format ["Congratulations! You've driven the enemy from the town. Now we need to win the hearts and minds of the locals\nWe must to complete secondary missions and tasks to achieve this. Score = %1", _heartandmindscore] remoteexec ["hint", -2];

sleep 5;



nul =  execVM "server\primarytargetcleared.sqf";

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];