//by tankbuster
_myscript = "tky_super_islflatempty";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
_debugsign = createvehicle ["Sign_Arrow_Large_Cyan_F", [0,0,0], [],0,"CAN_COLLIDE"];
while {true} do
{
	sleep 1;
	_ife =  (position player) isFlatEmpty
	[5,// min radius
	-1, //mode, must be -1
	0.35, //max grad
	4, // max grad radius
	0,// cannot be water
	false, // shoreline mode off
	objNull// ignore proximity //surely this should be player/ fobveh?
	];
	if ((count _ife) > 1) then
		{
		_signpos = _ife;
		_signpos set [2,0];
		_debugsign setpos _signpos};

};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];