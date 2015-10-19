#define filename "initServer.sqf"
_thisscript = "initserver.sqf";
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
_opforcenter = createCenter opfor;
_independentcenter = createCenter independent;
blufor setFriend [opfor, 0.1];
opfor setFriend [blufor, 0.1];
initserverfinished = false; publicVariable "initserverfinished";
sleep 1;
["Initialize"] call BIS_fnc_dynamicGroups;
mapsize  = getnumber (configfile/"CfgWorlds"/worldName/"mapSize");
mapcentre = [mapsize / 2, mapsize /2, 0];// <-- is a posatl

primarytargetcounter = 1;


routenumber = 1 + ( floor (random 4));
diag_log format ["***route chosen = %1", routenumber];
"respawn_west" setmarkerpos (getmarkerpos format["%1-0", routenumber]);
_handle1 = [] execVM "server\getprimarytargetlocations.sqf";

waitUntil {scriptDone _handle1};

[] execVM "server\getnextprimary.sqf";

initserverfinished = true;

//diag_log str primarytargetlist;
//[]execVM "server\s_primarytargetmanager.sqf";
publicVariable "initserverfinished";
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];