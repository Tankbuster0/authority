// by tankbuster
_myscript = "makeairreinforcement.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
// fix and finish this script. it runs reinforcement, and should only choose troop carrying helicopters

//if (((west countSide allPlayers) > 2)  and ((random 1 )> 0.8)) then {_type = "fw"} else {_type = "rw"};
_
if (type == "fw") then {_type = (["RHS_Su25SM_vvsc", "RHS_Su25SM_KH29_vvs","RHS_T50_vvs_blueonblue"] call BIS_fnc_selectRandom)} else {_type = (["RHS_Su25SM_vvsc", "RHS_Su25SM_KH29_vvs","RHS_T50_vvs_blueonblue"] call BIS_fnc_selectRandom)}

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];