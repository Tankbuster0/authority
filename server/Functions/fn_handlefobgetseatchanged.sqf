 #include "..\includes.sqf"
_myscript = "fn_handlefobgetseatchanged.sqf";
__tky_starts

params ["_veh", "_seat1", "_seat2"];
diag_log format ["***hfgsc gets vehicle = %1, seat1 = %2 and seat2 = %3", _veh, _seat1, _seat2];

if (((assignedVehicleRole _seat1) select 0)  isEqualTo "cargo" and (!(isEngineOn _veh))) then // they've switched into a cargo seat
	{
		(_seat1) synchronizeObjectsAdd [SupportReq];
		[_seat1, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
		(_seat1) remoteExecCall ["tky_fnc_addSupportRequester",_seat1, false];
	};
if (!(((assignedVehicleRole _seat1) select 0) isEqualTo "cargo")) then //they've switched into a non cargo seat
	{
		[_seat1, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink",_seat1, false];
	};


BIS_supp_refresh = TRUE;
//removeAllActions fobveh;
__tky_ends