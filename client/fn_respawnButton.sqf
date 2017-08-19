scriptName "fn_respawnButton";

/*
	Code written by Haz
*/

#define __FILENAME "fn_respawnButton.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

if (((lifeState player) isEqualTo "INCAPACITATED")) then
{
	((findDisplay 49) displayCtrl 1010) ctrlEnable false;
} else
{
	((findDisplay 49) displayCtrl 1010) ctrlEnable true;
};