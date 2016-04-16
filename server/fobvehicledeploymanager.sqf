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
		sleep 0.2;
	};
if (_reason isEqualTo "out") exitWith {};

while {(alive _veh) and (!(isnull (driver _veh)))} do
	{
	sleep 0.2;

	// Experimental FOB§ building
	//unassignCurator cur;
	if (fobdeployed) then
		{
		if (getAssignedCuratorUnit cur != (driver _veh)) then
			{
			(driver _veh) assignCurator cur;
			};
		};
	//--


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
				_veh animateDoor ["extend_shelter_source",0,false];
				[_veh,1] remoteexec ["tky_fnc_setfuel"];
				sleep 4;
				} else
				{
				//hint "Deploying FOB";
				[[[driver _veh], "Deploying FOB"],"tky_super_hint", true,false] call BIS_fnc_MP;
				while {(_veh doorPhase "extend_shelter_source") < 1} do {sleep 0.1;};
				_nul = [position _veh, direction _veh] execVM "server\buildfob.sqf";
				sleep 0.5;
				fobbox setpos (position fobboxlocator);

				// Make editing area for curator
				[] remoteExec ["tky_fnc_resetCuratorBuildlist"];
				cur addCuratorEditingArea [1,(position _veh),50];
				cur addCuratorCameraArea [1,(position _veh),50];

				// Hint press button to get in zeus mode
				"Press Zeus Button (Default Y) to open buildmode when deployed." remoteExec ["hint", _veh];

				fobrespawnpositionid = [west,"fobmarker", "FOB"] call BIS_fnc_addRespawnPosition;
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
				fobrespawnpositionid call BIS_fnc_removeRespawnPosition;
				publicVariable "fobdeployed";

				// Remove Editing Area and curator owner
				cur removeCuratorEditingArea 1;
				cur removeCuratorCameraArea  1;

				_cobj = curatorEditableObjects cur;
				{ deleteVehicle _x;} forEach _cobj;
				fobbox setpos (getpos fobboxsecretlocation);
				[[(position _veh select 0),(position _veh select 1),8],(position _veh),2] call BIS_fnc_setCuratorCamera;
				unassignCurator cur;

				sleep 5;
				};
			};
		};
	};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
