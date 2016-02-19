_myscript = "spawnairdrop.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_requestedpos","_airtype","_droptype","_droppos","_testradius"];
params [
["_requestedpos", (getpos ammobox)], // location where the cargo should land
["_airtype", "RHS_C130J"], // classname of delivering aircraft
["_droptype", "rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"]]; // classname of delivered object
// find a good place to land the cargo
_droppos = [0,0,0]; _testradius = 2;
while {_droppos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_droppos = [_requestedpos, 0,_testradius, 4, 0,50,0] call bis_fnc_findSafePos;
		diag_log format ["*** spawnairdrop suggests %1 using radius %2 which is blacklisted %3", _droppos, _testradius, (_droppos in [[0,0,0], islandcentre])];
		_testradius = _testradius * 2;
	};
diag_log format ["*** spawnairdrop decides on %1", _droppos];
_mkr = createMarker ["dropmkr", (_droppos) ];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "hd_dot";

// create the drop veh;

_dropgroup = createGroup west;
_startpos = [_droppos, (5000 + random 5000), 0] call bis_fnc_relPos;
_startpos set [2, 500];
_dir = [_startpos, _droppos] call bis_fnc_dirTo;

_veh = [_startpos, _dir, _airtype, _dropgroup] call bis_fnc_spawnVehicle;
dropveh = (_veh select 0);
dropveh setVelocity [150 * (sin _dir), 150 * (cos _dir), 0];
dropveh setcaptive true;
_dwp = _dropgroup addWaypoint [_droppos, 0];
_dwp setWaypointBehaviour "CARELESS";
_dwp setWaypointSpeed "NORMAL";
_dwp setWaypointtype "MOVE";
_dropgroup setCombatMode "BLUE";
_dropgroup allowFleeing 0;
(driver dropveh) setskill ["courage",1];
(driver dropveh) disableAI "FSM"; (driver dropveh) disableAI "TARGET"; (driver dropveh) disableAI "AUTOTARGET"; (driver dropveh) disableAI "AUTOCOMBAT";

_dwp2 = _dropgroup addWaypoint [_startpos,0];
_dwp2 setWaypointType "MOVE";
_dwp2 setWaypointBehaviour "CARELESS";
_dwp2 setWaypointSpeed "NORMAL";
_dwp2 setWaypointScript "deleteVehiclecrew dropveh; deleteVehicle dropveh;";

waituntil {sleep 0.5; (dropveh distance2D _droppos) < 800 };
_smokepos = _droppos; _smokepos set [2,0];
_smoker1 = createvehicle ["SmokeShellBlue", _smokepos, [],0,"NONE"];
dropveh flyinheight 100;


//dropveh animateDoor something etc blah blah;
waitUntil {(dropveh distance2D _droppos) < 100};
_para = createVehicle ["B_Parachute_02_F", (dropveh modelToWorld [0,-12,0]), [],0, "NONE"];
_smoker1 = createVehicle ["SmokeShellBlue", _smokepos, [],0,"NONE"];
_cargo = createvehicle [_droptype, (_para modelToWorld [0,0,-10]), [],0, "NONE"];
_cargo attachto [_para, [0,0,-2]];
_cargo addEventHandler ["GetIn", {nul = [_this select 0,_this select 1, _this select 2] execVM "server\fobvehicledeploymanager.sqf"}];

[_cargo, _droppos, 0, "blah", _para, false ] spawn tky_fnc_mando_chute;
waitUntil {isTouchingGround _cargo};
detach _cargo;
detach _para;
_underground = _droppos;
_underground set [2, -2];
_para setpos _underground;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];