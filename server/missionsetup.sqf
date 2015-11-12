#define filename "missionsetup.sqf"
_thisscript = "missionsetup.sqf";
//by tankbuster
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
// find all airfields
	_foundairfields = [];
	_mapsize  = worldSize;
	_mapcentre = [_mapsize / 2, _mapsize / 2 ,0];
	_locs = nearestLocations [_mapcentre ,["NameVillage", "NameLocal"], _mapcentre];
		{
		if ((["airfield", text _x] call BIS_fnc_instring) or (["airbase", text _x] call BIS_fnc_instring)) then
			{ _foundairfields pushback _x}
		} foreach _locs;
	diag_log format ["***foundairfields %1 is typename %1",_foundairfields, typeName _foundairfields];
	//{diag_log format ["%1 is %2 from start", text _x, ((locationPosition _x) distance (markerpos "respawn_west"))]; }foreach _foundairfields;
	//_currentprimarytarget = _foundairfields select 0;
_airfield = _foundairfields call bis_fnc_selectRandom;
_shorepos =




diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];