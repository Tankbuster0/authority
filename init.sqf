_myscript = "init.sqf";

if (worldName == "Altis") then
	{
	_location = createlocation ["NameLocal",  [20983,7242,25.656], 100,100];
	_location setText "Feres airfield";
	_location = createLocation ["NameLocal", [9155.25,21538.2,16.0988], 100,100];
	_location setText "Abdera airfield";
	};
testmode = false;
if (serverName in ["Tanky-Test", "Tanky test"]) then {testmode = true;};
publicVariable "testmode";
//initserverfinished = false;
fobveh = objNull;
dropveh = objNull;
missionrunning = false; publicVariable "missionrunning";
forwardrespawning = false;
fobrespawning = false;
airprizeawaitingassembly = false;
"fobmarker" setMarkerAlpha 0;
"dropvehmarker" setMarkerAlpha 0;
execVM "functions.sqf";
// Arty Support Stuff
ArtySupport synchronizeObjectsAdd [SupportReq];
SupportReq synchronizeObjectsAdd [ArtySupport];
[] execVM "DEP\init.sqf";
// MHQ Curator Build Stuff

// Build Helipad, Can be NULL!
FOBHelipad = objNull;

//blubasedataterminal = objNull;

//Hack around eventhandler crud
LastSelectedObjects = objNull;

// MHQ Curator Build Stuff
// Objects that can be build by the MHQ curator
[cur,"object"] call BIS_fnc_setCuratorAttributes;
cur setCuratorCoef ["place",-1];
cur setCuratorCameraAreaCeiling 10;
cur addEventHandler ["CuratorObjectPlaced", {[_this select 0, _this select 1] remoteExec ["tky_fnc_curatorObjectPlaced"];}];
// BIS done goofed, this eventhandler does not give its deleted object making my job a lot god damn more difficult
cur addEventHandler ["CuratorObjectDeleted", {[_this select 0, _this select 1] remoteExec ["tky_fnc_curatorObjectRemoved"];}];
cur addEventHandler ["CuratorObjectSelectionChanged", {[_this select 0, _this select 1] remoteExec ["tky_fnc_curatorSelectionChanged"];}];
_nul = execVM "gvs\gvs_init.sqf";
 //[] execVM "server\zerowatcher.sqf";
[] execVM "server\real_weather.sqf";
