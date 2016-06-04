//by tankbuster

_myscript = "cleanupoldprimary";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_nvc"];
if (isNull previousmission) exitWith {diag_log "***cleanupoldprimary exits because previous mission is null!"};// ie, its the first target
_nvc = ["notveryclose",500] call BIS_fnc_getParamValue;
{
	if ((_x distance (getpos previousmission)) < _nvc ) then
	{
	deletevehicle _x;
	diag_log format ["***cleanupoldprimary deletes a dead %1", typeof _x];
	};
}foreach allDead;
// ^^ finds and deletes all dead vehicles and men
{
	if ((faction _x) in  ["CUP_B_GB", "CUP_B_USMC", "CUP_B_US_Army"  ,"CUP_B_US_Navy", "CUP_B_CDF", "CUP_B_US", "CUP_B_CZ", "CUP_B_GER"]) then
	{
	diag_log format ["*** cleanupoldprimary didnt delete %1 because it's friendly", typeof _x];
	}
	else
	{
	deleteVehicle _x;
	diag_log format ["*** cleanupoldprimary deletes an old %1 vehicle ", typeof _x];
	};
} foreach  ((getpos previousmission) nearEntities ["LandVehicle", _nvc]);
// ^^ finds and delete civ and russian cars/tanks . leaves anything non russian

{
	deleteVehicle _x;
	diag_log format ["*** cleanupoldprimary deletes some old civilan %1", typeof _x];
} foreach (previousmission nearEntities [["Civilian_F", "CUP_Creatures_Civil_Chernarus_Base"], _nvc]);
// ^^ finds and deletes civilian men. any in cars/tanks etc will have been ejected when their veh was deleted earlier.

{deleteGroup _x} foreach allGroups;

// Delete all CQB stuff (Mines, statics, etc)
{
	deleteVehicle _x;
} forEach CQBCleanupArr;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];