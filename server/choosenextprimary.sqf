// by tankbuster
// takes a position and returns a logic
_myscript = "choosenextprimary.sqf";
private ["_myscript","_pos","_allpossibletargets","_mbi","_nvc","_notlegittargets","_overseastargets","_nearlogics","_tstatus","_ttype","_tname","_dir","_dist","_onislandtargets","_count","_finaltargetlist","_diag_log","_sortedtargetlist"];
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
_pos = _this select 0; _allpossibletargets = [];
_mbi = ["militarybasesincluded", 1] call BIS_fnc_getParamValue;
_nvc = ["notveryclose",500] call BIS_fnc_getParamValue;
_notlegittargets = []; _overseastargets = [];
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
		    (isNil "_tstatus") or //some other type of logic
		    (_tstatus != 1) or // already enemy held
		    (((_mbi == 0) and (_ttype == 3) )) or // a mil base and choosing them is off
		    ((_pos distance _x) < _nvc) //it's too close
		) then
				{_notlegittargets pushback _x;};

} forEach _nearlogics;
_allpossibletargets = _nearlogics - _notlegittargets;

{
if ((surfaceIsWater (_pos getPos [(_dist * .25), _dir])) or (surfaceiswater (_pos getPos [(_dist * .50), _dir])) or (surfaceiswater (_pos getPos [(_dist * .75), _dir]))) then // this target is overseas
	{_overseastargets pushback _x;};
} foreach _allpossibletargets;

if (testmode) then {diag_log format ["***cnp says of the %1 possible targets, %2 of them are overseas", count _allpossibletargets, count _overseastargets ];};
_onislandtargets = _allpossibletargets - _overseastargets; // potential targets minus the overseas ones

if (count _onislandtargets > 1) then // if the relevant targets, minus overseas ones leaves less than 2 targets, allow overseas one in the final array
	{
	if (testmode) then {diag_log format ["*** cnp says there are %1 possbile targets, dont need to look overseas ", _count _onislandtargets];};
	_finaltargetlist = _onislandtargets;
	}
	else
	{
	_finaltargetlist = _allpossibletargets;
	if (testmode) then {diag_log format ["*** cnp says there's only %1 possible targets, so including overseas ones too, making a total of %2", count _onislandtargets, _allpossibletargets];};
	};

// if removal of all non allowed targets (including those overseas) results in a choice of less than 2 targets, then leave the overseas ones in the results.
sleep 0.1;
/*
_allpossibletargets = _allpossibletargets apply {[_x distance _pos, _x]};
_allpossibletargets sort true;
_allpossibletargets = _allpossibletargets apply {_x select 1};
*/
_sortedtargetlist = [_finaltargetlist, [] , {_x distanceSqr _pos}, "ASCEND"] call BIS_fnc_sortBy;

sleep 0.1;
if (testmode) then
	{
		diag_log "***cnp@ 56 has sorted";
		{diag_log format ["*** cnp:  %1 is %2m from pos and %3 overseas", (_x getVariable "targetname"), (floor (_x distance _pos)), (if (_x in _overseastargets then {"is"} else {"isnt"})  ] } foreach _sortedtargetlist;
	};
_sortedtargetlist resize 2;
nextpt = selectRandom _sortedtargetlist;
sleep 0.1;
if (testmode) then {diag_log format ["***cnp chooses %1", nextpt getVariable "targetname"]};
diag_log format ["*** %1 ends %2, %3", _myscript, diag_tickTime, time];
nextpt