// by tankbuster
_myscript = "makeconvoy.sqf"''
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
_cpt = _this select 0; // actually a logic
// choose a town a couple of K away, away from other blufor towns
_furthestdistsofar = 0; _furthestlocsofar = objNull;
for "_i" from 0 to 359 step 15 do

	{
		// get locations 3k away, seeing which is furtherest from nearest blufor held town
		_mypos1 = [cpt, _i, 3000 ] call BIS_fnc_relPos;
		// get the nearest blufor town;
		_nearblufors1 =  ne
	};


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];