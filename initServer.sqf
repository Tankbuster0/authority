_myscript = "initserver.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
initserverfinished = false; publicVariable "initserverfinished";
missionsetupprogress = 0; publicVariable "missionsetupprogress";
sleep 1;
opforcenter = createCenter opfor;
independentcenter = createCenter independent;
logiccenter = createCenter sideLogic;
blufor setFriend [opfor, 0.1];
opfor setFriend [blufor, 0.1];
#include "server\global_variables.sqf";
["Initialize"] call BIS_fnc_dynamicGroups;
mapsize  = getnumber (configfile/"CfgWorlds"/worldName/"mapSize");
mapcentre = [mapsize / 2, mapsize /2, 0];// <-- is a posatl
sleep 2;
primarytargetcounter = 1;

_handle1 = [] execVM "server\getprimarytargetlocations.sqf";

waitUntil {scriptDone _handle1};
sleep 1;
_handle2 = [] execVM "server\missionsetup.sqf";
waitUntil {scriptDone _handle2};
sleep 1;
_handle3 = [] execVM "server\doprimary.sqf";
initserverfinished = true;
publicVariable "initserverfinished";
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

// MHQ Curator Build Stuff
// Objects that can be build by the MHQ curator 
//removeAllCuratorAddons cur;

// Addons for the curator
/*cur addCuratorAddons [
"A3_Static_F_Gamma_AA",
"A3_Static_F_Gamma_AT",
"A3_Static_F_Gamma",
"A3_Static_F_Mortar_01",
"A3_Structures_F_Mil_BagBunker",
"A3_Structures_F_Mil_BagFence",
"A3_Structures_F_Mil_Fortification",
"A3_Structures_F_Mil_Helipads",
"A3_Structures_F_Mil_Shelters"
];*/

[cur,"object"] call BIS_fnc_setCuratorAttributes;
cur setCuratorCameraAreaCeiling 10;


















