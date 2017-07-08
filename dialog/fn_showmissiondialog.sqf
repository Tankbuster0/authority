disableSerialization;

_shopitems = ["squiffy", "blobby", "test"];

createDialog "tky_showmissiondialog";

waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;

{
	_ctrl lbAdd _x;




}foreach _shopitems