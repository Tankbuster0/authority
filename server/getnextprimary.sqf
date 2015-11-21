#define filename "getnextprimary.sqf"
_thisscript = "getnextprimary.sqf";
//by tankbuster
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
private ["_airfieldfilternames","_foundairfields","_locs","_currentprimarytarget","_thisscript"];
if (primarytargetcounter == 1) then
	{//first target... find nearest airfield..
	_foundairfields = [];
	_locs = nearestLocations [markerPos "respawn_west" ,["NameVillage", "NameLocal"], 2000];
		{
		if ((["airfield", text _x] call BIS_fnc_instring) or (["airbase", text _x] call BIS_fnc_instring)) then
			{ _foundairfields pushback _x}
		} foreach _locs;
	//diag_log format ["***foundairfields %1 is typename %1",_foundairfields, typeName _foundairfields];
	//{diag_log format ["%1 is %2 from start", text _x, ((locationPosition _x) distance (markerpos "respawn_west"))]; }foreach _foundairfields;
	_currentprimarytarget = _foundairfields select 0;
	_logicgroup = createGroup logiccenter;
	_logic = _logicgroup createUnit ["Logic", (locationPosition _currentprimarytarget), [], 0, "NONE"];
	_logic setVariable ["targetname", "Airfield"];
	_logic setVariable ["targetradius", 300];
	_logic setvariable ["targetstatus", 3];// current pt
	_logic setVariable ["targettype", 2];// type airfield
	};

diag_log format ["*** cur pt %1 is typeName %2", _currentprimarytarget, typeName _currentprimarytarget];
nul = [_currentprimarytarget] execVM "server\spawnprimarytargetunits.sqf";

diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];