_myscript = "playersetup.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
//waituntil {alive player};

//waitUntil {((((getpos player select 0) > 100) and ((getpos player select 1) > 100)) or ((player distanceSqr forward) < 3.1) or ((player distanceSqr ammobox)< 3.16))};
sleep 0.5;
//^^^ wait until player really REALLY properly is in game


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
