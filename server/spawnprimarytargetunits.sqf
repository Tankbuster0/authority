#define filename "primarytargetmanager.sqf"
_thisscript = "primarytargetmanager.sqf";
//by tankbuster
private ["_currentprimarytarget","_pt_pos","_count","_grpname","_mypos","_mydir","_mypos2"];
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
	sleep 0.1;

	_mypos = [_pt_pos, 5, 100, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armoured" >> "OIA_MechInfSquad")] call BIS_fnc_spawnGroup;
	sleep 0.1;

	_mypos = [_pt_pos, 5, 100, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_AT")] call BIS_fnc_spawnGroup;
	nul = [_grpname, _pt_pos, 800] call BIS_fnc_taskpatrol;
	sleep 0.1;

	_mypos = [_pt_pos, 5, 100, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armored" >> "OIA_TankSection"), [],[],[],[],[],(random 360)] call BIS_fnc_spawnGroup;
	sleep 0.1;

	_mypos = [_pt_pos, 5, 30, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_support_Mort")] call BIS_fnc_spawnGroup;
	_mydir = [_pt_pos, _mypos]  call BIS_fnc_dirTo;
	_mypos2 = [_mypos, 2,4,0,0,30,0] call bis_fnc_findSafePos;
	[_mypos2, (_mydir + 180), "O_Mortar_01_F", _grpname] call bis_fnc_spawnVehicle;
	sleep 0.1;



	};
// make trigger that senses when town is empty of enemies
_trg = createTrigger ["EmptyDetector", _pt_pos];

diag_log str _pt_pos;
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];