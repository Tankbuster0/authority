_myscript = _thisscript;
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
[player , [missionNamespace, "currentInventory"]] call bis_fnc_loadInventory;
sleep 1;


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

