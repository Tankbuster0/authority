scriptName "fn_KilledEH.sqf";

/*
	Code written by Haz
*/

#define __FILENAME "fn_KilledEH.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

params
[
	["_object", objNull],
	["_killer", objNull],
	["_shooter", objNull]
];
if ((typeselected isEqualTo "kill1man") and {(_object distance2d mybldposition) < 30}) then
	{
	missionsuccess = false; publicVariable "missionsuccess";
	missionactive = false; publicVariable "missionactive";


	};















if ((isNull _object)) exitWith {};

// For future purposes... WIP!