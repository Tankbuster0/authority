scriptName "fn_sendDataToClient";

/*
	Code written by Haz
*/

#define __FILENAME "fn_sendDataToClient.sqf"

if ((!isServer)) exitWith {};

params
[
	["_unit", objNull],
	["_variable", objNull],
	["_data", objNull]
];

call compile format ["%1 = %2;", _variable, _data];

myPlayerData = _data;

_data