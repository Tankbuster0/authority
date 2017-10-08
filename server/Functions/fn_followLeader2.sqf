scriptName "fn_followLeader2";

//By Tankbuster

 #include "..\includes.sqf"
#define __FILENAME "fn_followLeader.sqf"

if ((!isServer)) exitWith {};

params
[
	["_hostages", objNull]
];
private _resqleader = objNull;
private _resqvec = objNull;
private _return = false;

waitUntil
{
	sleep 0.5;
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
diag_log format ["*** fnfl %2 released hostages", _hostage, _resqleader];
{
[_x, ""] remoteExec ["switchMove", 0, false];
_x enableAI "ALL";
_x doMove (getPosATL _resqleader);
} forEach _hostages;
private _resqleaderinvehicle = false;
private _assignvecdone = false;
private _domoveelapsedtime = 0;
private _cargoPositions = 0;

while {(missionactive)} do
{

	if ( (not _resqleaderinvehicle) and {vehicle _resqleader != _resqleader}) then
	{//hes in vec but in flag is false ie, hes just got in
		_resqleaderinvehicle = true;
		_resqvec = vehicle _resqleader;
		diag_log "***fnfl2 says resqleader just got in vec";
	};
	if ((vehicle _resqleader isEqualTo _resqleader) and {_resqleaderinvehicle})
	{// hes not in vec, but flag is true ie, hes just got out
		_resqleaderinvehicle = false;
		_resqvec = objNull;
		diag_log "***fnfl2 says reqleader just got out";
	};


	if ((_resqleaderinvehicle) and {not _assignvecdone}) then
	{//resql in the vec but hostages not yet assigned
		{
			_x assignAsCargo _resqvec;
			diag_log format ["*** %1 is in vec role %1", _x, assignedVehicleRole _x];
		} foreach _hostages;
		_assignvecdone = true;
		[_hostages] orderGetIn true;
	};
	if ((not _resqleaderinvehicle) and {_assignvecdone}) then
	{// resql not in the vec, but hostages still assigned in it
		{
			unassignVehicle _x;
			diag_log format ["*** %1 unassigned a vec and role is %2", _x, assignedVehicleRole _x];
		}foreach _hostages;
		_assignvecdone = false;
		[_hostages] orderGetIn false;
	};

	{
		if (_x isEqualTo vehicle _x) and (_domoveelapsedtime > 10) then
			{// each hostage given the domove every once every 10 cycles if host is on ground
				_x doMove _resqleader;
				diag_log format ["**** doMove given to %1", _x];
				_domoveelapsedtime = 0;
			};
		if (_domoveelapsedtime < 12) then
			{
				_domoveelapsedtime = _domoveelapsedtime +1;
			};
	}foreach _hostages;
/*

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

*/
	sleep 1;
};