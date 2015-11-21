#define filename "choosenextprimarytarget"
_thisscript = "choosenextprimarytarget.sqf";
//by tankbuster
private ["_thisscript","_pos","_nearlogics","_tstatus","_ttype","_removeflag"];
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
_pos = _this select 0;
_nearlogics = nearestObjects [_pos, ["Logic"], 4000];
{
	_tstatus = _x getVariable "targetstatus"; _ttype = _x getVariable "targettype"; _removeflag = false;
	if (_tstatus < 2) then {_removeflag = true;};
	if !(militarybasesencluded) then {if (_ttype isEqualTo 3 ) then {_removeflag = true;};};
	if (_removeflag) then
		{
		_nearlogics = _nearlogics - _x;
		};_
}forEach _nearlogics;
_nearlogics = _nearlogics select [0,2];
_nextpt = _nearlogics call bis_fnc_selectRandom;// note replace with selectrandom command after nexus update
diag_log format ["Next primary chosen is %1 at %2", _nextpt, getpos _nearlogics];
_nextpt
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];
