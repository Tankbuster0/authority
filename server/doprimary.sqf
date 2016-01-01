//by tankbuster
_myscript = "doprimary.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_airfieldfilternames","_foundairfields","_locs","_currentprimarytarget","_thisscript", "_ptarget", "_npt"];
vehiclecleanup= []; mancleanup = []; returndata = nil;
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
	_ptargetgroup = createGroup logiccenter;
	_ptarget = _ptargetgroup createUnit ["Logic", cpt_position, [], 0, "NONE"];
	_ptarget setVariable ["targetname", "Airfield"];
	_ptarget setVariable ["targetradius", cpt_radius];
	_ptarget setvariable ["targetstatus", cpt_status];// current pt
	_ptarget setVariable ["targettype", cpt_type];// type airfield
	}else{
	// 2nd, 3rd , 4th targets, etc
	_npt = [cpt_position] execVM "server\choosenextprimary.sqf";// creates global variable nextpt which is a logic
	waitUntil {scriptDone _npt};
	sleep 0.5;
	cpt_position = getpos nextpt;
	diag_log format ["*** doprimary @ 28 next primary chosen %1", cpt_position];
	cpt_radius = (nextpt getVariable "targetradius");
	_ptarget = nextpt;
	};

diag_log format ["***doprimary @31: cur pt %1 is typename %2 location is %3", _ptarget, typeName _ptarget, cpt_position];
nul = [_ptarget] execVM "server\spawnprimarytargetunits.sqf";
sleep 1;
handle = [_ptarget] execVM "server\spawnroadblocks.sqf";
waitUntil {sleep 1;(!(isnil returndata))};
// create a marker
cpt_marker = createMarker [str primarytargetcounter, cpt_position];
cpt_marker setMarkerShape "ELLIPSE";
cpt_marker setMarkerType "Flag";
cpt_marker setMarkerSize [cpt_radius,cpt_radius];
cpt_marker setMarkerColor "ColorRed";
_roadblocktrigger = createTrigger ["EmptyDetector, cpt_position"];
_roadblocktrigger setTriggerArea [1,1,0,false];
_roadblocktrigger setTriggerActivation ["NONE", "NOT PRESENT", false];
_roadblocktrigger setTriggerStatements ["{alive _x} count (units (returndata select 3)) == 0 ", "hint' roadblocks cleared'", ""];
// make trigger that senses when town is empty of enemies
_trg = createTrigger ["EmptyDetector", cpt_position];
_trg setTriggerArea [(cpt_radius + 200),(cpt_radius + 200),0,false];
_trg setTriggerActivation  ["EAST", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "execVM 'server\primarytargetcleared.sqf'", ""];

// task stuff
taskname = "task" + str primarytargetcounter;
[west, [taskname], ["Clear the target of all enemy forces", "Clear target of enemy forces","cpt_marker"], cpt_position,1,2,true ] call bis_fnc_taskCreate;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];