
//by tankbuster
_myscript = "cleanupoldprimary";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

// dont delete players, blufor assets such as forward, fobveh, ammoboxes, prizes, flagpoles
_objs = entities "All";
_nearobjs = _objs select  {(_x distance previousmission) < 400};
_nearobjs = nearobjs - allPlayers;

{
	if (
	    (not (_x in ["forward", "fobveh", "ammobox", "fobbox"]))
	    or
	    (not (typeName _x in prizes))
	    or
	    (not (_x isKindOf "FlagCarrierCore"))
	   ) then
	    	{ 	deleteVehicle _x};
} foreach _nearobjs;


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];