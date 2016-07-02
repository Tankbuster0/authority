//by tankbuster
//execvmd by assaultphasefinished
_myscript = "reinforcementsattack";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_mydude","_mypos","_mytarget","_targettobeattacked"];

_mydude = _this select 0;
diag_log format ["reinforcementsattack gets %1 ", _this];
if ((playersNumber west) > 0) then
	{
	_targettobeattacked = selectRandom ((position _mydude) nearEntities ["CUP_Creatures_Military_BAF_Soldier_Base", 800]);
	(group _mydude) reveal [_targettobeattacked,2];
	[(group _mydude), position _targettobeattacked] call BIS_fnc_taskAttack;
	} else
	{
	(group _mydude) reveal [forward, 2];
	[(group _mydude), position forward] call BIS_fnc_taskAttack;
	};












diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
