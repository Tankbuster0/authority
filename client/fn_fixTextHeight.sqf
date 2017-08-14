scriptName "fn_fixTextHeight";

/*
	Code written by Haz
*/

#define __FILENAME "fn_fixTextHeight.sqf"

#include "..\dlg_missionStatus_IDCs.hpp"

if ((isDedicated) || (!hasInterface)) exitWith {};

_controlsGroup = (uiNamespace getVariable "disp_missionStatus") displayCtrl idc_controlsGroup;
_textBoxCtrl = _controlsGroup controlsGroupCtrl idc_textBox;

_textHeight = ctrlTextHeight _textBoxCtrl;
_textBoxPosition = ctrlPosition _textBoxCtrl;

_textBoxPosition set [3, _textHeight];
_textBoxCtrl ctrlSetPosition _textBoxPosition;
_textBoxCtrl ctrlCommit 0;