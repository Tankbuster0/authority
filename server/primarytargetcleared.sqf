//by tankbuster
_myscript = "primarytargetcleared.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

private ["_newflag","_nearestplayers","_pos","_droptype","_nul","_veh"];
previousmission = nextpt; // remember the old target in this variable to use in later cleanup scripts
nextpt setvariable ["targetstatus", 2];
cpt_marker setMarkerColor "ColorBlue";
_newflag = "Flag_Blue_F" createVehicleLocal (getpos cpt_flag);// replace the red flag with a LOCALLY NAMED blue one (so it's never deleted)
deleteVehicle cpt_flag;// delete the globally named (but only created on server) red flag
sleep 0.5;
//find the player nearest to the new blue flag, and call the airdrop on him. If this is target 1, this must be the fob vehicle
_nearestplayers = nearestobjects [(getpos _newflag), ["SoldierWB"], 750];
if ((count _nearestplayers) < 1) then {_pos = (getpos _newflag)} else {_pos = (getpos (_nearestplayers select 0))};

if (primarytargetcounter isEqualTo 1) then
	{
		_droptype = fobvehicleclassname;
	} else
	{
		_droptype = (selectRandom prizes);
	};//else choose prize vehicle
if (_droptype isKindOf "Air") then
	{
		_pos = airhead_container_landing_point;
	};// prize is an airvehicle which will be delivered containerised to a special landing point
_nul = [_pos, blufordropaircraft, _droptype ] execVM "server\spawnairdrop.sqf";

{
	sleep 0.05;
	_veh = _x;
	{
		_veh deleteVehicleCrew _x;
		sleep 0.05;
	} foreach crew _veh;
	deletevehicle _x;
} foreach vehiclecleanup;
{
	deletevehicle _x;
	sleep 0.05;
} foreach mancleanup;
{
	deleteGroup _x;
	sleep 0.05;
} foreach allGroups;
[taskname, "SUCCEEDED", true] call bis_fnc_taskSetState;
sleep 180;

primarytargetcounter = primarytargetcounter + 1;

_nul = execVM "server\doprimary.sqf";

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];