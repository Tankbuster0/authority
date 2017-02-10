//by tankbuster
_myscript = "tky__super_islflatempty";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
_debugsign = createvehicle ["Sign_Arrow_Large_Cyan_F", [0,0,0], [],0,"CAN_COLLIDE"];
while {true} do
{
	sleep 1;
	_ife =  (position player) isFlatEmpty
	[-1,// min radius
	-1, //mode, must be -1
	0.35, //max grad
	2, // max grad radius
	0,// cannot be water
	false, // shoreline mode off
	objNull// ignore proximity //surely this should be player/ fobveh?
	];
	if (_ife == []) then {} else {_debugsign setpos _ife};

};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];