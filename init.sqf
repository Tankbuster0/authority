_myscript = "init.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
if (worldName == "Altis") then
	{
	_location = createlocation ["NameLocal",  [20983,7242,25.656], 100,100];
	_location setText "Feres airfield";
	//_location = createLocation ["NameLocal", [23145,18443.621,3.1900], 100, 100];
	//_location setText "Almyra airfield";
	_location = createLocation ["NameLocal", [9155.25,21538.2,16.0988], 100,100];
	_location setText "Abdera airfield";
	};
if (serverName in ["Tanky-Testy"]) then {testmode = true;};
fobveh = objNull;
dropveh = objNull;
missionrunning = false; publicVariable "missionrunning";
forwardrespawning = false;
fobrespawning = false;
"fobmarker" setMarkerAlpha 0;
"dropvehmarker" setMarkerAlpha 0;
tky_super_hint = compilefinal "_parray = [_this, 0] call BIS_fnc_param;
	_text = [_this ,1] call BIS_fnc_param;
	{if (_x == player) then {hint _text; [playerSide, 'HQ'] sideChat _text;};}foreach _parray;"; call BIS_fnc_MP;

execVM "functions.sqf";
//execVM "intro.sqf";


// Arty Support Stuff
ArtySupport synchronizeObjectsAdd [SupportReq];
SupportReq synchronizeObjectsAdd [ArtySupport];

// MHQ Curator Build Stuff

// Build Helipad, Can be NULL!
FOBHelipad = objNull;

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


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];