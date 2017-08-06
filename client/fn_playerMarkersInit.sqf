scriptName "fn_playerMarkersInit";

/*
	Code written by Haz
*/

#define __FILENAME "fn_playerMarkersInit.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

// TODO: Show player markers on GPS and UAV Terminal

waitUntil {(!isNull ((findDisplay 12) displayCtrl 51))};

if ((!isNil "EH_mainMap")) then
{
	((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw", EH_mainMap];
};

EH_mainMap = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", Haz_fnc_playerMarkers];