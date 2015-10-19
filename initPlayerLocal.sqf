#define filename "initPlayerLocal.sqf"
scriptname "initPlayerLocal.sqf";

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;




waitUntil {initserverfinished};
{_x setpos (getmarkerpos "respawn_west")} foreach playableunits;