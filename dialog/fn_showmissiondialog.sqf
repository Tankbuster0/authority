disableSerialization;
diag_log "***fn_showmissiondialog runs";
_shopitems = ["squiffy", "blobby", "test"];

createDialog "tky_missiondialog";

waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;

{
	_ctrl lbAdd _x;




}foreach _shopitems