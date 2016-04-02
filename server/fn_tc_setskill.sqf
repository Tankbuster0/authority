// by Tankbuster

private ["_variation", "_dudes", "_skills", "_variationflag"];
/* Incoming params
0 = units. Can accept a group or a single unit object
1 = use missions gvar. if true, then use GVAR(skill_array), if an array is sent, use that in following order; AimingAccuracy, AimingShake, AimingSpeed, endurance, spotdistance, spottime, courage, reloadspeed, commanding, general
2 = variation, if false, then dont change skills. if true, add a default random -0.1 to aimingacc, -.5 to aimingshake, -0.5 to aimingspeed, -0.15 to courage. if sent an array (must be all 10 values), then use them)

so a typical call for this function would be [_myunit, true, true] call tky_fnc_tc_setskill; this would give _myunit the standard skills plus or minus the usual differences.
*/
_dudes = [_this, 0] call BIS_fnc_param;
_skills = [_this, 1, true] call BIS_fnc_param;
_variationflag = [_this, 2, true] call BIS_fnc_param;

if (typeName _dudes isEqualTo "OBJECT") then { _dudes = [_dudes]}; //script has been sent an unit, not a group, put the single unit into an array so we can iterate in the foreach, even though it's only once
if (typename _dudes isEqualTo "GROUP") then {_dudes = units _dudes};// script has been sent a group, make _dudes an array of its members
if (typeName _skills isEqualTo "BOOL") then { _skills = [0.12,0.08,0.50,0.30,0.58,0.35,0.38,0.45,1,0.3]};// this is 'superlow' from domi. code a better solution
{
	if (typeName _variationflag isEqualTo "BOOL") then
		{
			if (_variationflag) then
				{_variation = [(random -0.1),(random -0.05),(random -0.5),0,0,0,(random -0.15),0,0,0]} //default variance
				else
				{_variation = [0,0,0,0,0,0,0,0,0,0]};//no variance
		};
if (typeName _variationflag isEqualTo "ARRAY") then {_variation = _variationflag};//script should adjust skills as set in the incoming array.  (must give all 10)
// ^^^ redundant code. if variation is supplied as an array, just use it below. nothing else need be done to it.
		_x setSkill ["aimingAccuracy", ((_skills select 0) + (_variation select 0))];
		_x setSkill ["aimingShake", ((_skills select 1) + (_variation select 1))];
		_x setSkill ["aimingSpeed", ((_skills select 2) + (_variation select 2))];
		_x setSkill ["endurance", _skills select 3];
		_x setSkill ["spotDistance", _skills select 4];
		_x setSkill ["spotTime", _skills select 5];
		_x setSkill ["courage", ((_skills select 6) + (_variation select 6))];
		_x setSkill ["reloadSpeed", _skills select 7];
		_x setSkill ["commanding", _skills select 8];
		_x setSkill ["general", _skills select 9];
}forEach _dudes;