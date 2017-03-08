// by tankbuster
// takes a position and returns a logic
_myscript = "choosenextprimary.sqf";
private ["_pos","_allpossibletargets","_mbi","_nvc","_notlegittargets","_overseastargets","_logics","_tstatus","_ttype","_tname","_dir","_dist","_onislandtargets","_finaltargetlist","_sortedtargetlist"];
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
_pos = _this select 0;// position of the old target
_allpossibletargets = [];
_mbi = ["militarybasesincluded", 1] call BIS_fnc_getParamValue;
_nvc = ["notveryclose",500] call BIS_fnc_getParamValue;
_notlegittargets = []; _overseastargets = [];
_logics = entities "Logic";
sleep 0.1;
//count how many remaining targets on this island

_btargetsonthisisland = 0; _rtargetsonthisisland = 0;_alltargetsonthisisland = 0;

{
	if (_x getVariable "targetlandmassid" isEqualTo cpt_island) then
		{
			_thisstatus = (_x getVariable ["targetstatus", -1] );
			if (_thisstatus isEqualTo 1) then {_rtargetsonthisisland = _rtargetsonthisisland + 1};
			if (_thisstatus isEqualTo 2) then {_btargetsonthisisland = _btargetsonthisisland + 1};
			_alltargetsonthisisland = _alltargetsonthisisland + 1;
		}
} forEach _logics;
diag_log format ["***cnp says %1 targets on this island, of which %2 are friendly and %3 are enemy", _alltargetsonthisisland, _btargetsonthisisland, _rtargetsonthisisland];

if (testmode) then {diag_log format ["***@12 cnp has %1 logics to choose from", count _logics]};
{
	_tstatus = _x getVariable ["targetstatus", -1];
	_ttype = _x getVariable ["targettype", -1];
	_tname = _x getVariable ["targetname", "Springfield"];
	_dir = _pos getdir _x;
	_dist = _pos distance2d _x;
	if (
		    (isNil "_tstatus") or
		    (_tstatus != 1) or
		    ((_mbi == 0) and (_ttype == 3) ) or
		    ((_pos distance2D _x) < _nvc)
		) then
				{_notlegittargets pushback _x;};
} forEach _logics;
_allpossibletargets = _logics - _notlegittargets;


if (testmode) then {diag_log format ["***@29 cnp removed %1 from the list because they are not legit targets", count _notlegittargets]};
{
	_dist = _pos distance2d _x;
	_dir = _pos getdir _x;
	if ((surfaceIsWater (_pos getPos [(_dist * .25), _dir])) or (surfaceiswater (_pos getPos [(_dist * .50), _dir])) or (surfaceiswater (_pos getPos [(_dist * .75), _dir]))) then // this target is overseas
		{
		_overseastargets pushback _x;
		if (testmode) then
			{
			diag_log format ["*** cnp says %1 is overseas", (_x getVariable ["targetname", "default"]) ];
			};
		};

} foreach _allpossibletargets;

if (testmode) then {diag_log format ["***cnp says of the %1 possible targets, %2 of them are overseas", count _allpossibletargets, count _overseastargets ];};
_onislandtargets = _allpossibletargets - _overseastargets; // potential targets minus the overseas ones

if (count _onislandtargets > 1) then // if the relevant targets, minus overseas ones leaves less than 2 targets, allow overseas one in the final array
	{
	if (testmode) then {diag_log format ["*** cnp says there are %1 possbile targets, dont need to look overseas ", count _onislandtargets];};
	_finaltargetlist = _onislandtargets;
	}
	else
	{
	_finaltargetlist = _allpossibletargets;
	if (testmode) then {diag_log format ["*** cnp says there's only %1 possible targets, so including overseas ones too, making a total of %2", count _onislandtargets,  count _allpossibletargets];};
	};

// if removal of all non allowed targets (including those overseas) results in a choice of less than 2 targets, then leave the overseas ones in the results.
sleep 0.1;
/*
_allpossibletargets = _allpossibletargets apply {[_x distance _pos, _x]};
_allpossibletargets sort true;
_allpossibletargets = _allpossibletargets apply {_x select 1};
*/
if ((count _finaltargetlist) > 1) then
	{_sortedtargetlist = [_finaltargetlist, [] , {_x distanceSqr _pos}, "ASCEND"] call BIS_fnc_sortBy;}
	else
	{_sortedtargetlist = _finaltargetlist;};

sleep 0.1;
if (testmode) then
	{
		diag_log "***cnp@ 61 has sorted";
		{diag_log format ["*** cnp:  %1 is %2m from pos and %3 overseas", (_x getVariable "targetname"), (floor (_x distance2d _pos)), (if (_x in _overseastargets) then {"is"} else {"isnt"})  ] } foreach _sortedtargetlist;
	};
_sortedtargetlist resize 2;
nextpt = selectRandom _sortedtargetlist;
sleep 0.1;
if (testmode) then {diag_log format ["***cnp chooses %1 which is radius %2", (nextpt getVariable "targetname"), nextpt getVariable "targetradius"]};
diag_log format ["*** %1 ends %2, %3", _myscript, diag_tickTime, time];
nextpt