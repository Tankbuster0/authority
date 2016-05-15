_myscript = "handlefobgetout.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
unassignCurator cur;
if ((typeOf (_this select 2)) != "CUP_B_BAF_Soldier_JTAC_MTP") then 
{
	//
	[_this select 2, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink",_this select 2, false];
} else {};
BIS_supp_refresh = TRUE;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];