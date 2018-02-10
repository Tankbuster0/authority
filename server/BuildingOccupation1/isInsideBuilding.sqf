// By Alex aka AlManiak
// check if a position is inside.

// Input: Position
// Outpur: True if inside, false if outside.
 #include "..\includes.sqf"
params ["_position"];
private ["_buildingPosCeiling", "_intersect", "_inside"];

_buildingPosCeiling = [_position select 0, _position select 1, (_position select 2) + 25];
_intersect = lineIntersectsWith [ATLtoASL _position, ATLtoASL _buildingPosCeiling];

_inside = false;
if (count _intersect > 0 && {(_intersect select 0) isKindOf "House"}) then {_inside = true};

_inside;