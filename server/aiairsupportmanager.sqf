//by tankbuster
_myscript = "aiairsupportmanager";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

while {(alive pt_hq) and ((playersNumber west) > 0)} do
	{
	sleep 120 + ((random 60) * 5);
	_opforairsupportgroup = createGroup east;
	_startpos = primarytarget getrelpos [(4000 + ((random 8) * 500)), random 360 ];
	_startpos set [2,800];
	_opforairsupport = [_startpos, (_startpos getdir primarytarget ), selectRandom opforairsupportypes, _opforairsupportgroup] call BIS_fnc_spawnVehicle;
	_opforairsupportveh = _opforairsupport select 0;
	_opforairsupportveh setVelocity [200 * (sin _dir), 200 * (cos _dir), 0];
	_opforairsupportgroup setCombatMode "RED";
	};



diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];