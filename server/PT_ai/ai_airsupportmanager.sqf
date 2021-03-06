//by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_airsupportmanager";
__tky_starts;
private ["_opforairsupportgroup","_startpos","_chosenveh","_opforairsupport","_opforairsupportveh","_dir"];
testflag = true;
wpdata = 0;
while {(alive pt_hq) and ((playersNumber west) > 0) and testflag } do
	{
	sleep 600 + ((floor random 30) * 60); // 10 to 40 mins
	//sleep 300;
	_opforairsupportgroup = createGroup [east, true];

	_startpos = primarytarget getrelpos [(4000 + ((random 8) * 500)), random 360 ];
	_startpos set [2,800];
	_chosenveh = selectRandom opforairsupporttypes;
	_opforairsupport = [_startpos, (_startpos getdir primarytarget ), _chosenveh, _opforairsupportgroup] call BIS_fnc_spawnVehicle;
	[_opforairsupportgroup, [1,1,1,0.40,1,1,0.40,0.50,1,0.50], false,0] call tky_fnc_tc_setskill;
	{_opforairsupportgroup reveal [_x,(random 4)];} foreach (allPlayers - entities "HeadlessClient_F");
	_opforairsupportveh = _opforairsupport select 0;
	_t_ehindex = _opforairsupportveh addeventhandler ["HandleDamage", {if ((_this select 4) isKindOf "MissileCore") then { 1; } else { _this select 2; }; }];
	_opforairsupportveh setfuel 0.5;
	_opforairsupportveh setVelocity [200 * (sin direction _opforairsupportveh), 200 * (cos direction _opforairsupportveh), 0];
	_opforairsupportgroup setCombatMode "RED";
	_wp1 = _opforairsupportgroup addWaypoint [primarytarget, 400];
	_wp1 setWaypointBehaviour "COMBAT";
	_wp1 setWaypointSpeed "NORMAL";
	_wp1 setwaypointtype "SAD";
	_wp1 setWaypointFormation "COLUMN";
	if (_opforairsupportveh isKindOf "Plane") then {_opforairsupportveh flyInHeight 200} else {_opforairsupportveh flyInHeight 100};
	_wp2 = _opforairsupportgroup addWaypoint [forward, 400];
	_wp2 setWaypointBehaviour "COMBAT";
	_wp2 setWaypointSpeed "NORMAL";
	_wp2 setwaypointtype "SAD";
	_wp2 setWaypointFormation "COLUMN";

	_wp3 = _opforairsupportgroup addWaypoint [pt_radar , 400];
	_wp3 setwaypointtype "SAD";
	_wp3 setWaypointSpeed "NORMAL";
	_wp3 setwaypointtype "CYCLE";
	//diag_log format [ "*** aasm spawn %1, %3 at %2", _chosenveh, _startpos, _opforairsupportveh];
	//if (true) exitWith {};

	_h = [_opforairsupportveh, _opforairsupportgroup] spawn
		{
		params ["_oveh", "_ogrp"];
		while {alive _oveh} do
			{
			sleep 3;
			if ( ((fuel _oveh) < 0.2) or (not (someAmmo _oveh)) or (not (alive pt_hq)) ) then
				{
				 while {(count (waypoints _ogrp)) > 0} do
					 {
					  deleteWaypoint ((waypoints _ogrp) select 0);
					 };
				(driver _oveh) domove [0,0,0];
				_wpx = _ogrp addWaypoint [[0,0,200], 500];
				_wpx setWaypointBehaviour "CARELESS";
				_wpx setWaypointSpeed "NORMAL";
				_wpx setwaypointtype "HOLD";
				_wpx setWaypointFormation "COLUMN";
				_wpx setWaypointStatements [ "true", "_oveh setdamage 1"];
				sleep 60;
				{_oveh deleteVehicleCrew _x} forEach crew _oveh;
				_oveh setdamage 1;
				deleteVehicle _oveh;

				};

			};

		};
	};



__tky_ends