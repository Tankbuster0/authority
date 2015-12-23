//by tankbuster
_myscript = "primarytargetcleared.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

private ["_crew","_veh", "_allclean"];
if (primarytargetcounter > 1) then {nextpt setvariable ["targetstatus", 2];};
cpt_marker setMarkerColor "ColorPink";
/*_allclean = vehiclecleanup + mancleanup;
{
_crew = crew _x;
_veh = _x;
{_veh deletevehiclecrew _x} foreach _crew;
deleteVehicle _veh;
}foreach _allclean;
vehiclecleanup= []; mancleanup = []; _allclean = [];*/
{
	_veh = _x;
	{_veh deleteVehicleCrew _x} foreach crew _veh;
	deletevehicle _x;
} foreach vehiclecleanup;
{deletevehicle _x} foreach mancleanup;
{delete _x} foreach allGroups;
primarytargetcounter = primarytargetcounter + 1;
_nul = execVM "server\doprimary.sqf";


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];