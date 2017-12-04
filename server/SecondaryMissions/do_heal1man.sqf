//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_heal1man";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private ["_h1mgrp","_nr","_roadpiece","_h1mcar","_smcleanup","_h1cardriver","_h1manmain","_vel","_dir","_distanddir","_carcolour","_carscreenname","_nb0","_h1bld","_nb1","_h1bldname","_h1blddistanddir","_mode","_h1bldposs0","_h1bldposs1","_hpos","_h1extra","_h1bldexits","_z","_h1bdlcandidateexit","_h1bldexit","_ret","_h1mdivepos","_maxradius","_subposs0","_subposs1","_subposfinal","_h1msub", "_thiselement"];
_h1mgrp = createGroup civilian;
_smcleanup = [];
_game = random floor 2;
_game = 2;// for debug and testing only
switch (_game) do
	{
		case 0:
		{
			comment "RTA heal game";
			// find a road piece  outside town, away from forward and fob road traffic victim heal.
			_nr = (cpt_position nearRoads 700) select {(not (_x inArea (format["cpt_marker_%1", primarytargetcounter]))) and (isOnRoad _x)};
			diag_log format ["*** doh1m has nearroads %1", _nr];

			_roadpiece = selectRandom _nr;
			while {not ((_roadpiece nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 6]) isEqualTo [])} do
				{// make sure there isn't already a vehicle on the road
					_roadpiece = selectRandom _nr;
				};
			diag_log format ["*** _roadpiece = %1 at %2", _roadpiece, getpos _roadpiece];
			_h1mcar = createVehicle [(selectRandom civcars), getpos _roadpiece, [],0, "NONE"];
			[_h1mcar, "h1mcar"] call fnc_setvehiclename;
			_smcleanup pushback _h1mcar;
			_h1cardriver = _h1mgrp createUnit [(selectRandom civs), (getpos _roadpiece),[],0,"NONE"];
			_h1cardriver moveInDriver _h1mcar;
			_smcleanup pushBack _h1cardriver;
			_h1cardriver setdamage 1;
			_h1manmain = _h1mgrp createUnit [(selectRandom civs), (getpos _roadpiece), [],0,"NONE"];
			_h1manmain moveInCargo _h1mcar;
			_h1mcar setdir (90 + (_roadpiece getdir ((roadsConnectedTo _roadpiece) select 0)));// turn it towards road edge
			if ((count (nearestTerrainObjects [_roadpiece, ["Wall", "Tree"], 10, false, true])) > 0) then
				{//there's a roadbarrier or tree nearby, crash the veh into it
					_vel = velocity _h1mcar;
					_dir = getdir _h1mcar;
					_h1mcar setVelocity [
						(_vel select 0) + (sin _dir * 10),
						(_vel select 1) + (cos _dir * 10),
						(_vel select 2)];
				}
				else
				{// no barrier/wall nearby, just move the vehicle off the road
					while {isOnRoad _h1mcar} do
						{
							_h1mcar setpos (_h1mcar modelToWorld [0,4,0]);// move it to the edge of the road
						};
				};
			[_h1mcar] call tky_fnc_initvehicle;
			_h1mcar setHitIndex [0,1];
			_h1mcar setHitIndex [2,1];
			_h1mcar setHitPointDamage ["HitlFWheel",1];
			_h1mcar setHitPointDamage ["HitRFWheel",1];
			_h1manmain action ["eject", _h1mcar];
			diag_log format ["*** doh1m says car is %1 at %2", typeOf _h1mcar, getpos _h1mcar];
			_distanddir = [getpos _h1mcar] call tky_fnc_distanddirfromtown;
			_carcolour = tolower ([_h1mcar] call tky_fnc_getvehiclecolour);
			_carscreenname = ([_h1mcar] call tky_fnc_getscreenname);
			smmissionstring = format ["Reports are a %2 %3 has gone off the road %1. There may be fatalites and injuries. Our priority is to render first aid to those that require it and maybe transport them to hospital ", _distanddir, _carcolour, _carscreenname];
		};
		case 1:
			{// inside a house or falls from roof
				_nb0 = (nearestTerrainObjects [cpt_position, ["house"], 700]) select {(count (_x buildingPos -1)) > 8};
				//perhaps add a min distance to forward and fobveh because as the mission can spawn inside the cpt
				_h1bld = selectRandom _nb0;
				_mode = selectRandom ["inside", "outside"];
				if (_mode isEqualTo "inside") then
					{
						_h1bldposs1 = [];
						while {_h1bldposs1 isEqualTo []} do
							{
								_h1bld = selectRandom _nb0;
								_h1bldposs0 = (_h1bld buildingPos -1);
								diag_log format ["*** _h1bldposs0 is %1", _h1bldposs0];
								_h1bldposs1 = _h1bldposs0 select {( not ([_x] call tky_fnc_inhouse))};// remove roof positions
								diag_log format ["*** _h1bldposs1 is %1", _h1bldposs1];
							};
						_hpos = selectRandom _h1bldposs1;
						_h1manmain = _h1mgrp createUnit [(selectRandom civs), _hpos, [],0,"NONE"];
						_h1bldposs1 = _h1bldposs1 - [_hpos];
						_hpos = selectRandom _h1bldposs1;
						_h1extra = _h1mgrp createUnit [(selectRandom civs), _hpos, [],0,"NONE"];
						_h1extra setdamage 1;
						_smcleanup pushBack _h1extra;
						_h1bldname = [_h1bld] call tky_fnc_getscreenname;
						_h1blddistanddir = [getpos _h1bld] call tky_fnc_distanddirfromtown;
						smmissionstring = format ["Local emergency services have taken a call from the %1 %2 where there are injured civilians inside the building. Send a medic to tend to them", _h1bldname, _h1blddistanddir];
					}
					else
					{
						_h1bld = selectRandom _nb0;
						_h1bldexits = [];
						for "_z" from 0 to 20 do
							{
								_h1bdlcandidateexit = (_h1bld buildingExit _z);
								diag_log format ["*** _h1bdlcandidateexit is %1", _h1bdlcandidateexit];
								if ((_h1bdlcandidateexit select 1) > 0) then
									{_h1bldexits pushBack _h1bdlcandidateexit};
							};
						_h1bldexit = selectRandom _h1bldexits;
						_h1manmain = _h1mgrp createUnit [(selectRandom civs), _h1bldexit, [],0, "NONE"];
						_h1bldname = [_h1bld] call tky_fnc_getscreenname;
						_h1blddistanddir = [getpos _h1bld] call tky_fnc_distanddirfromtown;
						smmissionstring = format ["A civilian appears to have fallen from the roof of the %1 %2. Send a medic to tend to them", _h1bldname, _h1blddistanddir];
					};
				diag_log format ["*** dh1m inhouse game is at %1", getpos _h1manmain];
			};
		case 2:
			{// diver accident

				_h1mdivepos = islandcentre;
				_maxradius = 128;
				while {_h1mdivepos isEqualTo islandcentre} do
					{
						_maxradius = _maxradius * 2;
						_h1mdivepos = [cpt_position, 200, _maxradius, 3, 2, 0, 1] call bis_fnc_findsafepos;
					};
				diag_log format ["*** dh1m_dive chooses %1 as mission pos", _h1mdivepos];
				_subposs0 = selectBestPlaces [_h1mdivepos, 50, "waterdepth",10,50];
				diag_log format ["*** _subposs0 is %1", _subposs0];
				_subposs1 = [];
				{
					_thiselement = _x;
					if (((_thiselement select 1) > 0.5) and {((_thiselement select 1) < 2) and (surfaceIsWater (_thiselement select 0))}) then
						{
							_subposs1 pushback (_thiselement select 0);
						};
				} forEach _subposs0;
				diag_log format ["*** _subposs1 is %1", _subposs1];
				if (_subposs1 isEqualTo [] ) then
					{//safety check, if failed to find good slightly offshore pos, fall back to a less filtered position
						_subposfinal = _h1mdivepos;
					}
					else
					{
						_subposfinal = selectRandom _subposs1;
					};
				diag_log format ["*** dh1m dive chooses %1 as sub pos", _subposfinal];
				_h1msub = createVehicle ["I_SDV_01_F", _subposfinal, [],0,"NONE"];
				_h1msub setfuel 0;
				_h1manpos = islandcentre;
				_maxradius = 2;
				while {_h1manpos isEqualTo islandcentre} do
					{
						_maxradius = _maxradius * 2;
						_h1manpos = [_h1msub, 2, _maxradius, 1, 0,0, 1] call bis_fnc_findsafepos;
					};
				_h1manmain = _h1mgrp createUnit [(selectRandom civs), _h1manpos, [],0,"NONE"];
				_h1manmain forceAddUniform "U_O_Wetsuit";
				smmissionstring = format ["We're getting distress calls from a friendly diver operative. An SDV has been seen on the shore %1. Go and see if the diver needs medical help.", [_h1msub] call tky_fnc_distanddirfromtown];
				_smcleanup pushback _h1msub;
				diag_log format ["*** sun is at %1 and diver is at %2", getpos _h1msub, getpos _h1manmain];
			};
		case 3:
			{// aircraft accident
				_h1pcpos0 = selectBestPlaces [cpt_position, 750, "meadow", 50, 25];
				_h1pcpos1 = _h1pcpos0 select {(not ((_x select 0) inArea (format["cpt_marker_%1", primarytargetcounter])))};
				// ^^^ select only those positions not in the cpt
				if ((count _h1pcpos1) > 3) then
					{
						_rnd = floor random 3;
						_h1pcpos = _h1pcpos select _rnd;
					}
					else
					{
						_h1pcpos = _h1pcpos1 select 0;
					};
				// check that most meadowy places are at the start of the array

				_h1pcheli = createVehicle ["C_Heli_Light_01_civil_F", _h1pcpos, [],0,"NONE"];
				_h1pcheli setdamage 0.8;
				_h1pcheli setfuel 0;
				[_h1pcheli] call tky_fnc_initvehicle;
				_smcleanup pushback _h1pcheli;
				_h1manmain = _h1mgrp createunit ["C_Story_Mechanic_01_F", _h1pcpos, [],0, "NONE"];
				_h1manmain moveInDriver _h1pcheli;
				_h1manmain action ["eject", _h1pcheli];
				smmissionstring = format ["Air traffic control recieved a mayday call from a civilian aircraft %1. As we've had no further comms from them, you should get a medic team out there to see if they need any assistance", [_h1pcpos] call tky_fnc_distanddirfromtown];
			};
	};
_h1manmain sethit ["legs",1];
_h1manmain setUnitPos "down";
_h1manmain disableAI "Move";
_h1manmain setdamage 0.5;
_smcleanup pushBack _h1manmain;

////////////////////////// dont forget to add all these to smcleanup

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

	if ((damage _h1manmain) < 0.1) then
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
