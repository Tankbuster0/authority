//by tankbuster
_myscript = "forwardrespawned.sqf";
// execvmd by the vehiclerespawn module
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_oldv","_newv","_respawns","_droppoint","_forget","_nul"];
sleep 1;
_oldv = _this select 0;
_newv = _this select 1;
diag_log format ["***oldv was %1 at %2. newv is %3 at %4", _oldv, (getpos _oldv), _newv, (getpos _newv)];
// find the nearest current respawn to the old position
_respawns = [west] call bis_fnc_getRespawnPositions;
diag_log format ["*** found some respawns %1", _respawns];
_respawns2 = _respawns - [_oldv];
diag_log format ["*** rspawns minus the old forward %1", _respawns2];

_droppoint = [_respawns2, _oldv] call BIS_fnc_nearestPosition; //find the one nearest to the old forward

if ((typeName _droppoint) != "ARRAY") then {_droppoint = (getpos _droppoint)};
diag_log format ["**** forwardrespawn is calling a drop at %1", _droppoint];
sleep 1;
_nul = [_droppoint, "RHS_C130J", forwardpointvehicle ] execVM "server\spawnairdrop.sqf";
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

//1921 20:56:49 "***mando chute gets man 9943eb00# 1781138: m1083a1p2_shelter_d.p3d, targetpos [9366.56,22486.5,0], rad 0, _bla blah, chuto 87ad10c0# 1781135: parachute_02_f.p3d, isammo false"
//1224 20:53:47 "***mando chute gets man 99464100# 1780718: m113a3_wd_medical.p3d, targetpos [9384.21,22491.3,0], rad 0, _bla blah, chuto 99473040# 1780715: parachute_02_f.p3d, isammo false"