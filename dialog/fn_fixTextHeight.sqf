scriptName "fn_fixTextHeight";

/*
	Code written by Haz
*/

#define __FILENAME "fn_fixTextHeight.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

_controlsGroup = (uiNamespace getVariable "disp_missionStatus") displayCtrl 1004;
_textBoxCtrl = _controlsGroup controlsGroupCtrl 100;

_textHeight = ctrlTextHeight _textBoxCtrl;
_textBoxPosition = ctrlPosition _textBoxCtrl;

_textBoxPosition set [3, _textHeight];
_textBoxCtrl ctrlSetPosition _textBoxPosition;
_textBoxCtrl ctrlCommit 0;