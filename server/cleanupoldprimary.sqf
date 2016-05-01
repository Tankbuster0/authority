
//by tankbuster
_myscript = "cleanupoldprimary";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];


_objs = entities "All";
_nearobjs = _objs select  {(_x distance previousmission) < 400};
{
	if (
	    (not (isplayer _x))
	    and
	    (not (_x in ["forward", "fobveh", "ammobox", "fobbox"]))
	    and
	    (not (typeName _x))
	   ) then
	    	{ 	deleteVehicle _x};
} foreach _nearobjs;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];