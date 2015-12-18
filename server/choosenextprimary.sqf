// by tankbuster
// takes a position and returns a logic
_myscript = "choosenextprimary.sqf";
private ["_pos", "_nearlogics", "_tstatus", "_ttype","_tname", "_removeflag", "_nearlogics2", "_removearray"];
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
_pos = _this select 0; _nearlogics2 = [];
diag_log format ["choosenextprimary recieves %1", _pos];
if (isNil "militarybasesincluded") then {
	militarybasesincluded = 1;
	sleep 1;
	publicVariable "militarybasesincluded";
};
_removearray = []; _nearlogics = nearestObjects [_pos, ["Logic"], 4000];
	diag_log format ["*** choosenext @14 nearlogics %1", _nearlogics];
{
	_tstatus = _x getVariable "targetstatus";
	_ttype = _x getVariable "targettype";
	_tname = _x getVariable "targetname";
	diag_log format ["logic %1, name %5, pos %2, status %3, type %4", _x, position _x, _tstatus, _ttype, _tname];
	if ( (isNil "_tstatus") or (_tstatus != 1) or (((militarybasesincluded == 0) and (_ttype == 3) ))) then {_removearray pushback _x};
} forEach _nearlogics;
_nearlogics2 = _nearlogics - _removearray;
	diag_log format ["*** choosenext @23 removearray %1",_removearray];
	diag_log format ["*** choosenext @34 nearlogics2 %1", _nearlogics2];
_nextpt1 = [_nearlogics2] call BIS_fnc_selectRandom; // note: replace with selectRandom command after the nexus update
nextpt = _nextpt1 select 0;
diag_log format ["*** choosenextprimary @27 Next primary chosen is %1, name %3, pos is %2 ", nextpt, getpos nextpt, (nextpt getVariable "targetname")];
diag_log format ["*** %1 ends %2, %3", _myscript, diag_tickTime, time];
nextpt
