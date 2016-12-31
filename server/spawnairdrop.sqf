_myscript = "spawnairdrop.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_inpos","_airtype","_droptype","_spawnpoint","_mytime","_thisaidropiteration","_droppos","_testradius","_requestedpos","_mkrnumber","_mkr","_dropgroup","_spawndir","_startpos","_dir","_veh","_dropveh","_dwp","_dwp2","_dropvehmarker","_smokepos","_smoker1","_eventualtype","_cargo","_nul","_cargopos","_para","_underground","_myvalue","_movingtowardsend","_1pos","_2pos"];
params [
["_inpos", (getpos ammobox)], // location where the cargo should land
["_airtype", blufordropaircraft], // classname of delivering aircraft
["_droptype", fobvehicleclassname],// classname of delivered object
["_spawnpoint", [0,0,0]]
]; // classname of delivered object
_mytime = serverTime;
airdropcounter = airdropcounter +1;
if (airdropcounter isEqualTo 27) then {airdropcounter =1};
_thisaidropiteration = airdropcounter;
// find a good place to land the cargo
_droppos = [0,0,0]; _testradius = 4;
if (typeName _inpos == "ARRAY" ) then {_requestedpos = _inpos} else {_requestedpos = (getpos _inpos)};
while {_droppos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_droppos = [_requestedpos, 1,_testradius, 4, 0,50,0] call bis_fnc_findSafePos;
		_testradius = _testradius * 2;
	};
_mkrnumber = format ["ad%1", _thisaidropiteration];
_mkr = createMarker [_mkrnumber, (_droppos) ];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "b_plane";
_mkrnumber setMarkerText ("Charlie Juliet " + (_thisaidropiteration call BIS_fnc_phoneticalWord) );

// create the drop veh;

_dropgroup = createGroup west;
_spawndir = floor (random 360);
if (_spawnpoint isEqualTo [0,0,0]) then
	{
	_startpos = [_droppos, (4000 + random 4000), _spawndir] call bis_fnc_relPos;
	} else
	{
	_startpos = _spawnpoint;
	};
_startpos set [2, 200];
_droppos set [ 2,100];
_dir = [_startpos, _droppos] call bis_fnc_dirTo;

_veh = [_startpos, _dir, _airtype, _dropgroup] call bis_fnc_spawnVehicle;

_dropveh = (_veh select 0);
[_dropveh, _mkrnumber] spawn
	{
	while {not isNull (_this select 0)} do
		{
		(_this select 1) setMarkerPos (getpos (_this select 0));
		sleep 0.5;
		};
	};
// ^^ marker to follow the c130
_dropveh setVelocity [200 * (sin _dir), 200 * (cos _dir), 0];
_dropveh setcaptive true;
_dropveh flyInHeight 150;

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
_dropveh flyinheight 150;
waitUntil {(_dropveh distance2D _droppos) < 100};

_smoker2 = createVehicle ["SmokeShellBlue", _smokepos, [],0,"NONE"];

if (_droptype isKindOf "Air") then
	{
		_eventualtype = _droptype;
		_droptype = "Land_Cargo20_military_green_F";
		airprizeawaitingassembly = true;
		publicVariable "airprizeawaitingassembly";
	}else
	{
		_eventualtype = "none";
	};
_cargo = createvehicle [_droptype, (_dropveh modelToWorld [0,-25,-10]), [],0, "FLY"];
_cargo setvariable ["eventualtype", _eventualtype, true];
//it need to be containerised because its an airvehicle
if (_droptype == forwardpointvehicleclassname) then
	{
	forward = _cargo;
	_cargo addEventHandler ["GetOut", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetout.sqf"}];
	_cargo addEventHandler ["GetIn", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetin.sqf"}];
	_cargo addEventHandler ["SeatSwitched", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetseatchanged.sqf"}];
	_cargo addEventHandler ["Engine", {_nul = [_this select 0, _this select 1] execVM "server\functions\fn_handlefobengine.sqf"}];

	[forward,"[[[[""MineDetector"",""launch_O_Titan_F"",""launch_B_Titan_short_tna_F""],[1,3,3]],[[""30Rnd_65x39_caseless_mag"",""1Rnd_HE_Grenade_shell"",""SmokeShellBlue"",""3Rnd_HE_Grenade_shell"",""30Rnd_65x39_caseless_mag_Tracer"",""Laserbatteries"",""SatchelCharge_Remote_Mag"",""Titan_AP"",""Titan_AT""],[16,10,5,20,20,6,15,15,15]],[[""FirstAidKit"",""ItemMap"",""Medikit""],[20,1,5]],[[],[]]],false]"] call BIS_fnc_initAmmoBox;

	// ^^^ same as put in the sqm, don't forget to change both when changing this!!!
	[_cargo, "forward"] call fnc_setVehicleName;

	};
if (_droptype == fobvehicleclassname) then //it's a fob vehicle
	{
	_cargo addEventHandler ["GetOut", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetout.sqf"}];
	_cargo addEventHandler ["GetIn", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetin.sqf"}];
	_cargo addEventHandler ["SeatSwitched", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetseatchanged.sqf"}];
	_cargo addEventHandler ["Engine", {_nul = [_this select 0, _this select 1] execVM "server\functions\fn_handlefobengine.sqf"}];
	fobveh = _cargo;
	[_cargo, "fobveh"] call fnc_setVehicleName;
	[fobveh, "[[[[],[]],[[""SatchelCharge_Remote_Mag""],[20]],[[""ToolKit""],[10]],[[],[]]],false]"] call BIS_fnc_initAmmoBox; // same as put in the sqm, don't forget to change both when changing this!!!
	};
if (_cargo iskindof "Cargo_Base_F") then //
	{
	mycontainer = _cargo;
	};
while {(getPosATL _cargo select 2) > 100} do {sleep 0.1};
_cargopos = getpos _cargo;
_para = createVehicle ["B_Parachute_02_F", _cargopos, [],0, "NONE"];
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
waitUntil {(getposatl _cargo select 2) < 2};
detach _cargo;
detach _para;
deleteVehicle _smoker1;
deleteVehicle _smoker2;
_underground = _droppos;
_underground set [2, -2];
_para setpos _underground;
_cargo allowdamage true;
if (_droptype == forwardpointvehicleclassname) then {forwardrespawnpositionid = [west,"forwardmarker", "Forward Vehicle"] call bis_fnc_addRespawnPosition;};
if (_eventualtype isKindOf "Air") then
	{
		prizebox = _cargo;
		[_cargo, "prizebox"] call fnc_setVehicleName;
	};
sleep 2;
_cargo setvectorup (surfaceNormal (getpos _cargo));
_dropveh domove _startpos;
_movingtowardsend = true;
while {_movingtowardsend} do
	{
	sleep 2;
	_1pos = getpos _dropveh;
	sleep 0.2;
	_2pos = getpos _dropveh;
	if ((_startpos distance2d _1pos) < (_startpos distance2D _2pos)) then {_movingtowardsend = false};
	};
deletemarker _mkrnumber;
{_dropveh deleteVehicleCrew _x} foreach (crew _dropveh);
deleteVehicle _dropveh;
diag_log format ["*** %1 ends %2,%3, iteration %4", _myscript, diag_tickTime, time, _thisaidropiteration];