// by tankbuster
 #include "..\includes.sqf"
_myscript = "islandhopprizevecrecover.sqf";
__tky_starts
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
waitUntil {sleep 10; islandhop};
if (testmode) then {diag_log "*** ihpr finished waiting as islandhop is now true"};
// message all players something to the effect of
// you've island hopped and can get all of your land prize vehicles here if
// 1. have a helipad at the deployed fob
// 2. put the vehicles you want to bring here near (but not on) the airhead helipad
// 3. use the options at the dataterminal
if (hasInterface) then {diag_log "runs on client because has interface"};
if (isDedicated) then {diag_log "runs on server because isdedicated"};
//"" remoteexecCall ["tky_fnc_t_usefirstemptyinhintqueue",2,false];
"The next target is on a different island. Bring you prize vehicles to the Airhead and airlift the FOB to the new island. Deploy it and make a helipad and you will be able to bring your prize vehicles to the new island." remoteexecCall ["tky_fnc_t_usefirstemptyinhintqueue",2,false];
player setvariable ["isusingprizerecovery", true, true];

__tky_ends

