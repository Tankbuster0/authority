scriptName "do_hostageRescue";

/*
	Code written by Haz
*/

#define __FILENAME "do_hostageRescue.sqf"

if ((!isServer)) exitWith {};

#include "..\includes.sqf"

__tky_starts;

missionactive = true;
publicVariable "missionactive";

missionsuccess = false;
publicVariable "missionsuccess";

private _potentialStarts = (cpt_position nearEntities ["Logic", 5000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) && {(_x distance2D cpt_position > 1500)} && ((_x getVariable "targetlandmassid") isEqualTo cpt_island)};
private _start = selectRandom _potentialStarts;
private _locationName = _start getVariable ["targetname", "Tanky fucked up"];

_spawnPos =  [_start, 0, 400, 15, 0, 0.5, 0 , 0, 1] call tky_fnc_findsafepos;

_loctext = [_spawnPos] call tky_fnc_distanddirfromtown;
smmissionstring = format ["A group of hostiles are holed up %1 with at least a couple of hostages. Eliminate all hostile threats and save at least 2 hostages by bringing them safely back to base.", _loctext];
publicVariable "smmissionstring";

smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];

_cleanup = [];

private _enemyGroup = [_spawnPos, opfor, (configFile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam")] call BIS_fnc_spawnGroup;
[_enemyGroup, (getPos (leader _enemyGroup))] call BIS_fnc_taskDefend;
_cleanup pushBack _enemyGroup;

private _hostageGroup = createGroup blufor;

private _hostageClassnames = [["B_officer_F", "B_helicrew_F", "B_crew_F"], ["C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F"]];
_hostageClassname = selectRandom _hostageClassnames;

private _floorRand = floor (random 2);

private _hostageAnimations = ["Acts_AidlPsitMstpSsurWnonDnon_loop", "Acts_ExecutionVictim_Loop"];
private _hostageAnimation = selectRandom _hostageAnimations;

private _numHostages = 3 + (ceil (random 3));

aliveHostages = _numHostages;
publicVariable "aliveHostages";

private _hostages = [];

for "_i" from 0 to (_numHostages - 1) do
{
	private _hostage = _hostageGroup createUnit [(_hostageClassname select _floorRand), _spawnPos, [], 0, "FORM"];
	removeAllWeapons _hostage;
	_hostage disableAI "ALL";
	_hostage setCaptive true;
	_hostage addEventHandler ["Killed", {aliveHostages = aliveHostages - 1; publicVariable "aliveHostages";}];
	_hostageAnimation = selectRandom _hostageAnimations;
	[_hostage, (format ["hostage%1", (_i + 1)])] call fnc_setVehicleName; // Found in functions.sqf (:
	_hostages pushBack _hostage;
	[_hostage, _hostages] spawn tky_fnc_followLeader;
	[_hostage, _hostageAnimation] remoteExec ["switchMove", 0, false];
};

private _hostagePos = getPosATL hostage1;

private _alarmSpeakers = createVehicle ["Land_Loudspeakers_F", _spawnPos, [], 0, "CAN_COLLIDE"];

private _lightSource = "#lightPoint" createVehicle _spawnPos;
_lightSource setPos (_lightSource modelToWorld [0, 0, (((getNumber (configFile >> "CfgVehicles" >> "Land_Loudspeakers_F" >> "mapSize")) * 2) + 1.43)]);
_lightSource setLightAmbient [255, 0, 0];
_lightSource setLightColor [255, 0, 0];
_lightSource setLightBrightness 0.025;
_lightSource lightAttachObject [_alarmSpeakers, [0, 0, 6]];

private _soundSource = createVehicle ["Land_HelipadEmpty_F", _spawnPos, [], 0, "CAN_COLLIDE"];

_alarmSpeakers addEventHandler ["Hit",
{
	_newDamage = (getDammage (_this select 0)) - (_this select 2) + 0.10;
	(_this select 0) setDamage _newDamage;
}];

private _enemySpotted = false;

[_alarmSpeakers, _soundSource, _lightSource, _enemyGroup, _enemySpotted] spawn
{
	params
	[
		["_alarmSpeakers", objNull],
		["_soundSource", objNull],
		["_lightSource", objNull],
		["_enemyGroup", objNull],
		["_enemySpotted", objNull]
	];
	if ((isNull _alarmSpeakers) || (isNull _soundSource) || (isNull _lightSource)) exitWith {};
	waitUntil {(((((leader _enemyGroup) targetsQuery [objNull, blufor, "", [], 0]) select 0) select 0) > 0.4)};
	while {(missionactive)} do
	{
		if ((!isNull _lightSource)) then
		{
			_lightSource setLightAmbient [255, 0, 0];
			_lightSource setLightColor [255, 0, 0];
			_lightSource setLightBrightness 0.025;
		};
		if ((!alive _alarmSpeakers) || (getDammage _alarmSpeakers >= 0.15)) then
		{
			deleteVehicle _soundSource;
			_lightSource setLightAmbient [0, 0, 0];
			_lightSource setLightColor [0, 0, 0];
			_lightSource setLightBrightness 0;
		} else
		{
			[_soundSource, ["Alarm_BLUFOR", 125, 1]] remoteExec ["say3D", ([0, -2] select isDedicated), false];
		};
		sleep 3.43;
		if ((!isNull _lightSource)) then
		{
			_lightSource setLightAmbient [0, 0, 0];
			_lightSource setLightColor [0, 0, 0];
			_lightSource setLightBrightness 0;
		};
		sleep 3.43;
	};
};

{
	[_x] joinSilent grpNull;
	_hostagePos set [0, ((_hostagePos select 0) + 2)];
	_x setPosATL _hostagePos;
} forEach _hostages;

[_hostages, _alarmSpeakers, _soundSource, _lightSource, _cleanup] spawn
{
	params
	[
		["_hostages", []],
		["_alarmSpeakers", objNull],
		["_soundSource", objNull],
		["_lightSource", objNull],
		["_cleanup", objNull]
	];
	if ((_hostages isEqualTo [])) exitWith {};
	private _rescuedHostages = 0;
	while {(missionactive)} do
	{
		sleep 4;
		if ((aliveHostages < 2)) exitWith
		{
			{
				_x setPos [0, 0, 0];
				_x setDamage 1;
				deleteVehicle _x;
			} forEach _hostages;
			{
				deleteVehicle _x;
			} forEach [_alarmSpeakers, _soundSource, _lightSource];
			missionactive = false;
			publicVariable "missionactive";
			missionsuccess = false;
			publicVariable "missionsuccess";
			failText = "Mission failed. One or more hostages were killed.";
			publicVariable "failText";
			failText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			[_cleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";
		};
		{
			if ((_x distance2D ammobox < 11) && {((vehicle _x) isEqualTo _x) && (alive _x) && (isTouchingGround _x)}) then
			{
				_rescuedHostages = _rescuedHostages + 1;
			};
		} forEach _hostages;
		if ((_rescuedHostages >= 2)) exitWith
		{
			missionactive = false;
			publicVariable "missionactive";
			missionsuccess = true;
			publicVariable "missionsuccess";
			completionText = "Mission completed. At least two hostages were rescued.";
			publicVariable "completionText";
			completionText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			[_cleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";
		};
	};
};

__tky_ends;