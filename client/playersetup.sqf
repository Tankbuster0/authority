 #include "..\includes.sqf"
_myscript = "playersetup.sqf";
__tky_starts;
//waituntil {alive player};
waitUntil {!isNull player};
//waitUntil {((((getpos player select 0) > 100) and ((getpos player select 1) > 100)) or ((player distanceSqr forward) < 3.1) or ((player distanceSqr ammobox)< 3.16))};
sleep 0.5;
//^^^ wait until player really REALLY properly is in game
[] execVM "client\tky_supportmanager.sqf";
// ^^^ check to see if this survives respawn/revive?
[]execVM "client\makediary.sqf";
__tky_ends
