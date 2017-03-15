 #include "..\includes.sqf"
_myscript = "handlefobengine.sqf";
__tky_starts;
params ["_veh", "_ison"];
diag_log format ["***hfe gets _vehicle is %1, engine is %2", _veh, _ison];
if (_ison) then //engine just been turned on. remove arty from all cargo crew in the vehicle
	{
		diag_log "*** hfe engine starts";
		{
			if (((assignedVehicleRole _x) select 0) isEqualTo "cargo") then
			{
				[_x, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink",_x, false];
				diag_log "***hfe removes arty";
			};
		} foreach (crew _veh);
	}
else //engine just been turned off, give arty to all cargo crew in the vehicle
	{
		diag_log "*** hfe engine stops";
		{
			if (((assignedVehicleRole _x) select 0) isEqualTo "cargo") then
			{
				(_x) synchronizeObjectsAdd [SupportReq];
				[_x, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
				(_x) remoteExecCall ["tky_fnc_addSupportRequester",_x, false];
				diag_log "***hfe gives arty";
			};
		} foreach (crew _veh);
	};
BIS_supp_refresh = TRUE;
__tky_ends



