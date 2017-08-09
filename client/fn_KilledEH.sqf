scriptName "fn_KilledEH.sqf";

/*
	Code written by Haz
*/

#define __FILENAME "fn_KilledEH.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

params
[
	["_object", objNull],
	["_killer", objNull]
];

if ((isNull _object)) exitWith {};

// For future purposes... WIP!