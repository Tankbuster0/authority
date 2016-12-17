_myscript = "handlefobgetin.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

if (!isNull(commander (_this select 0))) then
{
	if ((_this select 2)  == (commander (_this select 0)) && ((typeOf (_this select 2)) != "B_soldier_f") ) then
	{
		hint format ["Getting in %1",_this select 2];
		//(_this select 2) synchronizeObjectsAdd [SupportReq];
		//[_this select 2, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
		//(_this select 2) remoteExecCall ["tky_fnc_addSupportRequester",_this select 2, false];
	} else {};
} else {};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];