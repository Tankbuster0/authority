_myscript = "spawnairdrop.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_requestedpos","_airtype","_droptype","_droppos","_testradius","_inpos","_mkr","_dropgroup","_startpos","_dir","_veh","_dwp","_dwp2","_smokepos","_smoker1","_para","_cargo","_underground", "_spawndir", "_mytime"];
params [
["_inpos", (getpos ammobox)], // location where the cargo should land
["_airtype", blufordropaircraft], // classname of delivering aircraft
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
	_startpos = [_droppos, (3000 + random 1000), _spawndir] call bis_fnc_relPos;
	} else
	{
	_startpos = _spawnpoint;
	};
_startpos set [2, 200];
_droppos set [ 2,150];
_dir = [_startpos, _droppos] call bis_fnc_dirTo;

_veh = [_startpos, _dir, _airtype, _dropgroup] call bis_fnc_spawnVehicle;
dropveh = (_veh select 0);
dropveh setVelocity [200 * (sin _dir), 200 * (cos _dir), 0];
dropveh setcaptive true;
dropveh flyInHeight 200;

_dwp = _dropgroup addWaypoint [_droppos, 0];
_dwp setWaypointBehaviour "CARELESS";
_dwp setWaypointSpeed "NORMAL";
_dwp setWaypointtype "MOVE";
_dropgroup setCombatMode "BLUE";

_dropgroup allowFleeing 0;
(driver dropveh) setskill ["courage",1];
(driver dropveh) disableAI "FSM"; (driver dropveh) disableAI "TARGET"; (driver dropveh) disableAI "AUTOTARGET"; (driver dropveh) disableAI "AUTOCOMBAT";
//dropveh domove _droppos;

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
	[forward, "[[[[""FirstAidKit""],[1]],[[""CUP_30Rnd_556x45_Stanag"",""30Rnd_556x45_Stanag"",""30Rnd_65x39_caseless_green"",""20Rnd_762x51_Mag"",""CUP_30Rnd_556x45_G36"",""CUP_Javelin_M"",""CUP_Dragon_EP1_M"",""CUP_MAAWS_HEAT_M"",""CUP_MAAWS_HEDP_M"",""CUP_SMAW_HEAA_M"",""CUP_SMAW_HEDP_M"",""Titan_AA"",""Titan_AP"",""Titan_AT""],[50,50,50,50,50,25,10,30,30,15,15,30,30,30]],[[""ACE_fieldDressing"",""ACE_bloodIV"",""ACE_morphine""],[50,40,50]],[[],[]]],false]"] call BIS_fnc_initAmmoBox; // same as put in the sqm, don't forget to change both when changing this!!!
	["ace_wheel", forward, 4, false] call ace_cargo_fnc_addCargoItem;
	} else
	{
	_cargo = createvehicle [_droptype, (_para modelToWorld [0,0,-10]), [],0, "FLY"];
	};
if (_droptype == fobvehicleclassname) then //it's a fob vehicle
	{
	_cargo addEventHandler ["GetIn", {_nul = [_this select 0,_this select 1, _this select 2] execVM "server\handlefobgetin.sqf"}];
	_cargo addEventHandler ["GetOut", {_nul = [] execVM "server\handlefobgetout.sqf"}];
	_cargo addMPEventHandler ["mpkilled", {nul = [_this select 0, _this select 0] execVM "server\assetrespawn.sqf"}];
	fobveh = _cargo;
	publicVariable "fobveh";
	["ace_wheel", fobveh, 10, false] call ace_cargo_fnc_addCargoItem;
	};
_cargo attachto [_para, [0,0,0]];
_cargo allowDamage false;
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
_cargo allowdamage true;
if (_droptype == forwardpointvehicleclassname) then {forwardrespawnpositionid = [west,"forwardmarker", "Forward Vehicle"] call bis_fnc_addRespawnPosition;};
["UniqueId",
	{
	{ dropveh deleteVehicleCrew _x} foreach crew dropveh;
	deleteVehicle dropveh;
	 }, 30, "seconds"] call BIS_fnc_runlater;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];