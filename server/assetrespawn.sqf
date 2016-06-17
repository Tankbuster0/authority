//by tankbuster
_myscript = "assetrespawn.sqf";
// execvmd by the vehiclerespawn module or the mpkilled eh on the vehicles

if (not isServer) exitWith {[[_this select 0], "server\assetrespawn.sqf"] remoteexec ["execVM", 2]};
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_oldv","_newv","_respawns","_droppoint","_forget","_nul", "_typefpv", "_typefob", "_droppoint2"];
if (isServer) then {diag_log "***assetrespawn runs on the server!"};
if (isDedicated) then {diag_log "***assetrespawn runs on dedicated!"};
if (hasInterface) then {diag_log "***assetrespawn runs on client!"};

_oldv = _this select 0;
switch (_oldv) do
	{
	case forward: {_typefpv = true; _typefob = false;};
	case fobveh: {_typefpv = false; _typefob = true;};
	default {_typefpv = false; _typefob = false};
	};

if (_typefpv) then
	{
	forwardrespawning = true;
	publicVariable "forwardrespawning";
	forwardrespawnpositionid call bis_fnc_removeRespawnPosition;
	};
if (_typefob) then
	{
	fobrespawning = true;
	publicVariable "fobrespawning";
	if (fobdeployed) then
		{
		fobrespawnpositionid call bis_fnc_removeRespawnPosition;
		};//if the fob is deployed, remove its respawn id
	};
//diag_log format ["***assetrespawn says _typefpv %1 and _typefob %2", _typefpv, _typefob];
// find the nearest current respawn to the old position
_respawns = [west] call bis_fnc_getRespawnPositions;
//diag_log format ["*** found some respawns %1", _respawns];
_respawns2 = _respawns - [_oldv];
//diag_log format ["*** rspawns minus the old veh %1", _respawns2];
_droppoint2 = [0,0,0];
_testradius = 10;
_nearestblueflag = getpos ((nearestObjects [_oldv, ["Flag_Blue_F"], 7000]) select 0); // get the nearest blue flag position. there's 1 at the beach and another at each taken target.
while {_droppoint2 in [[0,0,0], islandcentre] } do
	{
	_droppoint2 = [_nearestblueflag, 6, _testradius, 6, 0, 0, 0] call BIS_fnc_findSafePos;
	_testradius = _testradius + 10;
	};
// ^^^ system that gets a good droppos without the possibility of findsafepos returning islandcentre (which is does when it fails)
sleep 1;
switch (true) do
	{
	case _typefpv:
		{
		_nul = [_droppoint2, blufordropaircraft, forwardpointvehicleclassname ] execVM "server\spawnairdrop.sqf";
		diag_log "***ar calls a fpv";

		forwardrespawning = false;
		publicVariable "forwardrespawning";
		};
	case _typefob:
		{
		_nul = [_droppoint2, blufordropaircraft, fobvehicleclassname ] execVM "server\spawnairdrop.sqf";
		diag_log "***ar calls a fob";
		fobrespawning = true;
		publicVariable "fobrespawning";
		};
	default {diag_log "***default"};
	};
sleep 8;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
