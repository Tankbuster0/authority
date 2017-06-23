//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_stealaircaft";
__tky_starts;
private ["_airportlogics","_smairfield","_hbuildings","_smtype","_smveh","_candposs","_smsaveh","_myhangar","_myhpos1","_defect","_mypos","_mechaagrp","_fueltrk", "_mypos", "_veh", "_playerinveh", "_smcleanup"];
_playerinveh = false; missionactive = true; missionsuccess = false; _smcleanup = [];
_airportlogics = entities "logic" select {((_x getVariable "targettype") isEqualTo 2) and {((_x getVariable "targetstatus") isEqualTo 1) and ((_x getVariable "targetstatus") != 2)}};//get all enemy held airfields that are not current target
_smairfield =  selectRandom _airportlogics;
diag_log format ["***dsa makes a mission at %1", (_smairfield getVariable "targetname")];
 format ["Satellite intel reports  there's an enemy aircraft at %1 that our R&D guys would quite like to see. Steal it and bring it back to our airbase.", _smairfield getVariable "targetname"] remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
_hbuildings = ((nearestTerrainObjects [_smairfield, ["HOUSE"], 1000])) select {((typeof _x) find "anga") > -1};
if (((count _hbuildings) < 1) or (random 1 > 0.8))then
	{_smtype = "heli";
	_smveh = selectRandom opfor_helis;
	}	else
	{_smtype = "plane";
	_smveh = selectRandom opfor_planes;
	};
//if  its a plane we know there are hangars, so choose one and put it in there, rotate it 180 from hanger dir
// if it's a heli, find a taxiway marking, and spawn the heli there but rough strips have landmark_f.p3d
// use nearestTerrainObjects [player, ["hide"], 20] to find them, th use tky find safe pos to get a nice clear position a few metres away
if (_smtype isEqualTo "heli") then
	{
	_candposs = (nearestObjects [_smairfield, [], 400, true]) select { ( ((str _x) find "centerline_90deg" > -1) or  ((str _x) find "line_curve" > -1) ) };// for tanoa or altis
	diag_log format ["***dsa finds %1 runway line curves", count _candposs];
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
	_myhpos1 set [2,100];
	_smsaveh = createVehicle [_smveh, _myhpos1, [], 0, "NONE"];
	sleep 0.1;
	_smsaveh allowdamage false;
	sleep 0.1;
	_smsaveh setdir (180 + getdir _myhangar);
	sleep 0.1;
	_smsaveh setpos getpos _myhangar;
	};
_smcleanup pushback _smsaveh;
diag_log format ["*** dsa makes a %1 at %2 which is %3 from %4", _smveh, getpos _smsaveh, _smsaveh distance2D _smairfield,(_smairfield getVariable "targetname") ];
_defect = floor random 5;
switch (_defect) do
	{
	case 0: {_smsaveh setHitPointDamage ["hitengine", 1]; _smsaveh setHitPointDamage ["hitengine2", 1]; };
	case 1: {_smsaveh setfuel 0.04};
	};
sleep 1;
for "_ii" from 0 to ((ceil (playersNumber west ) /2) min 5) do
	{
	_mypos = [_smsaveh, 30, 200, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_dsa_opfor1 = createvehicle [(selectRandom opforpatrollandvehicles), _mypos, [],0,"NONE"];
	createVehicleCrew _dsa_opfor1;
	NUL = [group (effectiveCommander _dsa_opfor1), getpos _smsaveh, 200 ] call BIS_fnc_taskpatrol;
	sleep 0.5;
	_smcleanup pushback _dsa_opfor1;
	};
_mypos = [_smsaveh , 50, 200, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
;
_dsa_opfor2 = createVehicle [(selectRandom opforstaticlandvehicles), _mypos, [],0, "NONE"];
createVehicleCrew _dsa_opfor2;
[_dsa_opfor2, getpos _smsaveh] call BIS_fnc_taskDefend;
_smcleanup pushback _dsa_opfor2;
for "_ii" from 0 to ((ceil (playersNumber west ) /4) min 5) do
	{
	_mypos = [_smsaveh , 15, 100, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_dsa_opfor3 = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
	[_dsa_opfor3, getpos _smsaveh] call BIS_fnc_taskDefend;
	_smcleanup pushback _dsa_opfor3;
	sleep 0.5
	};
if ((playersNumber west) > 5) then
	{
	_mypos = [_smsaveh , 50, 200, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_dsa_opfor4 = createVehicle [(selectRandom opforstaticlandvehicles), _mypos, [],0, "NONE"];
	createVehicleCrew _dsa_opfor4;
	[_dsa_opfor4, getpos _smsaveh] call BIS_fnc_taskDefend;
	_smcleanup pushback _dsa_opfor4;
	_mypos = [_smsaveh , 50, 200, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_dsa_opfor5 = createVehicle [(_veh = selectRandom opfortanks), _mypos, [],0, "NONE"];
	createVehicleCrew _dsa_opfor5;
	[_dsa_opfor5, getpos _smsaveh] call BIS_fnc_taskDefend;
	sleep 0.5;
	};
if (_defect isEqualTo 1) then
	{
	_mypos = [_smsaveh , 20, 100, 8,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_fueltrk = createVehicle ["C_Van_01_fuel_F", _mypos, [],0,"NONE"];
	_smcleanup pushback _fueltrk;
	};
while {missionactive} do
	{
	sleep 3;
	if (not(alive _smsaveh) or (fuel _smsaveh isEqualTo 0)) then
		{
		missionsuccess = false;
		missionactive = false;
		};
	if ((not(_playerinveh)) and {isplayer (effectiveCommander _smsaveh)}) then {_playerinveh = true};
	if (_playerinveh and {(speed _smsaveh < 1) and (_smsaveh distance2D blubasehelipad) < 20}) then
		{
		missionsuccess = true;
		missionactive = false;
		};
	};
__tky_ends
