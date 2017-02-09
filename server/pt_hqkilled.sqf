// by tankbuster
_myscript = "pt_hqkilled";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
params ["_obj","_src","_trg"];
sleep 0.5;
diag_log format ["pt_hq says %1 was object hit, source was %2 and %3 pulled the trigger", _obj, _src, _trg];
format ["The enemy HQ here has been destroyed by %1. They now have no further combat air support.", _src] remoteexec ["hint", -2];
hqnet setdamage 1;
pt_hq setdamage 1;
pt_hq removeAllEventHandlers "handledamage";
hq_fire =  createVehicle ["test_EmptyObjectForFireBig", getpos pt_hq, [],0,"NONE"];
_src addscore 1;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];