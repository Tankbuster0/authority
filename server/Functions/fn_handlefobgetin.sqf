 #include "..\includes.sqf"
_myscript = "handlefobgetin.sqf";
__tky_starts;
params ["_veh", "_seat", "_unit"];
diag_log format ["***hfgin gets _veh %1_seat %2, _unit %3", _veh, _seat, _unit];
if (_seat isEqualTo "cargo") then // player is getting into cargo seat
{
	if !(isEngineOn _veh ) then
	// ^^ the guy who got in is in cargo seat and vehicle is off
	{
		hint format ["***%1 getting in %2 seat of %3. adding arty comms", _unit, _seat, _veh];
		(_unit) synchronizeObjectsAdd [SupportReq];
		[_unit, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
		(_unit) remoteExecCall ["tky_fnc_addSupportRequester",_unit, false];
		BIS_supp_refresh = TRUE;
	} else {diag_log "***hfgin says someone got in cargo, but engine was on"};
} else {diag_log "*** hfgin says someone got in a seat other than cargo"};
__tky_ends