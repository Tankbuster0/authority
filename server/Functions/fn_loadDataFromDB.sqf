scriptName "fn_loadDataFromDB";

/*
	Code written by Haz
*/

#define __FILENAME "fn_loadDataFromDB.sqf"

if ((!isServer)) exitWith {};

params
[
	["_database", objNull],
	["_unit", objNull],
	["_variable", objNull],
	["_default", objNull]
];

if ((isNil {profileNamespace getVariable _variable})) exitWith
{
	[_database, player] call tky_fnc_saveDataToDB;
};

_data = call compile format ["%1", (profileNamespace getVariable [_variable, _default])];

[_unit, _variable, _data] remoteExec ["tky_fnc_sendDataToUnit", _unit, false];