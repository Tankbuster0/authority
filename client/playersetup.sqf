_myscript = "playersetup.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
waituntil {!isnull player};
waituntil {alive player};
fobdeployactionid = player addaction ["Deploy FOB", "server\fobvehicledeploymanager.sqf", "", 0,false,false];
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];