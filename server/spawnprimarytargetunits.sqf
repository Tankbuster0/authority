#define filename "spawnprimarytargetunits.sqf"
//by tankbuster
_myscript = "spawnprimarytargetunits.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_currentprimarytarget","_pt_pos","_count","_grpname","_mypos","_mydir","_mypos2"];
_currentprimarytarget = _this select 0;// recieves a logic or object
//diag_log format ["***doprimary.sqf @ 7 Primary units spawn actual %1, typename %2", _currentprimarytarget, typeName _currentprimarytarget];
_loc_pos = getpos _currentprimarytarget;
_mylogic = (_loc_pos nearEntities ["Logic", 500]) select 0;
_pt_pos = getpos _mylogic;
_pt_radius = (_mylogic getVariable "targetradius") - 50;
//diag_log format ["*** spawnprimaryunits @12 locpos %1 mylogic %2, ptpos %3, ptradius %4", _loc_pos, _mylogic, _pt_pos, _pt_radius];
for "_count" from 1 to 3 do
	{
	_grpname = format ["grp%1", _count];
	_grpname = createGroup east;

	_mypos = [_pt_pos, 5, _pt_radius, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
	nul = [_grpname, _pt_pos, _pt_radius] call BIS_fnc_taskpatrol;
	sleep 0.1;

	_mypos = [_pt_pos, 5, _pt_radius, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armoured" >> "OIA_MechInfSquad")] call BIS_fnc_spawnGroup;
	sleep 0.1;

	_mypos = [_pt_pos, 5, _pt_radius, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Motorized_MTP" >> "OIA_MotInf_AT")] call BIS_fnc_spawnGroup;
	nul = [_grpname, _pt_pos, _pt_radius] call BIS_fnc_taskpatrol;
	sleep 0.1;

	_mypos = [_pt_pos, 5, _pt_radius, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Armored" >> "OIA_TankSection"), [],[],[],[],[],(random 360)] call BIS_fnc_spawnGroup;
	sleep 0.1;

	_mypos = [_pt_pos, 5, _pt_radius, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_support_Mort")] call BIS_fnc_spawnGroup;
	_mydir = [_pt_pos, _mypos]  call BIS_fnc_dirTo;
	_mypos2 = [_mypos, 2,4,0,0,30,0] call bis_fnc_findSafePos;
	[_mypos2, (_mydir + 180), "O_Mortar_01_F", _grpname] call bis_fnc_spawnVehicle;
	sleep 0.1;

{
if (_x isKindOf "Man") then {mancleanup pushback _x} else {vehiclecleanup pushback _x};
if ((_x isKindOf "Man") and (vehicle _x == _x)) then {vehiclecleanup pushback (vehicle _x) };
 }foreach (units _grpname);

	};


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];