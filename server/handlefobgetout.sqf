_myscript = "handlefobgetout.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
unassignCurator cur;
if (str player == "alpha_10" || str player == "bravo_10") then {
[_this select 2, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink", 2, false];} else {};
//removeAllActions fobveh;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];