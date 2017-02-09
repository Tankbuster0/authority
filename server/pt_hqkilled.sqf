// by tankbuster
_myscript = "pt_hqkilled";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
sleep 0.5;
hqnet setdamage 1;
format ["The enemy HQ here has been destroyed. They now have no further combat air support."] remoteexec ["hint", -2];
pt_fire = createVehicle ["test_EmptyObjectForFireBig", (getpos pt_hq), [],0,"NONE"];


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];