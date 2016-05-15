_myscript = "handlefobgetseatchanged.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

{
	if ((typeOf _x) != "CUP_B_BAF_Soldier_JTAC_MTP") then 
	{
		_x synchronizeObjectsRemove  [SupportReq];
		[_x, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink", _x, false];
	} else {};
}forEach crew (_this select 0);

if (!isnull (commander (_this select 0)) ) then 
{
	_cmd = commander (_this select 0);
	if ((typeOf _cmd) != "CUP_B_BAF_Soldier_JTAC_MTP") then 
	{
		_cmd synchronizeObjectsAdd [SupportReq];
		[_cmd, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_addSupportLink",_cmd, false];
	} else {};
} else {};
BIS_supp_refresh = TRUE;
//removeAllActions fobveh;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];