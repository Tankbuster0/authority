#define filename "getprimarytargetlocations.sqf"
_thisscript = "getprimarytargetlocations.sqf";
//by tankbuster
//execvd'd by initserver
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
possibleprimaries = nearestLocations [mapcentre, ["NameCityCapital", "NameCity", "NameVillage"], mapsize /2];
// ^^ an array of locations suitable for PTs, sorted by distance from the island centre
{_x setVariable ["target_taken", -1];}foreach possibleprimaries;
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];