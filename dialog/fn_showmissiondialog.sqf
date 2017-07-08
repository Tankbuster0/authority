disableSerialization;

_shopitems = ["squiffy", "blobby", "test"];

createDialog "tky_missiondialog";

waitUntil {!isNull (findDisplay 9999);};
_cpt_name = (primarytarget getVariable "targetname");
ctrlSetText [1004, (format ["The Primary Target is at %1. Clear the enemy from there.", _cpt_name ])];

_ctrl = (findDisplay 9999) displayCtrl 1500;

{
	_ctrl lbAdd _x;




}foreach _shopitems