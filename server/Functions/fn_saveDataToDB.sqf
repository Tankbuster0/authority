scriptName "fn_saveDataToDB";

/*
	Code written by Haz
*/

#define __FILENAME "fn_saveDataToDB.sqf"

if ((!isServer)) exitWith {};

params
[
	["_database", objNull],
	["_unit", objNull]
];

private _variable = format ["%1_%2_playerData", _database, (getPlayerUID _unit)];

private _uid = getPlayerUID _unit;
private _name = name _unit;

profileNamespace setVariable [_variable, [_uid, _name]];

saveProfileNamespace;