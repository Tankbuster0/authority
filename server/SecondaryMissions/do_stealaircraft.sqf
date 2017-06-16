//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_stealaircaft";
__tky_starts;
private ["_airport","_airportlogics","_smairfield","_hbuildings","_smtype","_smveh","_candposs","_smsaveh","_myhangar","_myhpos1","_defect","_mypos","_mechaagrp","_fueltrk", "_mypos"];
//steal aircraft
_airport = selectRandom foundairfields;
_airportlogics = entities "logic" select {((_x getVariable "targettype") isEqualTo 2) and {((_x getVariable "targetstatus") isEqualTo 1) and ((_x getVariable "targetstatus") != 2)}};//get all enemy held airfields that are not current target

_smairfield =  selectRandom _airportlogics;
diag_log format ["***dsa makes a mission at %1", (_smairfield getVariable "targetname")];
 format ["Secondary mission aircraft steal at %1", _smairfield getVariable "targetname"] remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
_hbuildings = ((nearestTerrainObjects [_smairfield, ["HOUSE"], 1000])) select {((typeof _x) find "anga") > -1};
diag_log format ["*** dsa finds %1 hangars ", count _hbuildings];
if (((count _hbuildings) < 1) or (random 1 > 0.5))then
	{_smtype = "heli";
	_smveh = selectRandom opfor_helis;
	}	else
	{_smtype = "plane";
	_smveh = selectRandom opfor_planes;
	};

diag_log format ["*** dsa is choosing a %1 %2", _smveh, _smtype];

//if  its a plane we know there are hangars, so choose one and put it in there, rotate it 180 from hanger dir
// if it's a heli, find a hiden cluteron, and spawn the heli there but rough strips have landmark_f.p3d
// use nearestTerrainObjects [player, ["hide"], 20] to find them, th use tky find safe pos to get a nice clear position a few metres away
// useing nearestobjects gives invisibleroadway_square_cluteron_f which is quite nice, seems to be  mostly oin the runway and taxiways
//cuterons work everywhere exept almyera on atlis, where we'll have to use landmark

if (_smtype isEqualTo "heli") then
	{// cluterons appear to be the cluttercutter objects underneath runways and taxiways, some dirt runways dont have them but do have landmarks
	_candposs = (nearestTerrainObjects [_smairfield, ["hide"], 1000, false, true]) select {(str _x) find "cluteron" > -1};
	diag_log format ["***dsa finds %1 cluterons", count _candposs];
	if (_candposs isEqualTo []) then
		{
		_candposs = (nearestTerrainObjects [_smairfield, ["hide"], 1000, false, true]) select {(typeof _x) isEqualTo "Land_LandMark_F"};
		diag_log format ["***dsa now looking for landmarks and finds %1", count _candposs];
		};


	if (_candposs isEqualTo []) then {diag_log format ["***2ndary aircraft steal mission failed to find anywhere to spawn helis. report this to developer"]};
	_mypos = selectRandom _candposs;
	_smsaveh = createVehicle [_smveh, _mypos, [], 5, "NONE"];
	};

if (_smtype isEqualTo "plane") then
	{

	_myhangar = selectRandom _hbuildings;
	_myhpos1 = getpos _myhangar;
	_candposs = [_myhpos1 select 0, _myhpos1 select 1, 0];
	_smsaveh = createVehicle [_smveh, _candposs, [], 0, "NONE"];
	_smsaveh setdir (180 + getdir _myhangar);
	};

_defect = floor random 5;
switch (_defect) do
	{
	case 0: {_smsaveh setHitPointDamage ["hitengine", 1]; _smsaveh setHitPointDamage ["hitengine2", 1]; };
	case 1: {_smsaveh setfuel 0};
	};

_mypos = [_smairfield , 50, 500, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
_mechaagrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;

_mypos = [_smsaveh , 15, 100, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
_mechaagrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSquad_Weapons")] call BIS_fnc_spawnGroup;

if ((playersNumber west) > 5) then
	{
	_mypos = [_smairfield , 50, 500, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_mechaagrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Armored" >> "O_T_TankPlatoon_AA")] call BIS_fnc_spawnGroup;
	};
if (_defect isEqualTo 1) then
	{
	_mypos = [_smairfield , 50, 500, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_fueltrk = createVehicle ["C_Van_01_fuel_F", _mypos, 0,[],"NONE"];
	};


__tky_ends


