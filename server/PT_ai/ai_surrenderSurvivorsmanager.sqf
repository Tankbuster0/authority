//By Alex
//Script that iterates through all enemy units remaining in trigger area.
//There is a chance of 1 rebel in the surrendered group, that will at a random times break surrender and try to run at a weapon and fight.

if (!isServer) exitWith {};
_myscript = "ai_surrendersurvivorsmanager.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_trigPos","_thislist","_r","_hasRebel"];
_thislist = param [0];
_trigPos = param [1];

TrigList = _thislist;
_hasRebel = 0;
{
	if (side _x == east) then
	{

		// Handle Vehicles
		if (_x isKindOf "Man") then
		{
				// Rebel Pick
				if (_hasRebel < 3) then //Max 3 rebels
				{
					_r = selectRandom [true,false,false,false,false]; // 1/5 chance for a rebel.
					if (_r) then {_hasRebel = _hasRebel + 1;} else {};
				} else
				{
					_r = false;
				};
				[_x,_r,_trigPos] execVM "server\PT_ai\ai_surrendered.sqf";

		} else
		{
			_vehcrewlist = crew _x;
			{
				[_x] joinSilent grpNull;
				removeAllWeapons _x;
				sleep 1;
				unassignVehicle _x;

				// Rebel Pick
				if (_hasRebel < 3) then
				{
					_r = selectRandom [true,false];
					if (_r) then {_hasRebel = _hasRebel + 1;} else {};
				} else
				{
					_r = false;
				};
				[_x,_r,_trigPos] execVM "server\PT_ai\ai_surrendered.sqf";

			} forEach _vehcrewlist;
		};

	}
	else
	{

	};
} forEach _thislist;


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];