// By Alex aka AlManiak
// Get window location from a certain position in building.

// Input: Building Position
// Output: [[Lookout direction, Quality of lookout], [L..,Q..]]

AM_fnc_checkInside = compile preprocessFile "Server\BuildingOccupation\isInsideBuilding.sqf";

params ["_buildPos"];
private ["_checkDist", "_samplePosASL", "_cansee", "_return" ,"_rDir"];

_samplePosASL = AGLToASL [_buildPos select 0, _buildPos select 1, (_buildPos select 2) + 1.5];
_checkDist = 5;
_cansee = false;
_return = [0,0];
for "_dir" from 1 to 360 step 45 do
{
	
	_counterPosASL =  [(_samplePosASL select 0) + sin _dir * _checkDist,(_samplePosASL select 1) + cos _dir * _checkDist,_samplePosASL select 2];
	if (! ([_counterPosASL] call AM_fnc_checkInside) ) then 
	{
		_cansee = [objNull, "FIRE"] checkVisibility [_samplePosASL, _counterPosASL];
		_rDir = [_samplePosASL,_counterPosASL] call BIS_fnc_dirTo;
		diag_log format ["***isWindowscript:  %1 - %2 - %3 - %4 - Dir %5",_buildPos, _samplePosASL, _counterPosASL, _cansee, _rDir];
		if (_cansee > 0) exitWith { _return = [_rDir, _cansee];};
	};
};
_return;


//_cansee = [objNull, "FIRE"] checkVisibility [eyePos player, eyePos unit1];