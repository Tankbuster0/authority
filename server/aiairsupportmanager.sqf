//by tankbuster
_myscript = "aiairsupportmanager";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_opforairsupportgroup","_startpos","_chosenveh","_opforairsupport","_opforairsupportveh","_dir"];

while {(alive pt_hq) and ((playersNumber west) > 0)} do
	{
	//sleep 120 + ((random 60) * 5);
	_opforairsupportgroup = createGroup east;
	_startpos = primarytarget getrelpos [(4000 + ((random 8) * 500)), random 360 ];
	_startpos set [2,800];
	_chosenveh = selectRandom opforairsupporttypes;
	_opforairsupport = [_startpos, (_startpos getdir primarytarget ), _chosenveh, _opforairsupportgroup] call BIS_fnc_spawnVehicle;
	_opforairsupportveh = _opforairsupport select 0;
	_t_ehindex = _opforairsupportveh addeventhandler ["HandleDamage", {if ((_this select 4) isKindOf "MissileCore") then { 1; } else { _this select 2; }; }];
	_opforairsupportveh setVelocity [200 * (sin direction _opforairsupportveh), 200 * (cos direction _opforairsupportveh), 0];
	_opforairsupportgroup setCombatMode "RED";
	_wp1 = _opforairsupportgroup addWaypoint [primarytarget, 300];
	_wp1 setWaypointBehaviour "COMBAT";
	_wp1 setWaypointSpeed "NORMAL";
	_wp1 setwaypointtype "SAD";
	_wp1 setWaypointFormation "COLUMN";

	_wp2 = _opforairsupportgroup addWaypoint [pt_radar , 0];
	_wp2 setwaypointtype "COMBAT";
	_wp2 setWaypointSpeed "NORMAL";
	_wp2 setwaypointtype "CYCLE";
	diag_log format [ "*** aasm spawn %1 at %2", _chosenveh, _startpos];
	if (true) exitWith {};
	};



diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];