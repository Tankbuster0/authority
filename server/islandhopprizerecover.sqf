// by tankbuster
 #include "..\includes.sqf"
_myscript = "islandhopprizevecrecover.sqf";
__tky_starts
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
waitUntil {sleep 10; islandhop};
if (testmode) then {diag_log "*** ispr finished waiting as islandhop is now true"};
// message all players something to the effect of
//


__tky_ends

