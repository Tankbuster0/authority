_myscript = "fobvehicledeploymanager.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_veh","_seat","_unit","_reason"];


params [
["_veh", ""],
["_seat", ""],
["_unit", ""]

];

diag_log format ["fvdm says you got in %1 seat", _seat];
while {true} do
	{
		if (_seat = driver) exitWith {_reason = "driver"};
		if !(_unit in _veh ) exitWith {_reason = "out"};
		sleep 0.1;
		if (_veh doorPhase "estend_shelter_source" > 0) then // player opening shelter
		{
		_candidatepos = (position _unit) isFlatEmpty [9,0,1,10,0,false, _unit];
		if (_candidatepos isEqualTo []) then
			{
			hint "Not enough space to make FOB here";
			_veh animateDoor ["extend_shelter_source",0,false];
			} else
			{
			_nul = [pos _veh] execVM "server/buildfob.sqf";
			};
		};
	};
if (_reason isEqualTo "out") exitWith {};

//ok, he's in as driver



diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
