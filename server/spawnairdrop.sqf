_myscript = "spawnairdrop.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_requestedpos","_airtype","_droptype","_droppos","_testradius","_inpos","_mkr","_dropgroup","_startpos","_dir","_veh","_dwp","_dwp2","_smokepos","_smoker1","_para","_cargo","_underground", "_spawndir", "_mytime", "_dropveh"];
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
/*_mkr = createMarker ["dropmkr", (_droppos) ];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "hd_dot";
*/
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
_startpos set [2, 100];
_droppos set [ 2,100];
_dir = [_startpos, _droppos] call bis_fnc_dirTo;

_veh = [_startpos, _dir, _airtype, _dropgroup] call bis_fnc_spawnVehicle;
_dropveh = (_veh select 0);
_dropveh setVelocity [200 * (sin _dir), 200 * (cos _dir), 0];
_dropveh setcaptive true;
_dropveh flyInHeight 100;

_dwp = _dropgroup addWaypoint [_droppos, 0];
_dwp setWaypointBehaviour "CARELESS";
_dwp setWaypointSpeed "NORMAL";
_dwp setWaypointtype "MOVE";
_dropgroup setCombatMode "BLUE";

_dropgroup allowFleeing 0;
(driver _dropveh) setskill ["courage",1];
(driver _dropveh) disableAI "FSM"; (driver _dropveh) disableAI "TARGET"; (driver _dropveh) disableAI "AUTOTARGET"; (driver _dropveh) disableAI "AUTOCOMBAT";

_dwp2 = _dropgroup addWaypoint [_startpos,0];
_dwp2 setWaypointType "MOVE";
_dwp2 setWaypointBehaviour "CARELESS";
_dwp2 setWaypointSpeed "NORMAL";
_dwp2 setWaypointCompletionRadius 2000;
_dwp2 setWaypointScript "deleteVehiclecrew _dropveh; deleteVehicle _dropveh;'_dropvehmarker' setMarkerAlpha 0; ";

waituntil {sleep 0.5; (((_dropveh distance2D _droppos) < 1000) or (serverTime > (_mytime + 90))) };
if (serverTime > (_mytime + 90)) exitWith
	{

	{ _dropveh deleteVehicleCrew _x} foreach crew _dropveh;
	deleteVehicle _dropveh;
	while {(count (waypoints _dropgroup)) > 0} do
		{
		deleteWaypoint ((waypoints _dropgroup) select 0);
		};
	sleep 5;
	_spawndir = _spawndir -180;
	if (_spawndir < 0) then {_spawndir = _spawndir + 360};
	nul = [_droppos, _airtype, _droptype, ([_droppos, (3000 + random 3000), _spawndir] call bis_fnc_relPos)] execVM "server\spawnairdrop.sqf";
	//^^^ if after 1.5 mins, the herc hasn't dropped, delete it and go again having him approach from the opposite direction
	};
_smokepos = _droppos; _smokepos set [2,0];
_smoker1 = createvehicle ["SmokeShellBlue", _smokepos, [],0,"NONE"];
_dropveh flyinheight 100;
waitUntil {(_dropveh distance2D _droppos) < 100};

_smoker1 = createVehicle ["SmokeShellBlue", _smokepos, [],0,"NONE"];
diag_log format ["*** spawnairdrop makes %1", _droptype];
_cargo = createvehicle [_droptype, (_dropveh modelToWorld [0,0,-10]), [],0, "FLY"];
diag_log format ["*** _cargo is %1", typeOf _cargo];
if (_droptype == forwardpointvehicleclassname) then
	{
	forward = _cargo;
	forward setpos (_para modelToWorld [0,0,-10]);
	_cargo addMPEventHandler ["MPkilled", {sleep 1 + (3 *(random 2)); nul = [_this select 0, _this select 0] execVM "server\assetrespawn.sqf"}];
	[forward, "[[[[],[]],[[""CUP_30Rnd_556x45_Stanag"",""30Rnd_556x45_Stanag"",""30Rnd_65x39_caseless_green"",""20Rnd_762x51_Mag"",""CUP_30Rnd_556x45_G36"",""CUP_Javelin_M"",""CUP_MAAWS_HEAT_M"",""CUP_MAAWS_HEDP_M"",""CUP_SMAW_HEDP_M"",""Titan_AA"",""Titan_AT"",""CUP_Stinger_M""],[25,25,25,25,20,25,20,20,15,20,20,10]],[[""ACE_fieldDressing"",""ACE_bloodIV"",""ACE_morphine""],[30,20,30]],[[],[]]],false]"] call BIS_fnc_initAmmoBox; // same as put in the sqm, don't forget to change both when changing this!!!
	["ace_wheel", forward, 6, false] call ace_cargo_fnc_addCargoItem;
	};
if (_droptype == fobvehicleclassname) then //it's a fob vehicle
	{
	_cargo addEventHandler ["GetOut", {_nul = [] execVM "server\handlefobgetout.sqf"}];
	_cargo addMPEventHandler ["mpkilled", {nul = [_this select 0, _this select 0] execVM "server\assetrespawn.sqf"}];
	fobveh = _cargo;
	[fobveh, "[[[[],[]],[[""SatchelCharge_Remote_Mag""],[20]],[[""ACE_fieldDressing"",""ACE_bloodIV"",""ACE_CableTie"",""ACE_Clacker"",""ACE_morphine"",""ToolKit""],[50,20,20,15,50,10]],[[],[]]],false]"] call BIS_fnc_initAmmoBox; // same as put in the sqm, don't forget to change both when changing this!!!
	publicVariable "fobveh";
	["ace_wheel", fobveh, 6, false] call ace_cargo_fnc_addCargoItem;
	};
if (_cargo iskindof "Cargo_Base_F") then //
	{
	mycontainer = _cargo;
	};
while {(getPosATL _cargo select 2) > 100} do {sleep 0.1};
diag_log "*** spawnairdrop makes parachute";
_cargopos = getpos _cargo;
_para = createVehicle ["B_Parachute_02_F", _cargopos, [],0, "NONE"];
//_para = createVehicle ["B_Parachute_02_F", (_cargo modelToWorld [0,0,0]), [],0, "NONE"];
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
	{ _dropveh deleteVehicleCrew _x} foreach crew _dropveh;
	deleteVehicle _dropveh;
	 }, 30, "seconds"] call BIS_fnc_runlater;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];