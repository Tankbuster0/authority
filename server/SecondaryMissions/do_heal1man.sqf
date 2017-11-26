//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_heal1man";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private ["_nr","_h1mgrp","_roadpiece","_h1mcar","_h1cardriver","_h1manmain","_vel","_dir","_distanddir","_carcolour","_carscreenname"];
switch (floor random 1) do
	{
		case 0:
		{
			comment "RTA heal game";
			// find a road piece  outside town, away from forward and fob road traffic victim heal.

			_nr = (cpt_position nearRoads 700) select {(not (_x inArea (format["cpt_marker_%1", primarytargetcounter]))) and (isOnRoad _x)};
			diag_log format ["*** doh1m has nearroads %1", _nr];
			_h1mgrp = createGroup civilian;
			_roadpiece = selectRandom _nr;
			while {not ((_roadpiece nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 6]) isEqualTo [])} do
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
			if ((count (nearestTerrainObjects [_roadpiece, ["Wall", "Tree"], 10, false, true])) > 0) then
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
			_h1mcar setHitIndex [0,1];
			_h1mcar setHitIndex [2,1];

			sleep 1;
			_h1manmain action ["eject", _h1mcar];
			_h1manmain setUnitPos "down";
			_h1manmain disableAI "Move";
			diag_log format ["*** doh1m says car is %1 at %2", typeOf _h1mcar, getpos _h1mcar];
			_distanddir = [getpos _h1mcar] call tky_fnc_distanddirfromtown;
			_carcolour = tolower ([_h1mcar] call tky_fnc_getvehiclecolour);
			_carscreenname = ([_h1mcar] call tky_fnc_getscreenname);
			smmissionstring = format ["Reports are a %2 %3 has gone off the road %1. There may be fatalites and injuries. Our priority is to render first aid to those that require it and maybe transport them to hospital ", _distanddir, _carcolour, _carscreenname];
		};

	};




smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";
failtext = "Dudes. You suck texts";
while {missionactive} do
	{
	sleep 3;
	if (not alive _h1manmain) then
		{
		missionsuccess = false;
		missionactive = false;
		failtext = "You lost the patient. Mission Failed."; publicVariable "failtext";
		};

	if ((damage _h1manmain) < 0.25) then
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
