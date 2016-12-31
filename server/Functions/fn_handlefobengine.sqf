_myscript = "handlefobengine.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
params ["_veh", "_ison"];
diag_log format ["***hfe gets _vehicle is %1, engine is %2", _veh, _ison];
if (_ison) then //engine just been turned on. Give arty to all cargo crew in the vehicle
	{
		{
			if ((assignedVehicleRole _x) isEqualTo "cargo") then
			{
				(_x) synchronizeObjectsAdd [SupportReq];
				[_x, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
				(_x) remoteExecCall ["tky_fnc_addSupportRequester",_x, false];
			};
		} foreach (crew _veh);
	}
else //engine just been turned off, remove arty from all cargo crew in the vehicle
	{
		{
			if ((assignedVehicleRole _x) isEqualTo "cargo") then
			{
				[_x, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink",_x, false];
			};
		} foreach (crew _veh);
	};
BIS_supp_refresh = TRUE;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];