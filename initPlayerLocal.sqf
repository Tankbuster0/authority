#define filename "initPlayerLocal.sqf"
scriptname "initPlayerLocal.sqf";

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;




waitUntil {initserverfinished};
hint "Moving you to respawn!";
sleep 1;
player setpos (getMarkerPos "respawn_west");
//{_x setpos (getmarkerpos "respawn_west")} foreach playableunits;