_myscript = "init.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
if (worldName == "Altis") then
	{
	_location = createlocation ["NameLocal",  [20983,7242,25.656], 100,100];
	_location setText "Feres airfield";
	_location = createLocation ["NameLocal", [23145,18443.621,3.1900], 100, 100];
	_location setText "Almyra airfield";
	_location = createLocation ["NameLocal", [9155.25,21538.2,16.0988], 100,100];
	_location setText "Abdera airfield";
	};
if (("rhs_main" in activatedAddons) and ("rhsusf_main" in activatedAddons)) then {RHS = true} else {RHS = false};
fobveh = objNull;
dropveh = objNull;
"fobmarker" setMarkerAlpha 0;
"dropvehmarker" setMarkerAlpha 0;
tky_super_hint = compilefinal "_parray = [_this, 0] call BIS_fnc_param;
	_text = [_this ,1] call BIS_fnc_param;
	{if (_x == player) then {hint _text; [playerSide, 'HQ'] sideChat _text;};}foreach _parray;"; call BIS_fnc_MP;

execVM "functions.sqf";

[] spawn //moving markers on forward and fob
	{
	while {true} do
		{
		sleep 1;
		if (not isnull forward) then {"forwardmarker" setMarkerPos getpos forward };
		if (not isnull fobveh) then
			{
			"fobmarker" setMarkerPos getpos fobveh;
			if ((alive fobveh) and (isTouchingGround fobveh)) then // hide marker if fobveh isnt yet in the game or is in the air (ie, being dropped in)
			    {"fobmarker" setMarkerAlpha 1}
			    else
			    {"fobmarker" setMarkerAlpha 0};
		   };
		if (not isNull dropveh) then
			{
			"dropvehmarker" setmarkerpos getpos dropveh;
			"dropvehmarker" setMarkerAlpha 1;
			};
		};
	};

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