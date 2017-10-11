scriptName "fn_followLeader2";
//By Tankbuster
__tky_starts
 #include "..\includes.sqf"
#define __FILENAME "fn_followLeader2.sqf"
params
[
	["_hostages", objNull]
];
private _resqleader = objNull; private _resqvec = objNull; private _return = false;
waitUntil
{
	sleep 0.5;
	{
		if (((hostage0 distance2D _x) < 8) && (isPlayer _x)) then
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
diag_log format ["*** fnfl %2 released hostages", _hostages, _resqleader];
{
	[_x, ""] remoteExec ["switchMove", 0, false];
	_x enableAI "ALL";
	_x doMove (getPosATL _resqleader);
	_x setVariable ["mode", "following", true];
} forEach _hostages;
private _resqleaderinvehicle = false;
private _assignvecdone = false;
private _domoveelapsedtime = 0;
private _cargoPositions = 0;

while {(missionactive)} do
{
	switch (true) do
	{
		case (vehicle _x != _x): {_x setVariable ["mode", "invec", true]};
		case (_x inArea "headmarker1"): {_x setVariable ["mode", "resqd", true]};
		case ((not alive resqleader) or (_x distance2d resqleader > 100)): {_x setVariable ["mode", "waiting", true]};
		case (not (isNull _resqvec) and {damage _resqvec > 0.9}): // not sure
	};
	if ( (not _resqleaderinvehicle) and {vehicle _resqleader != _resqleader}) then
	{//hes in vec but in flag is false ie, hes just got in
		_resqleaderinvehicle = true;
		_resqvec = vehicle _resqleader;
		_cargoPositions = getNumber (configFile >> "CfgVehicles" >> typeOf _resqvec >> "transportSoldier");
		diag_log "***fnfl2 says resqleader just got in vec";
	};
	if ((vehicle _resqleader isEqualTo _resqleader) and {_resqleaderinvehicle}) then
	{// hes not in vec, but flag is true ie, hes just got out
		_resqleaderinvehicle = false;
		_resqvec = objNull;
		diag_log "***fnfl2 says reqleader just got out";
	};

	if ((_resqleaderinvehicle) and {not _assignvecdone}) then
	{//resql in the vec but hostages not yet assigned
		{
			_x doMove (getpos _x);
			_x doStop;
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
		if ((_x getVariable "mode") isEqualTo "waiting") then
			{
			if (_x nearEntities ["SolderWB"])//<<<<<<<<<<<<got to here

			};

		if ( (_x isEqualTo vehicle _x) and {_domoveelapsedtime > 10} ) then
			{// each hostage given the domove every once every 10 cycles if host is on ground
				_x doMove (getpos _resqleader);
				diag_log format ["**** doMove given to %1", _x];
				_domoveelapsedtime = 0;
			};// this is to prevent giving domove to ai too often
		if (_domoveelapsedtime < 12) then
			{
				_domoveelapsedtime = _domoveelapsedtime +1;
			};
	}foreach _hostages;
	sleep 1;
};
__tky_end