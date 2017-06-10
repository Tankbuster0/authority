 #include "..\includes.sqf"
_myscript = "playersetup.sqf";
private _spawnpos = islandcentre;
private  _testradius = 2;
__tky_starts;
waitUntil {!isNull player};
//sleep 0.5;
[] execVM "client\tky_supportmanager.sqf";
[]execVM "client\makediary.sqf";
while {_spawnpos isEqualTo islandcentre } do
	{
	_spawnpos = [ammobox, 2, _testradius, 4, 0, 0.5, 0,1,1] call tky_fnc_findSafePos;;
	_testradius = _testradius * 2;
	};
player setpos _spawnpos;
__tky_ends