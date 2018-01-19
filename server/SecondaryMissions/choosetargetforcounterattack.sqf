//choosetargetforcounterattack.sqf
//by tankbuster
 #include "..\includes.sqf"
_myscript = "choosetargetforcounterattach";
__tky_starts
private _gl = _this select 0,
private ["_atobj","_tgts","_tgts_sorted","_atpos","_atrad","_atrposs"];


switch (floor random 4) do
	{
		case 0: {
					_atobj = forward;
					diag_log format ["***ctfca tells %1 to attack forward at %2", _gl, getpos forward];
				};
		case 1: {
					_atobj = fobveh;
					diag_log format ["***ctfca tells %1 to attack fob at %2", _gl, getpos fobveh];
				};
		case 2: {
					_tgts = (allplayers select {alive _x});
					_tgts_sorted = [_tgts, [], {_gl distance2d _x}, "ASCEND" ] call BIS_fnc_sortBy;
					_atobj = _tgts_sorted select 0;
					diag_log format ["***ctfca tells %1 to attack %3 at %2", _gl, getpos _atobj, _atobj];
				};
		case 3: {
					_atobj = pt_hq;
					diag_log format ["***ctfca tells %1 to patrol", _gl, getpos fobveh];
				};
	};
_gl reveal [_atobj, 4];
_atpos = getpos _atobj;
_atrad = 4;
_atrposs = _atpos nearRoads 4;
while {(count _atrposs) < 1} do
	{// find nearest rp to target. makes for less confused ca vecs
		_atrad = _atrad * 2;
		_atrposs = _atpos nearRoads _atrad;
	};
_atpos = _atrposs select 0;
[group _gl, getpos _atpos, (_atpos distance2d _atobj)] call BIS_fnc_taskPatrol;
diag_log format ["*** ctfca tells %1 to patrol around %2", _gl, _atobj, _];
__tky_ends