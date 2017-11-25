//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_heal1man";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private ["_nr","_h1mgrp","_roadpiece","_h1mcar","_h1cardriver","_h1carcargo1","_h1manmain","_vel","_dir","_distanddir","_smcleanup"];
switch (floor random 1) do
	{
		case 0:
		{
			comment "RTA heal game";
			// find a road piece less than 100m outside town, away from forward and fob road traffic victim heal.

			_nr = (cpt_position nearRoads 700) select {(not (_x inArea (format["cpt_marker_%1", primarytargetcounter]))) and (isOnRoad _x)};
			diag_log format ["*** doh1m has nearroads %1", _nr];
			_h1mgrp = createGroup civilian;
			_roadpiece = selectRandom _nr;
			while {((_roadpiece nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 6]) isEqualTo [])} do
				{// make sure there isn't already a vehicle on the road
					_roadpiece = selectRandom _nr;
				};
			diag_log format ["*** _roadpiece = %1 at %2", _roadpiece, getpos _roadpiece];
			_h1mcar = createVehicle [(selectRandom civcars), getpos _roadpiece, [],0, "NONE"];
			[_h1mcar, "h1mcar"] call fnc_setvehiclename;
			_h1cardriver = _h1mgrp createUnit [(selectRandom civs), (getpos _roadpiece),[],0,"NONE"];
			_h1cardriver moveInDriver _h1mcar;
			_h1cardriver setdamage 1;

			_h1manmain = _h1mgrp createUnit [(selectRandom civs), (getpos _roadpiece), [],0,"NONE"];
			_h1manmain moveInCargo _h1mcar;
			_h1manmain sethit ["legs",1];
			_h1mcar setdir (90 + (_roadpiece getdir ((roadsConnectedTo _roadpiece) select 0)));// turn it towards road edge
			if ((count (nearestTerrainObjects [_roadpiece, ["Wall"], 10, false, false])) > 0) then
				{//there's a roadbarrier or wall nearby, crash the veh into it
					_vel = velocity _h1mcar;
					_dir = getdir _h1mcar;
					_h1mcar setVelocity [
						(_vel select 0) + (sin _dir * 6),
						(_vel select 1) + (cos _dir * 6),
						(_vel select 2)];
				}
				else
				{// no barrier/wall nearby, just move the vehicle off the road
					_h1mcar setpos (_h1mcar modelToWorld [0,3,0]);// move it to the edge of the road
				};
			[_h1mcar] call tky_fnc_initvehicle;
			_h1mcar setHitIndex [1,1];
			_h1mcar setHitIndex [3,1];

			sleep 1;
			_h1manmain action ["eject", _h1mcar];
			_h1manmain setUnitPos "down";
			diag_log format ["*** doh1m says car is %1 at %2", typeOf _h1mcar, getpos _h1mcar];
		};

	};



_distanddir = [getpos _h1mcar] call tky_fnc_distanddirfromtown;
smmissionstring = format ["There's been a car crash %1. There are fatalites and injuries. Our priority is to render first aid to those that require it and maybe transport them to hospital ", _distanddir];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";
failtext = "Dudes. You suck texts";
while {missionactive} do
	{
	sleep 3;
	if (false) then
		{
		missionsuccess = false;
		missionactive = false;
		failtext = "You suck. Mission failed because of reasons"; publicVariable "failtext";
		};

	if (false) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
