//by tankbuster
//execvmd by assaultphasefinished
_myscript = "ai_reinforcementsattack";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_possibletargets","_radius","_mydude","_targettobeattacked", "_mydata4"];

_mydude = _this;;
diag_log format ["reinforcementsattack gets %1 ", _this];
diag_log format [" typeof %1, typename %2, pos %3 group %4 groupleader %5", typeOf _this, typename _this, position _this, group _this, leader group _this];
//_mydude = leader (group (_mydata select 0));
if ((playersNumber west) > 0) then

	{
	_possibletargets = [];
	_radius = 1000;
	while {_possibletargets isEqualTo []} do
		{
		_possibletargets =  (position _mydude) nearEntities ["SoldierWB", _radius];
		_radius = _radius + 1000;
		};
	_possibletargets = _possibletargets apply { [_x distance _mydude, _x] } ;
	_possibletargets sort true;
	_mydata4 = _possibletargets select 0;
	_targettobeattacked = _mydata4 select 1;


	(group _mydude) reveal [_targettobeattacked,2];
	[(group _mydude), position _targettobeattacked] call BIS_fnc_taskAttack;
	} else
	{
	(group _mydude) reveal [forward, 2];
	[(group _mydude), position forward] call BIS_fnc_taskAttack;
	};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
