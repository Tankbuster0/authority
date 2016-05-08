//by tankbuster
_myscript = "assaultphasefinished.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_ruinstartcount","_ruinendcount","_heartandmindscore","_sm_required","_sm_hint","_smmhandle", "_handle2"];
if (cpt_type != 1) exitWith {nul = execVM "server\primarytargetcleared.sqf"};
_ruinstartcount = nextpt getVariable "targetruincount";
_ruinendcount = (count (cpt_position nearObjects ["Ruins", cpt_radius]));
heartandmindscore = (_ruinendcount - _ruinstartcount) + civkillcount + reinforcementcounter + captivekillcounter;// plus a point if captive opfor are killed
diag_log format ["****h&m = %1, ruinend %2 ruinstart %3 civkill %4 reinfcntr %5", heartandmindscore, _ruinendcount, _ruinstartcount,civkillcount, reinforcementcounter];

sleep 3;
format ["Congratulations! You've driven the enemy from the town. Now we need to win the hearts and minds of the locals\nWe must to complete secondary missions and tasks to achieve this."] remoteexec ["hint", -2];
sleep 10;
_handle2 = [] execVM "server\sm_manager.sqf";
waitUntil {sleep 1;scriptdone _handle2};

nul =  execVM "server\primarytargetcleared.sqf";

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];