//By Tankbuster
#include "..\includes.sqf"
__tky_starts
params
[
	["_hostages", objNull]
];
private _resqleader = objNull; private _resqvec = objNull; private _return = false; whodiscd= objNull;
waitUntil
{
	sleep 0.5;
	if ( isplayer (((hostage0 nearEntities ["SoldierWB", 4]) - _hostages) select 0) ) then
	{
		_return = true;
		_resqleader =  ((hostage0 nearEntities ["SoldierWB", 4]) - _hostages) select 0;
	} else
	{
		_return = false;
	};
	_return
};
diag_log format ["*** fnfl %2 released hostages", _hostages, _resqleader];
{
	[_x, ""] remoteExec ["switchMove", 0, false];
	_x enableAI "ALL";
	_x doMove (getPosATL _resqleader);
	_x setVariable ["mode", "following", true];
	_x allowFleeing 0;
} forEach _hostages;
private _resqleaderinvehicle = false;
private _assignvecdone = false;
private _domoveelapsedtime = 0;
private _cargoPositions = 0;
private _nrdudes = [];
private _nrsoldrs = [];
//modes are captured, waiting, invec, following, resqd
while {(missionactive)} do
{
	{
		switch (true) do
		{
			//case (vehicle _x != _x): {_x setVariable ["mode", "invec", true]};
			case (_x inArea "headmarker1"): {_x setVariable ["mode", "resqd", true]};
			case ((not alive _resqleader) or (_x distance2d _resqleader > 100)): {_x setVariable ["mode", "waiting", true]};
			case (not (isNull _resqvec) and {damage _resqvec > 0.9}): {};// not sure
		};
	} forEach _hostages;
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
			//_x doMove (getpos _x);
			//doStop _x;
			_x assignAsCargo _resqvec;
			sleep 0.1;
			diag_log format ["*** %1 is in %3 role %2", _x, assignedVehicleRole _x, assignedVehicle _x];
			if (not (isNull assignedVehicle _x)) then
				{// assignvehicle command worked, make them get in vec
					_x setVariable ["mode", "invec",true];
					[_x] orderGetIn true;
				}
				else
				{// assignvehicle failed because not enough seats, make them stop and set mode to waiting
					_x setVariable ["mode", "waiting", true];
					doStop _x;
				};
		} foreach _hostages;
		_assignvecdone = true;
		//[_hostages] orderGetIn true;
	};
	if ((not _resqleaderinvehicle) and {_assignvecdone}) then
	{// resql not in the vec, but hostages still assigned in it
		{// make them getout, then set mode to waiting. (if the resqldr is nearby, they'll quickly get set to following)
			unassignVehicle _x;
			diag_log format ["*** %1 unassigned to %3 and role is %2", _x, assignedVehicleRole _x, assignedVehicle _x];
			_x setVariable ["mode", "waiting", true];
		}foreach _hostages;
		_assignvecdone = false;
		[_hostages] orderGetIn false;
	};

	{
		if ((_x getVariable "mode") in ["waiting", "captured"]) then
			{// waiting hostages wait for a new resqr
				_nrsoldrs = (_x nearentities ["SoldierWB", 8]) - _hostages;
				if ( isplayer(_nrsoldrs select 0) ) then
					{
						_resqleader = _nrsoldrs select 0;
						_x doMove (getPosATL _resqleader);
						_x setVariable ["mode", "following", true];
					};
			};
		if ( ((not isNull _resqleader) and (not alive _resqleader)) or (pdflag and (whodiscd isEqualTo _resqleader)) ) then
			{// if resqleader dies or quits, hostages stop following and dismount (they might not actually be ina vehicle, but nvm)
				_x setVariable ["mode", "waiting", true];
				_x leaveVehicle vehicle _x;
			};
		if ( (_x isEqualTo vehicle _x) and {(_domoveelapsedtime > 10) and (_x getVariable "mode" isEqualTo "following")} ) then
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
__tky_ends