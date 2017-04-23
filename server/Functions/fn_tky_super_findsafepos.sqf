/*
	Author:
		Joris-Jan van 't Land, optimised by Killzone_Kid

	Description:
		Function to generate position in the world according to several parameters.

	Parameters:
		0: (Optional) ARRAY - center position
				Note: passing [] (empty Array), the world's "safePositionAnchor" entry will be used.

		1: (Optional) NUMBER - minimum distance from the center position
		2: (Optional) NUMBER - maximum distance from the center position
				Note: passing -1, the world's "safePositionRadius" entry will be used.

		3: (Optional) NUMBER - minimum distance from the nearest object
		4: (Optional) NUMBER - water mode
				0 - cannot be in water
				1 - can either be in water or not
				2 - must be in water

		5: (Optional) NUMBER - maximum terrain gradient (hill steepness)
		6: (Optional) NUMBER - shore mode:
				0 - does not have to be at a shore
				1 - must be at a shore

		7: (Optional) ARRAY - blacklist (Array of Arrays):
				(_this select 7) select 0: ARRAY - top-left coordinates of blacklisted area
				(_this select 7) select 1: ARRAY - bottom-right coordinates of blacklisted area

		8: (Optional) ARRAY - default positions (Array of Arrays):
				(_this select 8) select 0: ARRAY - default position on land
				(_this select 8) select 1: ARRAY - default position on water

	Returns:
		Coordinate array with a position solution.

*/

scopeName "main";

params [
	["_checkPos",[]],
	["_minDistance",0],
	["_maxDistance",-1],
	["_objectProximity",0],
	["_waterMode",0],
	["_maxGradient",0],
	["_shoreMode",0],
	["_posBlacklist",[]],
	["_defaultPos",[]]
];

// support object for center pos as well
if (_checkPos isEqualType objNull) then {_checkPos = getPos _checkPos};

/// --- validate input
#include "\a3\functions_f\paramsCheck.inc"
#define arr1 [_checkPos,_minDistance,_maxDistance,_objectProximity,_waterMode,_maxGradient,_shoreMode,_posBlacklist,_defaultPos]
#define arr2 [[],0,0,0,0,0,0,[],[]]
paramsCheck(arr1,isEqualTypeParams,arr2)

private _defaultMaxDistance = worldSize / 2;
private _defaultCenterPos = [_defaultMaxDistance, _defaultMaxDistance, 0];

private _fnc_defaultPos =
{
	_defaultPos = _defaultPos param [parseNumber _this, []];
	if !(_defaultPos isEqualTo []) exitWith {_defaultPos};

	_defaultPos = getArray (configFile >> "CfgWorlds" >> worldName >> "Armory" >> ["positionStart", "positionStartWater"] select _this);
	if !(_defaultPos isEqualTo []) exitWith {_defaultPos};

	_defaultPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	if !(_defaultPos isEqualTo []) exitWith {_defaultPos};

	_defaultCenterPos
};

if (_checkPos isEqualTo []) then
{
	_checkPos = getArray (configFile >> "CfgWorlds" >> worldName >> "safePositionAnchor");
	if (_checkPos isEqualTo []) then {_checkPos = _defaultCenterPos};
};

if (_maxDistance < 0) then
{
	_maxDistance = getNumber (configFile >> "CfgWorlds" >> worldName >> "safePositionRadius");
	if (_maxDistance <= 0) then {_maxDistance = _defaultMaxDistance};
};

private _checkProximity = _objectProximity > 0;
private _checkBlacklist = !(_posBlacklist isEqualTo []);
private _deltaDistance = _maxDistance - _minDistance;

_shoreMode = _shoreMode != 0;

if (_checkBlacklist) then
{
	_posBlacklist = _posBlacklist apply
	{
		call
		{
			if (_x isEqualTypeParams [[],[]]) exitWith
			{
				_x select 0 params [["_x0", 0], ["_y0", 0]];
				_x select 1 params [["_x1", 0], ["_y1", 0]];
				private _a = (_x1 - _x0) / 2;
				private _b = (_y0 - _y1) / 2;
				[[_x0 + _a, _y0 - _b], abs _a, abs _b, 0, true]
			};
			if (_x isEqualTypeAny [objNull, "", locationNull]) exitWith {_x};
			objNull
		};
	};
};

for "_i" from 1 to 3000 do
{
	_checkPos getPos [_minDistance + random _deltaDistance, random 360] call
	{
		if (_this isFlatEmpty [-1, -1, _maxGradient, _objectProximity, _waterMode, _shoreMode] isEqualTo []) exitWith {}; // true & exits if ife fails because not flat/empty
		if (_checkProximity && {!(nearestTerrainObjects [_this, [], _objectProximity, false] isEqualTo [])}) exitWith {}; // true & exits if nto says nothing nearby
		if ((lineIntersectsSurfaces [(ATLToASL _this), ((ATLToASL _this) vectorAdd [0,0,50]), ATLToASL _this, objNull, true,1, "GEOM", "NONE"] ) select 0 params ["","","", "_house"]) exitWith {}; // true & exits if indoors
		if (_checkBlacklist && {{if (_this inArea _x) exitWith {true}; false} forEach _posBlacklist}) exitWith {};
		_this select [0, 2] breakOut "main";
	};
};

// search failed, try default position
(_waterMode != 0) call _fnc_defaultPos