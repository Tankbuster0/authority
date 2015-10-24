#define filename "getprimarytargetlocations.sqf"
_thisscript = "getprimarytargetlocations.sqf";
//by tankbuster
//execvd'd by initserver
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
private ["_centre","_cgroup","_logic"];
possibleprimaries = nearestLocations [mapcentre, ["NameCityCapital", "NameCity", "NameVillage"], mapsize /2];
diag_log format ["possibleprimaries count = %1", count possibleprimaries];
_centre = createCenter sideLogic;
_cgroup = createGroup _centre;

// ^^ an array of locations suitable for PTs, sorted by distance from the island centre
{
	_lp = locationPosition _x;
	_lp set [2,0];// fix for locationpositions returning altitude zero ASL.
	_logic = _cgroup createUnit ["logic", _lp, [],0, "NONE"];
	_logic setVariable ["target_taken", -1, true];
	sleep 0.1;
	diag_log format ["*** location %1 taken var = %2", text _x,(_logic getvariable "target_taken")];
}foreach possibleprimaries;
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];