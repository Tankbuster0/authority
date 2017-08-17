scriptName "fn_missionStatus";

/*
	Code written by Haz
*/

#define __FILENAME "fn_missionStatus.sqf"

#include "..\dlg_missionStatus_IDCs.hpp"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

private _display = uiNamespace getVariable "disp_missionStatus";
private _titleRight = _display displayCtrl idc_title_right;
private _diagnostics = _display displayCtrl idc_diagnostics;

private _UID = if ((isMultiplayer)) then {(getPlayerUID player)} else {000};

if (((call BIS_fnc_admin) != 2) || (!(_UID in authenicatedAdmins))) then
{
	_diagnostics ctrlShow false;
} else
{
	authenicatedAdmins pushBackUnique (getPlayerUID player);
};

_titleRight ctrlSetStructuredText parseText format ["<t size='1.0' align='right' color='#FFFFFF'><img size='1.0' color='#FFFFFF' image='\A3\ui_f\data\gui\cfg\ranks\%1_gs.paa'/>%2</t><t size='0.5' align='right' valign='top' color='#FFFFFF'>(%3)</t>", (rank player), (name player), player];
_titleRight ctrlCommit 0;