//by tankbuster
//execvmd by assaultphasefinished
_myscript = "reinforcementsattack";
private ["_myscript","_mygroup","_mypos","_mytarget","_attackpos"];
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

params [_mygroup, _mypos, _mytarget];
diag_log format ["reinforcementsattack gets group %1, pos %2 target %3 ", _mygroup, _mypos, _mytarget];
if ((playersNumber west) > 0) then
	{
	_targettobeattacked = selectRandom ((position (leader _mygroup)) nearEntities ["CUP_Creatures_Military_BAF_Soldier_Base", 500]);
	_mygroup reveal [_targettobeattacked,2];
	[_mygroup, position _targettobeattacked] call BIS_fnc_taskAttack;


	} else
	{
	_mygroup reveal [forward, 2];
	[_mygroup, position forward] call BIS_fnc_taskAttack;
	};












diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
