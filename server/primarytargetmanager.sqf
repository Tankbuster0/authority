#define filename "primarytargetmanager.sqf"
_thisscript = "primarytargetmanager.sqf";
//by tankbuster
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
private ["_currentprimarytarget","_pt_pos","_grp","_thisscript"];
_currentprimarytarget = _this select 0;
diag_log format ["***Primary Target starts text %1, actual %2, typename %3", text _currentprimarytarget, _currentprimarytarget, typeName _currentprimarytarget];
_pt_pos = locationPosition _currentprimarytarget;
for "_count" from 1 to 3 do
	{
	_grpname = format ["grp%1", _count];
	_grpname = createGroup east;

	_mypos = [_pt_pos, 5, 100, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
	nul = [_grpname, _pt_pos, 800] call BIS_fnc_taskpatrol;
	sleep 1;
	_mypos = [_pt_pos, 5, 100, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armoured" >> "OIA_MechInfSquad")] call BIS_fnc_spawnGroup;
	_mypos = [_pt_pos, 5, 100, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_AT")] call BIS_fnc_spawnGroup;
	nul = [_grpname, _pt_pos, 800] call BIS_fnc_taskpatrol;

	sleep 1;
	_mypos = [_pt_pos, 5, 100, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armored" >> "OIA_TankPlatoon")] call BIS_fnc_spawnGroup;
	sleep 1;
	};
diag_log str _pt_pos;
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];