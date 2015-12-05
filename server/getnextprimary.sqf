#define filename "getnextprimary.sqf"
_thisscript = "getnextprimary.sqf";
//by tankbuster
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
private ["_airfieldfilternames","_foundairfields","_locs","_currentprimarytarget","_thisscript", "_logic"];
if (primarytargetcounter == 1) then
	{//first target... find nearest airfield..
	_foundairfields = [];
	_locs = nearestLocations [markerPos "respawn_west" ,["NameVillage", "NameLocal"], 2000];
		{
		if ((["airfield", text _x] call BIS_fnc_instring) or (["airbase", text _x] call BIS_fnc_instring)) then
			{ _foundairfields pushback _x}
		} foreach _locs;
	cpt_radius = 300;
	cpt_status = 3;// current pt
	cpt_type =2;//type airfield
	_currentprimarytarget = _foundairfields select 0;
	cpt_position = locationPosition _currentprimarytarget;
	_logicgroup = createGroup logiccenter;
	_logic = _logicgroup createUnit ["Logic", cpt_position, [], 0, "NONE"];
	_logic setVariable ["targetname", "Airfield"];
	_logic setVariable ["targetradius", cpt_radius];
	_logic setvariable ["targetstatus", cpt_status];// current pt
	_logic setVariable ["targettype", cpt_type];// type airfield
	}else{
	// 2nd, 3rd , 4th tergets, etc
	_npt = [cpt_position] execVM "\server\choosenextprimary.sqf";
	diag_log format ["***next primary chosen %1", _npt];
	};

//diag_log format ["*** cur pt %1 is typeName %2", _currentprimarytarget, typeName _currentprimarytarget];
nul = [_logic] execVM "server\spawnprimarytargetunits.sqf";
// create a marker
_marker1 = createMarker ["markerbane", _logic];
_marker1 setMarkerShape "ELLIPSE";
_marker1 setMarkerType "Flag";
_marker1 setMarkerSize [cpt_radius,cpt_radius];//replace this with dymanic radius

// make trigger that senses when town is empty of enemies
_trg = createTrigger ["EmptyDetector", cpt_position];
_trg setTriggerArea [(cpt_radius + 200),(cpt_radius + 200),0,false];
_trg setTriggerActivation  ["EAST", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "execVM 'server\primarytargetcleared.sqf'", ""];

// task stuff
//[west, ["task1"], ["Clear the target of all enemy forces", "clear", ]] call bis_fnc_taskCreate;

diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];