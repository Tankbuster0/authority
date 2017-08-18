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

private _potentialStarts = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) && {(_x distance2D cpt_position > 2500)} && ((_x getVariable "targetlandmassid") isEqualTo cpt_island)};
private _start = selectRandom _potentialStarts;
private _locationName = _start getVariable ["targetname", "Tanky fucked up"];

smmissionstring = format ["A group of hostiles are held up at %1 with at least a couple of hostages. Eliminate all hostile threats and save at least 2 hostages by bringing them safely back to base.", _locationName];
publicVariable "smmissionstring";

smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];

private _center = createCenter blufor;
private _group = createGroup blufor;

private _hostageClassnames = [["B_officer_F", "B_helicrew_F", "B_crew_F"], ["C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F"]];
_hostageClassname = selectRandom _hostageClassnames;

private _floorRand = floor (random 2);

private _hostageAnimations = ["Acts_AidlPsitMstpSsurWnonDnon_loop", "Acts_ExecutionVictim_Loop"];
private _hostageAnimation = selectRandom _hostageAnimations;

private _numHostages = 4 + (ceil (random 4));

aliveHostages = _numHostages;
publicVariable "aliveHostages";

private _hostages = [];

for "_i" from 0 to (_numHostages - 1) do
{
	private _hostage = _group createUnit [(_hostageClassname select _floorRand), _start, [], 0, "FORM"];
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

private _alarmSpeakers = createVehicle ["Land_Loudspeakers_F", (position _start), [], 0, "CAN_COLLIDE"];

private _lightSource = "#lightPoint" createVehicle (position _start);
_lightSource setLightAmbient [255, 0, 0];
_lightSource setLightColor [255, 0, 0];
_lightSource setLightBrightness 0.025;
_lightSource lightAttachObject [_alarmSpeakers, [0, 0, 6]];

private _soundSource = createVehicle ["Land_HelipadEmpty_F", (position _start), [], 0, "CAN_COLLIDE"];

_alarmSpeakers addEventHandler ["Hit",
{
	_newDamage = (getDammage (_this select 0)) - (_this select 2) + 0.10;
	(_this select 0) setDamage _newDamage;
}];

[_alarmSpeakers, _soundSource, _lightSource] spawn
{
	params
	[
		["_alarmSpeakers", objNull],
		["_soundSource", objNull],
		["_lightSource", objNull]
	];
	if ((isNull _alarmSpeakers) || (isNull _soundSource) || (isNull _lightSource)) exitWith {};
	waitUntil {(2 > 1)}; // TODO: Add condition (...when BLUFOR get spotted by OPFOR...)
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

[_hostages, _alarmSpeakers, _soundSource, _lightSource] spawn
{
	params
	[
		["_hostages", []],
		["_alarmSpeakers", objNull],
		["_soundSource", objNull],
		["_lightSource", objNull]
	];
	if ((_hostages isEqualTo [])) exitWith {};
	private _rescuedHostages = 0;
	while {(missionactive)} do
	{
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
			failText = "Mission failed. One or more hostages were killed.";
			publicVariable "failText";
			failText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
		{
			if ((_x distance2D (getMarkerPos "respawn_west") <= 10)) then
			{
				_rescuedHostages = _rescuedHostages + 1;
			};
		} forEach _hostages;
		if ((_rescuedHostages >= 2)) then
		{
			completionText = "Mission completed. At least two hostages were rescued.";
			publicVariable "completionText";
			completionText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
};

__tky_ends;