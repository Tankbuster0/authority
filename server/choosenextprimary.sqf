// by tankbuster
// takes a position and returns a logic
_myscript = "choosenextprimary.sqf";
private ["_pos", "_nearlogics", "_tstatus", "_ttype","_tname", "_removeflag", "_nearlogics2", "_removearray", "_mbi", "_nvc"];
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
_pos = _this select 0; _nearlogics2 = [];

_mbi = ["militarybasesincluded", 1] call BIS_fnc_getParamValue;
_nvc = ["notveryclose",500] call BIS_fnc_getParamValue;
_removearray = [];
_nearlogics = _pos nearEntities ["Logic", 6000];

{
	_tstatus = _x getVariable ["targetstatus", -1];
	_ttype = _x getVariable ["targettype", -1];
	_tname = _x getVariable ["targetname", "Springfield"];
	_dir = _pos direction _x;
	_dist = _pos distance _x;
	if (
		    (isNil "_tstatus") or
		    (_tstatus != 1) or
		    (((_mbi == 0) and (_ttype == 3) )) or
		    ((_pos distance _x) < _nvc) or
			((surfaceIsWater (_pos getrelPos [(_dist * .33), _dir])) and (surfaceiswater (_pos getrelPos [(_dist * .66), _dir])))
		)
		then {_removearray pushback _x};
} forEach _nearlogics;
_nearlogics2 = _nearlogics - _removearray;

/*
pseudo code!
if ((tolower worldName) isEqualTo "tanoa") then // allow island hopping for some target progressions
// the hard code below is to find the logic for the town we want to force into the _nearlogic2 array
	{
		if (primarytargetname isEqualTo "Katoula") then
			{add namuvaka logic to the _nearlogics2 array};
		if (primarytargetname isEqualTo "Rautake") then
			{add katkoula logic to _nearlogics2 array};
		if (primarytargetname isEqualTo "Harcourt") then
			{add kotomo logic to the _nearlogics2 array};
		if (primarytargetname isEqualTo "kotomo") then
			{add harcourt logic to the _nearlogics2 array};
	};
// above additions to the nearlogics2 array dont need to be distance sorted as that's done below
*/

{
	_nearlogics2 set [_ForEachIndex, [ _x distance _pos, _x]];
} foreach _nearlogics2;
_nearlogics2 resize 2;
_nextpt1 = selectRandom _nearlogics2;
_nextpt = _nextpt1 select 1;
nextpt = _nextpt;
diag_log format ["*** %1 ends %2, %3", _myscript, diag_tickTime, time];
nextpt