//by tankbuster
 #include "..\includes.sqf"
_myscript = "cleanupoldprimary";
__tky_starts;
private ["_nvc"];
if (isNull previousmission) exitWith {diag_log "***cleanupoldprimary exits because previous mission is null!"};// ie, its the first target
_nvc = 0.75 * (["notveryclose",500] call BIS_fnc_getParamValue);
{
	if ((_x distance (getpos previousmission)) < _nvc ) then
	{
	deletevehicle _x;
	diag_log format ["***cleanupoldprimary deletes a dead %1", typeof _x];
	};
}foreach allDead;
// ^^ finds and deletes all dead vehicles and men
{
	if ([_x, true] call BIS_fnc_objectSide isEqualTo WEST) then

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
	diag_log format ["*** cleanupoldprimary deletes some old %1", typeof _x];
} foreach (previousmission nearEntities [["Civilian_F", "GroundWeaponHolderSimulated", "WeaponHolderSimulated", "GroundWeaponHolder"], _nvc]);
// ^^ finds and deletes civilian men and discardded weapons and ammo. any in cars/tanks etc will have been ejected when their veh was deleted earlier.



// Delete all CQB stuff (Mines, statics, etc)
{
	deleteVehicle _x;
} forEach CQBCleanupArr;
{deleteGroup _x} foreach allGroups;
__tky_ends