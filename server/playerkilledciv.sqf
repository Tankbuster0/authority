//playerkilledciv.sqf
// by tankbuster
_myscript = "playerkilledciv.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
civkillcount = civkillcount + 1;
diag_log format ["civkillcount now %1", civkillcount];

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];