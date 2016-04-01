//assaultphasefinished.sqf
//by tankbuster
_myscript = "assaultphasefinished.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
if not (cpt_type isEqualTo 1) exitWith {nul = execVM "server\primarytargetcleared.sqf"};
_ruinstartcount = nextpt getVariable "targetruincount";
_ruinendcount = (count (cpt_position nearObjects ["Ruins", cpt_radius]));
_heartandmindscore = (_ruinendcount - _ruinstartcount) + civkillcount + reinforcementcounter;
diag_log format ["****h&m = %1, ruinend %2 ruinstart %3 civkill %4 reinfcntr %5", _heartandmindscore, _ruinendcount, _ruinstartcount,civkillcount, reinforcementcounter];
sleep 3;
nul =  execVM "server\primarytargetcleared.sqf"

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];