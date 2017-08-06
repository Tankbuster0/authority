scriptName "fn_medicHealing";

/*
	Code written by Haz
*/

#define __FILENAME "fn_medicHealing.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

waitUntil {(!isNull player)};
waitUntil {(player == player)};

private _medic = player;
private _playerDamage = 0;
private _healReward = 1;
private _medicReward = 3;

if ((!(typeOf _medic in ["B_medic_F", "O_medic_F", "I_medic_F"]))) exitWith {};

while {(true)} do
{
	while {(alive _medic)} do
	{
		if ((animationState _medic == "")) exitWith
		{
			_playerDamage = getDammage _medic;
		};
		sleep 0.15;
	};
	while {(alive _medic)} do
	{
		if ((animationState _medic == "")) exitWith
		{
			if ((_playerDamage == (getDammage _medic))) then
			{
				_medic addScore _healReward + _medicReward;
			};
		};
		sleep 0.15;
	};
	sleep 0.15;
};