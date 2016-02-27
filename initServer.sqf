_myscript = "initserver.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
initserverfinished = false; publicVariable "initserverfinished";
missionsetupprogress = 0; publicVariable "missionsetupprogress";
sleep 0.5;
opforcenter = createCenter opfor;
independentcenter = createCenter independent;
logiccenter = createCenter sideLogic;
blufor setFriend [opfor, 0.1];
opfor setFriend [blufor, 0.1];
#include "server\global_variables.sqf";
["Initialize"] call BIS_fnc_dynamicGroups;
mapsize  = getnumber (configfile/"CfgWorlds"/worldName/"mapSize");
mapcentre = [mapsize / 2, mapsize /2, 0];// <-- is a posatl
sleep 0.5;
primarytargetcounter = 1;
if !(worldName in ["Altis", "altis"]) then // remove the ! to make this if statement work as intended. wip
	{
	altisdata = (loadfile "targetdata\altis.txt") splitstring "\";

	}else
	{
	_handle1 = [] execVM "server\getprimarytargetlocations.sqf";
	waitUntil {scriptDone _handle1};
	};
sleep 0.5;
_handle2 = [] execVM "server\missionsetup.sqf";
waitUntil {scriptDone _handle2};
sleep 0.5;
_handle3 = [] execVM "server\doprimary.sqf";
initserverfinished = true;
publicVariable "initserverfinished";
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
















