//by tankbuster
_myscript = "assetrespawn.sqf";
// execvmd by the vehiclerespawn module
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_oldv","_newv","_respawns","_droppoint","_forget","_nul"];
_oldv = _this select 0;
_newv = _this select 1;
diag_log format ["***oldv was %1 at %2. newv is %3 at %4", _oldv, (getpos _oldv), _newv, (getpos _newv)];

// find the nearest current respawn to the old position
_respawns = [west] call bis_fnc_getRespawnPositions;
diag_log format ["*** found some respawns %1", _respawns];
_respawns2 = _respawns - [_oldv];
diag_log format ["*** rspawns minus the old veh %1", _respawns2];
_droppoint = [_respawns2, _oldv] call BIS_fnc_nearestPosition; //find the one nearest to the old respawn pos
_myid = _respawns find _oldv;
 if (_myid > -1) then {[west, _myid] call bis_fnc_removeRespawnPosition;};
if ((typeName _droppoint) != "ARRAY") then {_droppoint = (getpos _droppoint)};

diag_log format ["**** assetrespawn is calling a drop at %1", _droppoint];
sleep 1;
switch (_oldv) do
	{
	case forward: {_nul = [_droppoint, "RHS_C130J", forwardpointvehicle ] execVM "server\spawnairdrop.sqf"; diag_log "***ar calls a fpv"};
	case fobveh: {_nul = [_droppoint, "RHS_C130J", fobvehicle ] execVM "server\spawnairdrop.sqf"; diag_log "***ar calls a fob";};
	default {diag_log "***default"};
	};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

