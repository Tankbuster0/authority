//by tankbuster
_myscript = "assetrespawn.sqf";
// execvmd by the vehiclerespawn module

if (not isServer) exitWith {};
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_oldv","_newv","_respawns","_droppoint","_forget","_nul", "_typefpv", "_typefob"];
_newv = _this select 0;
_oldv = _this select 1;
switch (_new) do
	{
	case forward: {_typefpv = true; _typefob = false;};
	case fobveh: {_typefpv = false; _typefob = true;};
	default {_typefpv = false; _typefob = false};
	};
if ((_typefpv) and (forwardrespawning)) exitWith {diag_log "***assetrespawn fpv duplication avoided!"};
if (_typefpv) then
	{
	forwardrespawning = true;
	publicVariable "forwardrespawning";
	};
if ((_typefob) and (fobrespawning)) exitWith {diag_log "***assetrespawn fob duplication avoided!"};
if (_typefob) then
	{
	fobrespawning = true;
	publicVariable "fobrespawning";
	};
diag_log format ["***assetrespawn says _typefpv %1 and _typefob %2", _typefpv, _typefob];
// find the nearest current respawn to the old position
_respawns = [west] call bis_fnc_getRespawnPositions;
//diag_log format ["*** found some respawns %1", _respawns];
_respawns2 = _respawns - [_newv];
//diag_log format ["*** rspawns minus the old veh %1", _respawns2];
_droppoint = [_respawns2, _newv] call BIS_fnc_nearestPosition; //find the one nearest to the old respawn pos
_myid = _respawns find _newv;
 if (_myid > -1) then {[west, _myid] call bis_fnc_removeRespawnPosition;};
if ((typeName _droppoint) != "ARRAY") then {_droppoint = (getpos _droppoint)};

diag_log format ["**** assetrespawn is calling a drop at %1", _droppoint];
sleep 1;
switch (true) do
	{
	case _typefpv:
		{
		_nul = [_droppoint, "RHS_C130J", forwardpointvehicleclassname ] execVM "server\spawnairdrop.sqf";
		diag_log "***ar calls a fpv";
		forwardrespawning = false;
		publicVariable "forwardrespawning";
		};
	case _typefob:
		{
		_nul = [_droppoint, "RHS_C130J", fobvehicleclassname ] execVM "server\spawnairdrop.sqf";
		diag_log "***ar calls a fob";
		fobrespawning = true;
		publicVariable "fobrespawning";
		};
	default {diag_log "***default"};
	};
sleep 8;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

