_myscript = "playersetup.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
waituntil {!isnull player};
waituntil {alive player};
fobdeployactionid = player addaction ["Deploy FOB", "server\fobvehicledeploymanager.sqf", "", 0,false,false, "", "(player isEqualTo (driver fobveh)) and (round (speed fobveh) isEqualTo 0)"];
//fobdeployactionid = player addaction ["Deploy FOB", "server\fobvehicledeploymanager.sqf", "", 0,false,false, "", "true"];
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];