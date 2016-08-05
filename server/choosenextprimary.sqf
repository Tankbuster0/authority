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
sleep 0.1;
if (testmode) then {diag_log format ["***@12 cnp has %1 logics to choose from", count _nearlogics]};
{
	_tstatus = _x getVariable ["targetstatus", -1];
	_ttype = _x getVariable ["targettype", -1];
	_tname = _x getVariable ["targetname", "Springfield"];
	_dir = _pos getdir _x;
	_dist = _pos distance _x;
	if (
		    (isNil "_tstatus") or
		    (_tstatus != 1) or
		    (((_mbi == 0) and (_ttype == 3) )) or
		    ((_pos distance _x) < _nvc)
		) then
		     	{
		     	if ((surfaceIsWater (_beachheadpos getPos [(_dist * .25), _dir])) or (surfaceiswater (_beachheadpos getPos [(_dist * .50), _dir])) or (surfaceiswater (_beachheadpos getPos [(_dist * .75), _dir]))) then
		     		{
		     		_removearray2 pushback _x;// make an array of all applicable targets that are in range, regardless on which island they are on
		     		}
		     		else
		     		{
		     		_removearray1 pushback _x;// make an array of all applicable targets that are in range AND on the same island
		     		};
		     };


} forEach _nearlogics;
_nearlogics2 = _nearlogics - _removearray2;
if (count _nearlogics2 < 2) then
	{
	_nearlogics2 = _nearlogics - _removearray1;
	if (testmode) then {diag_log "*** cnp found too few potential targets on the same island as primary, so is allowing overseas targets to be chosen too";};
	};
// if removal of all non allowed targets (including those overseas) results in a choice of less than 2 targets, then leave the overseas ones in the results.
sleep 0.1;
if (testmode) then {diag_log format ["***cnp @31 has %1 after rejections", count _nearlogics2];};
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

_nearlogics2 = _nearlogics2 apply {[_x distance _pos, _x]};
_nearlogics2 sort true;
_nearlogics2 = _nearlogics2 apply {_x select 1};
sleep 0.1;
if (testmode) then
	{
		diag_log "***cnp@ 56 has sorted";
		{diag_log format ["*** cnp:  %1 is %2m from pos", (_x getVariable "targetname"), (floor (_x distance _pos))   ] } foreach _nearlogics2;
	};
_nearlogics2 resize 2;
nextpt = selectRandom _nearlogics2;
sleep 0.1;
if (testmode) then {diag_log format ["***cnp chooses %1", nextpt getVariable "targetname"]};
diag_log format ["*** %1 ends %2, %3", _myscript, diag_tickTime, time];
nextpt