scriptName "do_hostageRescue";
/*	Code written by Haz, edited by Tankbuster*/
#define __FILENAME "do_hostageRescue.sqf"
if ((!isServer)) exitWith {};
#include "..\includes.sqf"
__tky_starts
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private _smcleanup = [];
private _potentialStarts = (cpt_position nearEntities ["Logic", 3000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) && {(_x distance2D cpt_position > 500)} && ((_x getVariable "targetlandmassid") isEqualTo cpt_island)};
private _start = selectRandom _potentialStarts;
private _locationName = _start getVariable ["targetname", "Tanky fucked up"];

_spawnPos =  [_start, 0, 400, 15, 0, 0.5, 0 , 0, 1] call tky_fnc_findsafepos;

_loctext = [_spawnPos] call tky_fnc_distanddirfromtown;
smmissionstring = format ["A group of hostiles are holed up %1 with at least a couple of hostages. Eliminate all hostile threats and save at least 2 hostages by bringing them safely back to base.", _loctext];
publicVariable "smmissionstring";

smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];

private _enemyGroup = [_spawnPos, opfor, (configFile >> "CfgGroups" >> "East" >> "OPF_T_F" >> "Infantry" >> "O_T_InfTeam")] call BIS_fnc_spawnGroup;
[_enemyGroup, (getPos (leader _enemyGroup))] call BIS_fnc_taskDefend;
_smcleanup pushBack _enemyGroup;

private _hostageGroup = createGroup blufor;

private _hostageClassnames = [["B_officer_F", "B_helicrew_F", "B_crew_F"], ["C_man_1_1_F", "C_man_1_2_F", "C_man_1_3_F"]];
_hostageClassname = selectRandom _hostageClassnames;

private _floorRand = floor (random 2);

private _hostageAnimations = ["Acts_AidlPsitMstpSsurWnonDnon_loop", "Acts_ExecutionVictim_Loop"];
private _hostageAnimation = selectRandom _hostageAnimations;

private _numHostages = 2 + (ceil (random 2));

aliveHostages = _numHostages;
publicVariable "aliveHostages";

private _hostages = [];

for "_i" from 0 to (_numHostages - 1) do
{
	sleep 0.5;
	private _hostage = _hostageGroup createUnit [(_hostageClassname select _floorRand), _spawnPos, [], 0, "FORM"];
	removeAllWeapons _hostage;
	_hostage disableAI "ALL";
	_hostage setCaptive true;
	_hostage addEventHandler ["Killed", {aliveHostages = aliveHostages - 1; publicVariable "aliveHostages";}];
	_hostageAnimation = selectRandom _hostageAnimations;
	[_hostage, (format ["hostage%1", _i])] call fnc_setVehicleName;
	sleep 0.1;
	_hostages pushBack _hostage;
	_smcleanup pushBack _hostage;
	_hostage setVariable ["mode", "captured", true];
	[_hostage, _hostageAnimation] remoteExec ["switchMove", 0, false];
	diag_log format ["***dhr makes hostage %1, %2", _i, _hostage];
};
[_hostages] spawn tky_fnc_followLeader2;
private _hostagePos = getPosATL hostage0;

private _alarmSpeakers = createVehicle ["Land_Loudspeakers_F", _spawnPos, [], 0, "CAN_COLLIDE"];

private _lightSource = "#lightPoint" createVehicle _spawnPos;
_lightSource setPos (_lightSource modelToWorld [0, 0, (((getNumber (configFile >> "CfgVehicles" >> "Land_Loudspeakers_F" >> "mapSize")) * 2) + 1.43)]);
[_lightSource, [255, 0, 0]] remoteExec ["setLightAmbient", 0, false];
[_lightSource, [255, 0, 0]] remoteExec ["setLightColor", 0, false];
[_lightSource, 0.025] remoteExec ["setLightBrightness", 0, false];
_lightSource lightAttachObject [_alarmSpeakers, [0, 0, 6]];

private _soundSource = createVehicle ["Land_HelipadEmpty_F", _spawnPos, [], 0, "CAN_COLLIDE"];

_alarmSpeakers addEventHandler ["HandleDamage",
{
	if (((_this select 2) >= 0.90)) then
	{
		(_this select 0) setDamage 0;
	};
}];

_alarmSpeakers addEventHandler ["Hit",
{
	_newDamage = (getDammage (_this select 0)) - (_this select 2) + 0.25;
	(_this select 0) setDamage _newDamage;
}];

private _enemySpotted = false;

{
	[_x] joinSilent grpNull;
	_hostagePos set [0, ((_hostagePos select 0) + 2)];
	_x setPosATL _hostagePos;
} forEach _hostages;
diag_log format ["*** dhr says hostages %1", _hostages];

	private _rescuedHostages = 0;
	while {missionactive} do
	{
		sleep 2;
		if (({alive _x }count _hostages) < count _hostages) exitWith
		{
			{
				_x setPos [0, 0, 0];
				_x setDamage 1;
				deleteVehicle _x;
			} forEach _hostages;
			missionsuccess = false;
			publicVariable "missionsuccess";
			missionactive = false;
			publicVariable "missionactive";
			diag_log format ["*** dhr fails mission because some have died"];
			failText = "Mission failed. One or more hostages were killed.";
			publicVariable "failText";
			failText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];

		};
		_rescuedHostages = 0;
		{
			if ((_x inArea "headmarker1") && {((vehicle _x) isEqualTo _x) && (alive _x) && (isTouchingGround _x)}) then
			{
				_rescuedHostages = _rescuedHostages + 1;
			};
		} forEach _hostages;
		if ((_rescuedHostages >= 2)) exitWith
		{
			missionsuccess = true;
			publicVariable "missionsuccess";
			missionactive = false;
			publicVariable "missionactive";

			completionText = "Mission completed. At least two hostages were rescued.";
			publicVariable "completionText";
			completionText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			diag_log format ["*** dhr succeeds. yey"];
		};
	};
diag_log format ["***dhr drops out of main loop, presumably becuae mission not active"];

[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";
__tky_ends;