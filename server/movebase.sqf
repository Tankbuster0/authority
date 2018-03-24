//by tankbuster
//execvmd by assaultphasefinished
 #include "..\includes.sqf"
_myscript = "movebase";
__tky_starts;
handle_mb_finished = false;
private ["_blubasedroppos","_composition","_airstripdata","_secairstrip","_airstripilsindata","_ils1indata","_ilsindata","_airbaseilsindata","_closestdistance","_closestone","_mydistance","_handle","_naughtybaseobjects","_naughtybaseobject","_dir1","_candidatepos","_testradius","_sizeof","_candidatepos2","_mypos", "_blubasedir", "_nro"];
// when the first airbase is taken this scipt makes an airdrop of a container that lands on the spot where the blufor base is moving too
// the container unpacks into the blufor base. the base ammobox is moved (the respawn moves automatically)
_scriptime = time;

_blubasedroppos = getpos blubasepos;
_blubasedir = getdir blubasepos;
airheadname = cpt_name;
// try to find the nearest ilsTaxiIn to the current airfield, its going to be the drop pos for containerised air prizes
//first get all the secondary airstrips
_airstripdata = [];

// clean up opfor statics... they are too messy

_ostatics = (vehicles select {(_x isKindOf "StaticWeapon") and {((typeOf _x ) find "O_") > -1} }) inAreaArray "cpt_marker_1";
{deleteVehicle _x } foreach _ostatics;// find and delete all the statics on the airfield
for  "_i" from 1 to 10 do // get airstrip data
	{
	_secairstrip =  format ["Airstrip_%1", _i];

	_airstripilsindata = getarray (configfile >> "CfgWorlds" >> worldName >> "SecondaryAirports" >> _secairstrip >> "ilsTaxiIn");
	if ((count _airstripilsindata) > 0) then // we're looking at an existing airstrip
		{
		_ils1indata = _airstripilsindata select [0,2]; //take the first 2 numbers, it's the ilsIn1 entry. returns a 2d array
		_airstripdata pushback _ils1indata;// pushback it into a master array, so, this is a nested array of 2d positions
		};
	};
// now add the ilsin1 of the islands main airfield...
_airbaseilsindata = getarray (configFile >> "CfgWorlds" >> worldName >> "ilsTaxiIn");
_ils1indata = _airbaseilsindata select [0,2];
_airstripdata pushback _ils1indata;
// find the nearest one
_closestdistance = 99999999;
_closestone = [];
	{
		_mydistance = (_x distance _blubasedroppos);
		if (_mydistance <= _closestdistance) then
		{
			_closestdistance = _mydistance;
			_closestone = _x;
		};
	} foreach _airstripdata;

airhead_container_landing_point = _closestone;
headmarker1 setMarkerPos _blubasedroppos;
headmarker2 setMarkerPos _blubasedroppos;
headmarker2 setMarkerText "AIRHEAD";
_handle = [_blubasedroppos, blufordropaircraft, "Land_Cargo40_military_green_F", [0,0,200], "This will assemble itself into your Airhead."] execVM "server\spawnairdrop.sqf";
sleep 5;
waitUntil {sleep 1; not isnil "mycontainer"};
waitUntil {sleep 1;(((getposATL mycontainer select 2) < 20) or (time > _scriptime + 120))};
_naughtybaseobjects = nearestobjects [_blubasedroppos, [], 40, false];
if (count _naughtybaseobjects > 0) then
	{
		{
		if (_x in [fobveh, forward]) then //things that mustnt be deleted
			{
			diag_log format ["*** leaving _naughtybaseobject %1, %2", _x, typeof _x];
			//find safeplace and move the object
			//get which direction the vehicle is from the centre
			_dir1 = _blubasedroppos getdir _x;
			//get a candidate position 45m in that direction , 45m from the centre of blubasedroppos
			_candidatepos =  _blubasedroppos getpos [40, _dir1];
			//now find a good empty spot nearby
			_testradius = 1;
			_sizeof = sizeOf (typeOf _x);
			_candidatepos2 = [0,0,0];
			while {_candidatepos2 in [[0,0,0], islandcentre]} do
				{
				_candidatepos2 = [_candidatepos, 0, _testradius,_sizeof, 0,0,0] call BIS_fnc_findSafePos;
				_testradius = _testradius + _sizeof;
				};

			forward setVehiclePosition [_candidatepos, [],0,"NONE"];
			}
			else
			{
		    deletevehicle _x;
			};
		} foreach _naughtybaseobjects;
	};
sleep 2;
waitUntil {(getposATL mycontainer select 2) < 1};
deletevehicle mycontainer;
//blubaseobjects = [getpos previousmission, 0, _composition] call tky_fnc_t_objectsmapper;
blubaseobjects = [_blubasedroppos, _blubasedir, blubasecomposition] call tky_fnc_t_objectsmapper;
{
	_x setdamage 0;
} foreach blubaseobjects;
_mypos = getpos ammoboxcone;
//deleteVehicle ammoboxcone;
ammoboxpad setpos _mypos;
baseflag setFlagTexture "pics\hom_flag_white_stripe512.paa";
blubasewhiteboard setObjectTextureGlobal [0, "\a3\missions_f_epa\data\img\whiteboards\whiteboard_a_in_camp_co.paa"];
blueflags pushback baseflag;
blueflags = blueflags - [beachflag];// removes beachhead flag from array so that now we have airhead, spawnairdrop cannot chose the old beachhead
_mypos = getpos terminalcone;
//deleteVehicle terminalcone;
blubasedataterminal setpos _mypos;

if (isDedicated) then
{
	bbdtopen = false;
	[] spawn
		{
		sleep 1;
		if (not bbdtopen and {count (blubasedataterminal nearEntities ["SoldierWB", 2]) > 0}) then
			{
			bbdtopen = true;
			[blubasedataterminal, 3] call BIS_fnc_DataTerminalAnimate;
			sleep 2;
			blubasedataterminal setObjectTextureGlobal [1, "pics\authlogo512x256.paa"];
			blubasedataterminal setObjectTextureGlobal [0, "pics\hom_flag_white_stripe512.paa"];
			};
		if (bbdtopen and {count (blubasedataterminal nearEntities ["SoldierWB", 2]) < 1}) then
			{
			blubasedataterminal setObjectTextureGlobal [1, "#(argb,8,8,3)color(0,1,1,1.0,co)"];
			blubasedataterminal setObjectTextureGlobal [0, "#(argb,8,8,3)color(0,1,1,1.0,co)"];
			bbdtopen = false;
			[blubasedataterminal, 0] call BIS_fnc_DataTerminalAnimate;
			sleep 2;
			blubasedataterminal setObjectTextureGlobal [1, "Camo_1"];
			blubasedataterminal setObjectTextureGlobal [0, "Camo_3"];
			};
		};
};


sleep 1;

[] spawn
	{// brute force for airhead GVS broken trigger
	while {true} do
		{
			sleep 1;
			_nro = (blubasehelipad nearEntities [["Land", "Air"], 6]);
			if (((count _nro) > 0 ) and {(!airheadserviceinuse) and (((typeof (_nro select 0)) in allbluvehicles) or ((_nro select 0) in preservedvehicles)) and (isPlayer driver (_nro select 0))}) then
				{
				airheadserviceinuse = true;
				publicVariable "airheadserviceinuse";
				[['airheadserviceinuse', _nro, getpos blubasehelipad], 'gvs\generic_vehicle_service.sqf'] remoteExec ['execVM', (driver (_nro select 0))];

				};
		};
	};

handle_mb_finished = true;

__tky_ends