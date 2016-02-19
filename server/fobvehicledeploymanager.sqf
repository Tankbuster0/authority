_myscript = "fobvehicledeploymanager.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_veh","_seat","_unit","_reason","_doorphase1","_candidatepos","_nul"];

params [
["_veh", ""],
["_seat", ""],
["_unit", ""]
];
while {true} do
	{
		if (_unit isequalto (driver _veh)) exitWith {_reason = "driver"};
		if !(_unit in _veh ) exitWith {_reason = "out"};
		sleep 0.1;
	};
if (_reason isEqualTo "out") exitWith {};
while {(alive _veh) and (!(isnull (driver _veh)))} do
	{
	sleep 0.1;
	_doorphase1 = (_veh doorPhase "extend_shelter_source");
	if (_doorphase1 > 0) then // shelter not closed, is it opening?
		{
		sleep 0.1;
		if(_veh doorPhase "extend_shelter_source"  > _doorphase1) then
			{// door opening
			_candidatepos = (position _unit) isFlatEmpty [9,0,1,10,0,false, _unit];
			if (_candidatepos isEqualTo []) then
				{
				//hint "Not enough space to make FOB here";
				[[[driver _veh], "Not enough space to build FOB here"],"tky_super_hint", true,false] call BIS_fnc_MP;
				//_veh animateDoor ["extend_shelter_source",0,false];
				[_veh, 0,true] call RHS_fnc_fmtv_deploy;
				sleep 4;
				//dropveh setfuel 1;

				} else
				{
				//hint "Deploying FOB";
				[[[driver _veh], "Deploying FOB"],"tky_super_hint", true,false] call BIS_fnc_MP;
				while {(_veh doorPhase "extend_shelter_source") < 1} do {sleep 0.1;};
				_nul = [position _veh, direction _veh] execVM "server\buildfob.sqf";
				fobrespawn = [missionNamespace,_veh] call BIS_fnc_addRespawnPosition;
				sleep 5;
				};
			};
		};
	if (_doorphase1 < 1) then // shelter not open, is it closing?
		{
		sleep 0.1;
		if (_veh doorPhase "extend_shelter_source" < _doorphase1) then
			{//door closing
			if (!(isNil "fobjects")) then
				{
				//hint "Removing FOB";
				[[[driver _veh], "Removing FOB"],"tky_super_hint", true,false] call BIS_fnc_MP;
				while {(_veh doorPhase "extend_shelter_source") > 0} do {sleep 0.1;};
				{deleteVehicle _x} foreach fobjects;
				fobdeployed = false;
				fobrespawn call BIS_fnc_removeRespawnPosition;
				publicVariable "fobdeployed";
				sleep 5;
				};
			};
		};
	};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
