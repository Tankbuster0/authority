scriptName "fn_missionStatus";

/*
	Code written by Haz
*/

#define __FILENAME "fn_missionStatus.sqf"

#include "..\dlg_missionStatus_IDCs.hpp"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

_display = uiNamespace getVariable "disp_missionStatus";
_titleRight = _display displayCtrl idc_title_right;
_diagnostics = _display displayCtrl idc_diagnostics;

// https://community.bistudio.com/wiki/admin
// In all other cases it returns 0. To self check the admin state of a local client, use BIS_fnc_admin.
// (call compile "(call BIS_fnc_admin) clientOwner != 2")
// Change to the above IF the below doesn't work...
// The reason I use this command rather than serverCommandAvailable is because I only want the button to show for admins who logged in with password, not voted in

if ((call compile "admin clientOwner != 2")) then
{
	_diagnostics ctrlShow false;
};

_titleRight ctrlSetStructuredText parseText format ["<t size='1.0' align='right' color='#FFFFFF'><img size='1.0' color='#FFFFFF' image='\A3\ui_f\data\gui\cfg\ranks\%1_gs.paa'/>%2</t><t size='0.5' align='right' valign='top' color='#FFFFFF'>(%3)</t>", (rank player), (name player), player];
_titleRight ctrlCommit 0;