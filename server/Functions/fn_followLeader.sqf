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

[_hostage, ""] remoteExec ["switchMove", ([0, -2] select isDedicated), false];
_hostage enableAI "ALL";
_hostage doMove (getPosATL _leader);

private _cargoPositions = 0;

while {(missionactive)} do
{
	if ((unitReady _hostage)) then
	{
		_hostage doMove (getPosATL _leader);
	};
	_cargoPositions = (vehicle _leader) emptyPositions "cargo";
	if ((vehicle _leader != _leader) && (_cargoPositions > 0)) then
	{
		_hostage assignAsCargo _hostage;
		[_hostage] orderGetIn true;
	};
	sleep 1;
};