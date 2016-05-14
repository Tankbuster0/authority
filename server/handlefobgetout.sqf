_myscript = "handlefobgetout.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
unassignCurator cur;
[(_this select 2), SupportReq, ArtySupport] call BIS_fnc_removeSupportLink;
//removeAllActions fobveh;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];