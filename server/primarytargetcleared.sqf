//by tankbuster
 #include "..\includes.sqf"
_myscript = "primarytargetcleared.sqf";
__tky_starts;

private ["_newflag","_nearestplayers","_pos","_droptype","_nul","_veh", "_txt"];
taskbool = [taskname, "SUCCEEDED", true] call bis_fnc_taskSetState;
previousmission = nextpt; // remember the old target in this variable to use in later cleanup scripts
nextpt setvariable ["targetstatus", 2];
cpt_marker setMarkerColor "ColorBlue";
_newflag = "Flag_Blue_F" createVehicleLocal (getpos cpt_flag);// replace the red flag with a LOCALLY NAMED blue one (so it's never deleted)
deleteVehicle cpt_flag;// delete the globally named (but only created on server) red flag
blueflags pushBack _newflag;
sleep 0.5;
debugendmission = false;
//find the player nearest to the new blue flag, and call the airdrop on him. If this is target 1, this must be the fob vehicle
_nearestplayers = nearestobjects [(getpos _newflag), ["SoldierWB"], 750, false];
if ((count _nearestplayers) < 1) then {_pos = (getpos _newflag)} else {_pos = (getpos (_nearestplayers select 0))};
deleteVehicle pt_fire;
if (primarytargetcounter isEqualTo 1) then
	{
		_droptype = fobvehicleclassname;
	} else
	{
		_droptype = (selectRandom prizes);
		while {airprizeawaitingassembly and (_droptype isKindOf "Air")} do
			{_droptype = (selectRandom prizes);};// if there's an aircraft awaiting assembly and another aircraft is chosen as prize, keep chosing.
		prizecounter = prizecounter + 1;
		publicVariable "prizecounter";
	};//else choose prize vehicle
if (_droptype isKindOf "Air") then
	{
		_pos = blubasehelipad;;
		_txt = "Your bonus vehicle is an aircraft and is being delivered packed into a container.";
	}else// prize is an airvehicle which will be delivered containerised to a special landing point
	{_txt = "This is your prize for clearing the primary target";};
_nul = [_pos, blufordropaircraft, _droptype, [0,0,0],_txt] execVM "server\spawnairdrop.sqf";
{
	_veh = _x;
	{
		_veh deleteVehicleCrew _x;
	} foreach crew _veh;
	deletevehicle _x;
} foreach vehiclecleanup;
{
	deletevehicle _x;
} foreach mancleanup;
{
	deleteGroup _x;
} foreach allGroups;

if (serverName in testservernames) then {sleep 40;} else {sleep 180;};

primarytargetcounter = primarytargetcounter + 1;

_nul = execVM "server\doprimary.sqf";

__tky_ends