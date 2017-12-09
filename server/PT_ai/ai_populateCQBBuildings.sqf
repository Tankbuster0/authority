// By Alex aka AlManiak
// Script that populates buildings with troops.
// Center buildings have a higher occupation chance and contain CQB troops.
// Outskirt buildings have a lower chance of occupation and contain snipers/marksmen
// Some buildings might contain explosive traps

//Input: Position of center of preferred area.
//		 Radius of Target.
 #include "..\includes.sqf"
_myscript = "ai_populateCQBBuildings.sqf";
__tky_starts;
handle_ai_pcqb_finished = false;
AM_fnc_checkInside = compile preprocessFile "Server\BuildingOccupation\isInsideBuilding.sqf";
//AM_fnc_isWindowPos = compile preprocessFile "BuildingOccupation\isWindowPos.sqf";
fn_p_getWindowPos = compile preprocessFile "Server\BuildingOccupation\getWindowedPos.sqf";

params ["_position", "_radiusTarget"];
/*private ["_possibleCenterBuildingCount", "_possibleOutskirtBuildingCount", "_centerBuildings",
"_outskirtBuildings", "_radius", "_buildingPosList","_ballistradeArray","_windowarray","_watchPos",
"_ballistradeMax","_maxOutskirtSoldiers","_maxOccupiedCenterSoldiers","_maxCenterBallistradeSoldiers","_maxSquadSizeOutskirt","_elligableTripMineBuildings",
"_maxTripwireMinesBuildings","];*/

// This Array can be used for cleanup. It contains everything non human.
CQBCleanupArr = [];

//*********************************
// Main tweakable parameters
//*********************************

// Maximum implies max possible units. may be less depending on chance %

_possibleCenterBuildingCount = random [7,10,15];
_centerSearchMax = (_radiusTarget);

_chanceOfOccupiedSoldier = 80;
_chanceOfOccupiedStaticMG = 5;
_maxOccupiedCenterSoldiers = 45;

_chanceOfBallistradeSoldier = 50;
_maxCenterBallistradeSoldiers = 15;

_chanceTripwireMinesBuildings = 35;
_maxTripwireMinesBuildings = 5;

_possibleOutskirtBuildingCount = random [0,3,6];

_chanceOfOutskirtSoldier = 100;
_maxOutskirtSoldiers = 15;

// Actually max + 1
_maxSquadSizeOutskirt = 2;

_elligableTripMineBuildings = [
["Land_i_House_Big_01_V2_F",[[[-0.8,-5.5,-2.5], - 90],[[4.5,5,-2.5], + 90]]], ["Land_u_House_Big_01_V1_F",[[[-0.8,-5.5,-2.5], - 90],[[4.5,5,-2.5], + 90]]],
["Land_i_House_Big_02_V2_F",[[[0,4,-2.5], 0],[[-2.5,-3,-2.5], 0]]], ["Land_i_House_Big_02_V1_F",[[[0,4,-2.5], 0],[[-2.5,-3,-2.5], 0]]]
];
//**********************************

// Helper function to quickly create units
AM_fnc_CreateUnit = {

	params ["_type","_pos","_watchPos","_grp","_dbg"];

	_unit = _grp createUnit [_type, _pos, [], 0, "NONE"];
	doStop _unit;
	_unit setUnitPos "UP";
	_unit doWatch _watchpos;

	if (!_dbg) exitWith {_unit};
	_marker1 = createMarker ["Marker1", position _unit];
	_marker1 setMarkerType "hd_dot";
	_unit
};

// Helper function to quickly create units
AM_fnc_CreateStatic = {

	params ["_type","_pos","_watchPos","_grp","_dbg"];

	_unit = [_pos, 0,_type, East] call BIS_fnc_spawnVehicle;
	//(_unit select 0) attachTo [( (position (_unit select 0)) nearestObject "House")];

	// Add MG to cleanup array;
	CQBCleanupArr pushBack (_unit select 0);

	_unit doWatch _watchpos;

	if (!_dbg) exitWith {_unit};
	_marker1 = createMarker ["Marker1", position _unit];
	_marker1 setMarkerType "hd_dot";
	_unit
};

// Helper function to quickly create mine
AM_fnc_CreateMine = {
	params ["_building","_localPos","_dir"];
	_m = createMine ["APERSTripMine", (_building modelToWorld _localPos) ,[], 0];
	// Add mine to cleanup array;
	CQBCleanupArr pushBack _m;

	_m setDir (getDir _building + _dir);
	_m
};

/////////////////////////////////////////////////////
// Find Buildings with buildingspositions
//***********************************************
// Occupy center buildings.
////////////////////////////////////////////////////
_radius = 20;

// First index is buildingObj, second index is array of positions.
_buildingPosList = [];

_centerBuildings = [];

_currOccupiedCenterSoldiers = 0;

while { count _buildingPosList < _possibleCenterBuildingCount} do
{
	_centerBuildings = _position nearObjects ["House", _radius];
	_buildingPosList = [];

	{
		_buildPos = [_x] call BIS_fnc_buildingPositions;
		if (! (_buildPos isEqualTo [])) then
		{
			_buildingPosList pushBack [_x,_buildPos];
		};
	} foreach _centerBuildings;

	_radius = _radius + 50;

	if (_radius > _centerSearchMax) exitWith {diag_log "***populateCQBBuildings: Not enough center buildings found within 250 meters, using what we have"};
};

//*********************************************
// Create troops inside buildings near windows
//*********************************************
{
	// Create Units
	_grp = createGroup east;
	_windowarray = [_x select 0] call fn_p_getWindowPos;
	{
		_watchpos = [_x select 0, 5, _x select 1] call BIS_fnc_relPos;// get a position 5 meters away from position in the watchdirection
		if (random 100 < _chanceOfOccupiedSoldier) then
		{
			if (random 100 > (100 - _chanceOfOccupiedStaticMG)) then
			{
				//Fun easteregg :D
				_unit = ["O_HMG_01_high_F", _x select 0, _watchpos , _grp, false] call AM_fnc_CreateStatic;
			}else{
				_unit = [selectRandom opfor_CQB_soldier, _x select 0, _watchpos , _grp, false] call AM_fnc_CreateUnit;
			};
		};
		_currOccupiedCenterSoldiers = _currOccupiedCenterSoldiers +1;
	}foreach _windowarray;// interate through each position within the building

	// Limiter
	if (_currOccupiedCenterSoldiers >= _maxOccupiedCenterSoldiers) exitWith{};

} forEach _buildingPosList;

//*********************************************
// Create tripMines inside buildings
//*********************************************
_currentTripMinesBuild = 0;
{
	// Array structure is [["Land_i_House_Big_01_V2_F",[[[-0.8,-5.5,-2.5], - 90],[4.5,5,-2.5], + 90]]];
	_bdng = _x select 0;
	{
		//diag_log FORMAT ["***populateCQBBuildings: checking house %1 for %2 is %3",(_x select 0), (typeOf _bdng), (_x select 0) isEqualTo (typeOf _bdng)] ;
		if ( (_x select 0) isEqualTo (typeOf _bdng) ) then
		{
			{
				//diag_log FORMAT ["***populateCQBBuildings: Placing tripwire in %1 at %2 and %3", (typeOf _bdng), (_x select 0), (_x select 1)] ;
				if (random 100 > (100 - _chanceTripwireMinesBuildings)) then
				{
					_m = [_bdng, _x select 0, _x select 1] call AM_fnc_CreateMine;
				};
			} forEach (_x select 1);
			_currentTripMinesBuild = _currentTripMinesBuild + 1;
		};
	} forEach _elligableTripMineBuildings;

	// Limiter
	if (_currentTripMinesBuild >= _maxTripwireMinesBuildings) exitWith{};

} forEach _buildingPosList;

//***************************************
// Create machinegunners on balistrade
//****************************************
_ballistradeCount = 0;
{
	_ballistradeArray = [];
	_grp = createGroup east;

	{
		// Limiter
		if (_ballistradeCount >= _maxCenterBallistradeSoldiers) exitWith{};

		if (! ([_x] call AM_fnc_checkInside) ) then
		{
			_ballistradeArray pushBack _x;
		};
	} forEach (_x select 1) ;

	{
		if (random 100 > (100 - _chanceOfBallistradeSoldier)) then
		{
			_watchpos = [_x, 5, (random 360)] call BIS_fnc_relPos;// get a position 5 meters away from position in the watchdirection
			_unit = [selectRandom opfor_CQB_Pattio, _x, _watchpos , _grp, false] call AM_fnc_CreateUnit;
		};
		_ballistradeCount = _ballistradeCount + 1;
	}foreach _ballistradeArray;// interate through each position within the building

} forEach _buildingPosList;

//****************************************************
////////////////////////////////////////////////////
// Occupy outskirt buildings.
////////////////////////////////////////////////////
/* temporarly disabled this while we figure out how to stop it slowing down ar and mil base missions
_radius = 20;

// First index is buildingObj, second index is array of positions.
_buildingPosList = [];

_currOutskirtSoldiers = 0;
_currOutskirtSquadNr = 0;
while { count _buildingPosList < _possibleOutskirtBuildingCount} do
{
	// Probe outskirt positions
	_probePos = [_position, (_radiusTarget + random[-(_radiusTarget/3),50,250]), random 360] call BIS_fnc_relPos;
	_nBuilding = _probePos nearestObject "House";

	_buildPos = [_nBuilding] call BIS_fnc_buildingPositions;
	if (! (_buildPos isEqualTo []) && !(typeOf _nBuilding isEqualTo "Land_Metal_Shed_F")) then
	{
		if (! ([_nBuilding,_buildPos] in _buildingPosList) ) then
		{
			_buildingPosList pushBack [_nBuilding,_buildPos];
		};
	};

};
BLis = _buildingPosList;
{
	_grp = createGroup east;

	// Limiter
	if (_currOutskirtSoldiers >= _maxOutskirtSoldiers) exitWith{};
	_currOutskirtSquadNr = 0;

	_windowarray = [_x select 0] call fn_p_getWindowPos;
	{
		if (random 100 > ( 100 - _chanceOfOutskirtSoldier)) then
		{
			_watchpos = [_x select 0, 5, _x select 1] call BIS_fnc_relPos;// get a position 5 meters away from position in the watchdirection
			_unit = [selectRandom opfor_CQB_Outskirt, _x select 0, _watchpos , _grp, false] call AM_fnc_CreateUnit;
		};

		if (_currOutskirtSquadNr >= _maxSquadSizeOutskirt) exitWith{};

		_currOutskirtSquadNr = _currOutskirtSquadNr + 1;
		_currOutskirtSoldiers = _currOutskirtSoldiers + 1;

	}foreach _windowarray;// interate through each position within the building

} forEach _buildingPosList;
*/
/*
{
	_grp = createGroup west;
	_chosenBPos = [];
	for "_i" from 1 to _maxOccupancyNumber do
	{
		// No Doubles
		_rndBPos = selectRandom (_x select 1);
		if (! (_rndBPos in _chosenBPos)) then
		{
			_chosenBPos pushBack _rndBPos;
		};
	};

	diag_log format ["***chosen positions %1",_chosenBPos];

	{
		if ([_x] call AM_fnc_checkInside) then
		{
			_wndwInfo = [_x] call AM_fnc_isWindowPos;
			if(_wndwInfo select 1 > 0) then
			{
				diag_log format ["*** watchdir %1",_wndwInfo select 0];
				_unit = ["B_crew_F", _x, _wndwInfo select 0 , _grp, true] call AM_fnc_CreateUnit
			}else
			{
				_unit = ["B_crew_F", _x, random 360, _grp, true] call AM_fnc_CreateUnit
			};

		} else
		{
			_unit = ["B_HeavyGunner_F", _x, 0 , _grp, true] call AM_fnc_CreateUnit;
		};

	} forEach _chosenBPos;
} forEach _buildingPosList;
*/

/*
// Find outskirt buildings to occupy.
_radius = 20;

_outskirtBuildings = [];
_possibleOutskirtBuildingCount = random [0,2,5];

while { count _outskirtBuildings < _possibleOutskirtBuildingCount} do
{
	_tempPos =  [_position, _radius, random 360] call BIS_fnc_relPos
	_buildings pushBack (_tempPos nearestObject "House");

	_radius = _radius + 50;

	if (_radius > 250) exitWith {diag_log "***No outskirt buildings found within 250 meters"};
};
*/
handle_ai_pcqb_finished = true;
__tky_ends