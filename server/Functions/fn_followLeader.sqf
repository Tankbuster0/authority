scriptName "fn_followLeader";

/*
	Code written by Haz
*/

#define __FILENAME "fn_followLeader.sqf"

if ((!isServer)) exitWith {};

params
[
	["_hostage", objNull]
];

if ((isNull _hostage)) exitWith {};
diag_log format ["***fnfl runs on %1", _hostage];

private _resqleader = objNull;
private _resqvec = objNull;
private _return = false;

waitUntil
{
	sleep 0.1;
	{
		if (((_hostage distance2D _x) < 8) && (isPlayer _x)) then
		{
			_return = true;
			_resqleader = _x;
		} else
		{
			_return = false;
		};
	} forEach allPlayers;
	_return
};
diag_log format ["*** fnfl %2 released hostage %1", _hostage, _resqleader];
[_hostage, ""] remoteExec ["switchMove", 0, false];
_hostage enableAI "ALL";
_hostage doMove (getPosATL _resqleader);

private _resqleaderinvehicle = false;

private _cargoPositions = 0;

while {(missionactive)} do
{
	if ((vehicle _resqleader != _resqleader)) then
	{
		_resqleaderinvehicle = true;
		_resqvec = vehicle _resqleader;
	};
	if ((vehicle _hostage isEqualTo _hostage) and {_resqleaderinvehicle}) then
	{
		_cargoPositions = _resqvec emptyPositions "cargo";
		if ((_cargoPositions > 0)) then
		{
			doStop _hostage;
			_hostage assignAsCargo _resqvec;
			[_hostage] orderGetIn true;
			diag_log format ["***fnfl hostage %1 gets in %2", _hostage, vehicle _resqleader];
			waitUntil {vehicle _hostage != _hostage};
		};
	}
	else
	{
		_hostage doMove (getPosATL _resqleader);
		diag_log format ["***fnfl tells %1 to doMove %2", _hostage, _resqleader];
		sleep 3;
	};
	if ((vehicle _hostage != _hostage) and {isNull (driver vehicle _hostage)})then
		{
			{
			_hostage leaveVehicle _resqvec;
			diag_log format ["***fnfl hostage %1 leaveVehicle %2", _hostage, _resqvec];
			};

		};
	if ({isPlayer _x} count (crew _resqvec) < 1) then {_resqvec = objNull};
	sleep 1;
};