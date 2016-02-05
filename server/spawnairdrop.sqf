_myscript = "spawnairdrop.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_requestedpos","_airtype","_droptype","_droppos","_testradius"];
params [
["_requestedpos", (getpos ammobox)], // location where the cargo should land
["_airtype", "RHS_C130J"], // classname of delivering aircraft
["_droptype", "rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy"]]; // classname of delivered object
// find a good place to land the cargo
_droppos = [0,0,0]; _testradius = 2;
diag_log format ["*** airtype is empty string? %1" ,_airtype];
while {_droppos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_droppos = [_requestedpos, 0,_testradius, 4, 0,50,0] call bis_fnc_findSafePos;
		diag_log format ["*** spawnairdrop suggests %1 using radius %2 which is blacklisted %3", _droppos, _testradius, (_droppos in [[0,0,0], islandcentre])];
		_testradius = _testradius * 2;
	};
_mkr = createMarker ["dropmkr", (_droppos) ];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "hd_dot";

// create the drop veh;

_dropgroup = createGroup west;
_startpos = [_droppos, (5000 + random 5000), random 360] call bis_fnc_relPos;
_startpos set [2, 500];
_dir = [_startpos, _droppos] call bis_fnc_dirTo;

_veh = [_startpos, _dir, _airtype, _dropgroup] call bis_fnc_spawnVehicle;
_dropveh = _veh select 0
_dropveh setVelocity [150 * (sin _dir), 150 * (cos _dir), 0];
_dropveh setcaptive true;
_dwp = _dropgroup addWaypoint [_droppos, 0];
_dwp setWaypointBehaviour "CARELESS";
_dwp setWaypointSpeed "NORMAL";
_dwp setWaypointtype "MOVE";

waituntil {sleep 0.5; (_dropveh distance _droppos) < 1000 };
//_dropveh animateDoor something etc blah blah;



diag_log format ["*** spawnairdrop decides on %1", _droppos];
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];