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

private _hostageAnimations = ["Acts_AidlPsitMstpSsurWnonDnon_loop", "Acts_ExecutionVictim_Loop"];
private _hostageAnimation = selectRandom _hostageAnimations;

private _numHostages = 4 + (ceil (random 4));

aliveHostages = _numHostages;
publicVariable "aliveHostages";

private _hostages = [];

for "_i" from 0 to _numHostages do
{
	private _hostage = _group createUnit [_hostageClassname, _start, [], 0, "FORM"]; // TODO: Proper positions. Maybe a line? 2m apart or something...
	_hostage disableAI "ALL";
	// _hostage addEventHandler ["Killed", tky_fnc_KilledEH];
	// Not in use, at least not at the moment.
	[_hostage, _hostageAnimation] remoteExec ["switchMove", ([0, -2] select isDedicated), false];
	[_hostage, (format ["hostage%1", (_i + 1)])] call fnc_setVehicleName; // Found in functions.sqf (:
	_hostages pushBack _hostage;
};

[_hostages] spawn
{
	params
	[
		["_hostages", []]
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
			} forEach _hostages;
			missionactive = false;
			publicVariable "missionactive";
			failText = "Mission failed. One or more hostages were killed.";
			publicVariable "failText";
			failText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
		if ((_x distance2D (getMarkerPos "respwn_west") < 10)) then
		{
			{
				_rescuedHostages = _rescuedHostages + 1;
			} forEach _hostages;
		};
		if ((_rescuedHostages >= 2)) then
		{
			completionText = "Mission completed. At least two hostages were rescued.";
			publicVariable "completionText";
			completionText remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
};

private _soundSource = "Land_HelipadEmpty_F" createVehicle (position _start);

[_soundSource] spawn
{
	params
	[
		["_soundSource", objNull]
	];
	if ((isNull _soundSource)) exitWith {};
	waitUntil {(2 > 1)}; // TODO: Add condition (...when BLUFOR get spotted by OPFOR...)
	while {(missionactive)} do
	{
		[_soundSource, ["Alarm_BLUFOR", 125, 1]] remoteExec ["say3D", ([0, -2] select isDedicated), false];
		sleep 6.86;
	};
};

// TODO: Cleanup... What is _smcleanup ???
// [_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends;