//SPUn and Tankbuster
_myscript = "s_maintargetfillhouse.sqf"

private ["_buildings","_radius","_building","_aliveUnits","_AIgrp","_possibleBuildingsCount","_selectedBuildingsCount","_mt_town_cent","_mpos","_sel","_position","_dir","_mineSpot","_mineSpot2","_tWire","_doorPositions","_bdCfg","_originalCount","_tlist","_engagingT","_engagePercentage","_tripMinePossibility"];
_mt_town_cent = _this select 0;

// Randomly select hostile buildings and populate them at the main target marker
if (not isServer) then
{
	//Additional settings:
	_possibleBuildingsCount = 15;
	_selectedBuildingsCount = 8;

	//preprocess function to find buildings:
	if (isNil("LV_nearestBuilding")) then {LV_nearestBuilding = compile preprocessFile "LV\LV_functions\LV_fnc_nearestBuilding.sqf";};
	//Find all possible buildings in mission area (starts from 45m and rises until possibleBuildingsCount is reached
	_buildings = [];
	_radius = 45;
	sleep 0.987;
	while {count _buildings < _possibleBuildingsCount} do {
		sleep 0.0987;
		_buildings = [];
		_buildings = ["all in radius",_mt_town_cent,_radius] call LV_nearestBuilding;

		_radius = _radius + 10;
		if (_radius > 150) exitWith {};
	};
	if (isNil("_buildings")) exitWith {diag_log "***not enough buildings!***"};
	_buildings = _buildings call BIS_fnc_arrayshuffle;
	//Select randomly hostile buildings and execute fillHouse
	for "_i" from 0 to _selectedBuildingsCount do {
		sleep 0.011;
		_building = _buildings select _i;
		_windowarray = [_building] call fn_p_getWindowPos;// use new pilgrim function to get all window position. returns [position, direction, quality] for each building pos
		
		_grp = [d_enemy_side] call fn_creategroup;//create the a group for each house
		_unit_array = ["cqb_men", opfor] call d_fnc_getunitlist;//func getunitliste; calling basic gets a single man from the array

		{
			_thispos = _x; //selects the first (then second) record from windowarray
			_unitgroup = [_thispos select 0, _unit_array select 0, _grp] call d_fnc_makemgroup;
			_unit = _unitgroup select 0;
			_unit setposATL (_thispos select 0);
			doStop _unit;
			_unit setUnitPos "UP";
			_watchpos = [_thispos select 0, _thispos select 1, 5] call fn_p_relativePos;// get a position 5 meters away from position in the watchdirection
			_unit doWatch _watchpos;

		}foreach _windowarray;// interate through each position within the building
	};


	sleep 1.321;

};
