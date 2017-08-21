scriptName "fn_keyDownHandler";

/*
	Code written by Haz
*/

#define __FILENAME "fn_keyDownHandler.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

params
[
	["_display", objNull],
	["_key", objNull],
	["_shift", objNull],
	["_ctrl", objNull],
	["_alt", objNull]
];

private _handled = false;

private _escKey = 1;
private _missionStatusKey = if ((count (actionKeys "User1") isEqualTo 0)) then {220} else {(actionKeys "User1") select 0};

switch ((_key)) do
{
	case _escKey :
	{
		[] spawn tky_fnc_respawnButton;
	};
	case _missionStatusKey :
	{
		_handled = true;
		if ((!dialog)) then
		{
			[] spawn tky_fnc_showmissiondialog;
		};
	};
};

_handled