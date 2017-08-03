scriptName "fn_missionStatus";

/*
	Code written by Haz
*/

#define __FILENAME "fn_missionStatus.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

_display = uiNamespace getVariable "disp_missionStatus";
_titleRight = _display displayCtrl 300;

_titleRight ctrlSetStructuredText parseText format ["<t size='1.0' align='right' color='#FFFFFF'><img size='1.0' color='#FFFFFF' image='\A3\ui_f\data\gui\cfg\ranks\%1_gs.paa'/>%2</t><t size='0.5' align='right' valign='top' color='#FFFFFF'>(%3)</t>", (rank player), (name player), player];
_titleRight ctrlCommit 0;