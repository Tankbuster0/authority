_myscript = "playersetup.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
waituntil {alive player};
//waituntil {(((player distance fobveh) < 10) or ((player distance forward) < 10) or ((player distance ammobox) < 10)) };
waitUntil {((((getpos player select 0) > 100) and ((getpos player select 1) > 100)) or ((player distance forward) < 10) or ((player distance ammobox)< 10))};
sleep 0.5;
//^^^ wait until player really REALLY properly is in game

//fobveh = [missionNamespace, "fobveh", nil] call BIS_fnc_getServerVariable;// pv is apparently unreliable, so get it when player joins.RM09/07/16
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
