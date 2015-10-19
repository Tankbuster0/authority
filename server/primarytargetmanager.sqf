#define filename "primarytargetmanager.sqf"
_thisscript = "primarytargetmanager.sqf";
//by tankbuster
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
private ["_currentprimarytarget","_pt_pos","_grp","_thisscript"];
_currentprimarytarget = _this select 0;
diag_log format ["***Primary Target starts text %1, actual %2, typename %3", text _currentprimarytarget, _currentprimarytarget, typeName _currentprimarytarget];
_pt_pos = locationPosition _currentprimarytarget;
_grp = createGroup east;
_grp = [_pt_pos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
diag_log str _pt_pos;
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];