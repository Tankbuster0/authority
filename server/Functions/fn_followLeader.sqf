scriptName "fn_followLeader";

/*
	Code written by Haz
*/

#define __FILENAME "fn_followLeader.sqf"

if ((!isServer)) exitWith {};

params
[
	["_hostage", objNull],
	["_hostages", objNull]
];

if ((isNull _hostage)) exitWith {};

private _debug = if ((isMultiplayer)) then {playableUnits} else {allUnits};

private _leader = objNull;

private _return = false;

waitUntil
{
	{
		if ((_hostage distance2D _x <= 8) && (isPlayer _x)) then
		{
			_return = true;
			_leader = _x;
		} else
		{
			_return = false;
		};
	} forEach _debug - _hostages;
	_return
};

_hostage doMove (getPosATL _leader);

while {(missionactive)} do
{
	if ((unitReady _hostage)) then
	{
		_hostage doMove (getPosATL _leader);
	};
	sleep 1;
};