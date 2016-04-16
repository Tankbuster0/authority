_myscript = "spawnairdrop.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_requestedpos","_airtype","_droptype","_droppos","_testradius","_inpos","_mkr","_dropgroup","_startpos","_dir","_veh","_dwp","_dwp2","_smokepos","_smoker1","_para","_cargo","_underground", "_spawndir", "_mytime"];
params [
["_inpos", (getpos ammobox)], // location where the cargo should land
["_airtype", "CUP_B_C130J_Cargo_GB"], // classname of delivering aircraft
["_droptype", fobvehicleclassname],// classname of deliverd objects
["_spawnpoint", [0,0,0]]
]; // classname of delivered object
_mytime = serverTime;
// find a good place to land the cargo
_droppos = [0,0,0]; _testradius = 4;
if (typeName _inpos == "ARRAY" ) then {_requestedpos = _inpos} else {_requestedpos = (getpos _inpos)};
while {_droppos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_droppos = [_requestedpos, 3,_testradius, 4, 0,50,0] call bis_fnc_findSafePos;
		//diag_log format ["*** spawnairdrop suggests %1 using radius %2 which is blacklisted %3", _droppos, _testradius, (_droppos in [[0,0,0], islandcentre])];
		_testradius = _testradius * 2;
	};
//diag_log format ["*** spawnairdrop decides on %1", _droppos];
_mkr = createMarker ["dropmkr", (_droppos) ];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "hd_dot";

// create the drop veh;

_dropgroup = createGroup west;
_spawndir = floor (random 360);
if (_spawnpoint isEqualTo [0,0,0]) then
	{
	_startpos = [_droppos, (3000 + random 3000), _spawndir] call bis_fnc_relPos;
	} else
	{
	_startpos = _spawnpoint;
	};
_startpos set [2, 500];
_dir = [_startpos, _droppos] call bis_fnc_dirTo;

_veh = [_startpos, _dir, _airtype, _dropgroup] call bis_fnc_spawnVehicle;
dropveh = (_veh select 0);
dropveh setVelocity [150 * (sin _dir), 150 * (cos _dir), 0];
dropveh setcaptive true;
/*
_dwp = _dropgroup addWaypoint [_droppos, 0];
_dwp setWaypointBehaviour "CARELESS";
_dwp setWaypointSpeed "NORMAL";
_dwp setWaypointtype "MOVE";
_dropgroup setCombatMode "BLUE";
*/
_dropgroup allowFleeing 0;
(driver dropveh) setskill ["courage",1];
(driver dropveh) disableAI "FSM"; (driver dropveh) disableAI "TARGET"; (driver dropveh) disableAI "AUTOTARGET"; (driver dropveh) disableAI "AUTOCOMBAT";
dropveh domove _droppos;

_dwp2 = _dropgroup addWaypoint [_startpos,0];
_dwp2 setWaypointType "MOVE";
_dwp2 setWaypointBehaviour "CARELESS";
_dwp2 setWaypointSpeed "NORMAL";
_dwp2 setWaypointCompletionRadius 2000;
_dwp2 setWaypointScript "deleteVehiclecrew dropveh; deleteVehicle dropveh;'dropvehmarker' setMarkerAlpha 0; ";

waituntil {sleep 0.5; (((dropveh distance2D _droppos) < 1000) or (serverTime > (_mytime + 90))) };
if (serverTime > (_mytime + 90)) exitWith
	{
	//diag_log "***spawnairdrop timed out. ";
	{ dropveh deleteVehicleCrew _x} foreach crew dropveh;
	deleteVehicle dropveh;
	while {(count (waypoints _dropgroup)) > 0} do
		{
		deleteWaypoint ((waypoints _dropgroup) select 0);
		};
	sleep 5;
	_spawndir = _spawndir -180;
	if (_spawndir < 0) then {_spawndir = _spawndir + 360};
	nul = [_droppos, _airtype, _droptype, ([_droppos, (3000 + random 3000), _spawndir] call bis_fnc_relPos)] execVM "server\spawnairdrop.sqf";
	//^^^ if after 3 mins, the herc hasn't dropped, delete it and go again having him approach from the opposite direction
	};
_smokepos = _droppos; _smokepos set [2,0];
_smoker1 = createvehicle ["SmokeShellBlue", _smokepos, [],0,"NONE"];
dropveh flyinheight 100;
//dropveh animateDoor something etc blah blah;
waitUntil {(dropveh distance2D _droppos) < 100};
_para = createVehicle ["B_Parachute_02_F", (dropveh modelToWorld [0,-12,0]), [],0, "NONE"];
_smoker1 = createVehicle ["SmokeShellBlue", _smokepos, [],0,"NONE"];
if (_droptype == forwardpointvehicleclassname) then
	{
	_cargo = createvehicle [_droptype, (_para modelToWorld [0,0,-10]), [],0, "FLY"];
	forward = _cargo;
	forward setpos (_para modelToWorld [0,0,-10]);
	_cargo addMPEventHandler ["MPkilled", {sleep 1 + (3 *(random 2)); nul = [_this select 0, _this select 0] execVM "server\assetrespawn.sqf"}];
	} else
	{
	_cargo = createvehicle [_droptype, (_para modelToWorld [0,0,-10]), [],0, "FLY"];
	};
if (_droptype == fobvehicleclassname) then //it's a fob vehicle
	{
	_cargo addEventHandler ["GetIn", {nul = [_this select 0,_this select 1, _this select 2] execVM "server\handlefobgetin.sqf"}];
	_cargo addEventHandler ["GetOut", {unassignCurator cur;}];
	_cargo addMPEventHandler ["mpkilled", {nul = [_this select 0, _this select 0] execVM "server\assetrespawn.sqf"}];
	fobveh = _cargo;
	};
_cargo attachto [_para, [0,0,0]];
/*
rope1 = ropeCreate [_para, "SlingLoad0", _cargo, [1,1.65,1], 7];
rope2 = ropeCreate [_para, "SlingLoad0", _cargo, [-1,1.65,1],7];
rope3 = ropeCreate [_para, "SlingLoad0", _cargo, [1,-5,1.5],7];
rope4 = ropeCreate [_para, "SlingLoad0", _cargo, [-1,-5,1.5],7];
*/
sleep 1;
[_cargo, _droppos, 0, _para, false ] spawn tky_fnc_mando_chute;
waitUntil {isTouchingGround _cargo};
detach _cargo;
detach _para;
_underground = _droppos;
_underground set [2, -2];
_para setpos _underground;
if (_droptype == forwardpointvehicleclassname) then {forwardrespawnpositionid = [west,"forwardmarker", "Forward Vehicle"] call bis_fnc_addRespawnPosition;};
["UniqueId",
	{
	{ dropveh deleteVehicleCrew _x} foreach crew dropveh;
	deleteVehicle dropveh;
	 }, 30, "seconds"] call BIS_fnc_runlater;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];