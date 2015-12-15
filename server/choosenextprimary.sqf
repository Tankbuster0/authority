#define filename "choosenextprimary"
_thisscript = "choosenextprimary.sqf";
// by tankbuster
// takes a position and returns a logic
private ["_thisscript", "_pos", "_nearlogics", "_tstatus", "_ttype", "_removeflag", "_nearlogics2"];
diag_log format ["*** %1 starts %2, %3", _thisscript, diag_tickTime, time];
_pos = _this select 0; _nearlogics2 = [];
diag_log format ["choosenextprimary recieves %1", _pos];
if (isNil "militarybasesincluded") then {
	militarybasesincluded = 1;
	sleep 1;
	publicVariable "militarybasesincluded";
};
_nearlogics = nearestObjects [_pos, ["Logic"], 3000];
	diag_log format ["*** choosenext @1 nearlogics %1", _nearlogics];
{
	_tstatus = _x getVariable "targetstatus";
	_ttype = _x getVariable "targettype";
	diag_log format ["logic %1, pos %2, status %3, type %4", _x, position _x, _tstatus, _ttype];
	_removeflag = false;
	if (_tstatus < 2) then {
		_removeflag = true;
	};
	if (militarybasesincluded == 0) then {
		if (_ttype isEqualTo 3) then {
			_removeflag = true;
		};
	};
	/*if (_removeflag) then {
		_nearlogics = _nearlogics - [_x];
	}; */
		if !(_removeflag) then { _nearlogics2 pushback _x};
} forEach _nearlogics;
	diag_log format ["*** choosenext @34 nearlogics %1", _nearlogics];
	diag_log format ["*** choosenext @35 nearlogics2 %1", _nearlogics2];
_nearlogics = _nearlogics select [0, 2];
nextpt = ([_nearlogics2] call BIS_fnc_selectRandom) select 0; // note: replace with selectRandom command after the nexus update

diag_log format ["*** choosenextprimary @ 39 Next primary chosen is %1, pos is ", nextpt, getpos nextpt];
//diag_log format ["*** choosenextrpimary @35 next primary position is %1", getpos nextpt];
diag_log format ["*** %1 ends %2, %3", _thisscript, diag_tickTime, time];
nextpt
