//fnc_spawnrunabout by tankbuster
if not (hasInterface) exitwith {diag_log "*** spawnrunabout exits because is not running on a player!"};
private ["_caller","_requestedpos","_spawnpos","_testradius","_runabout"];

_spawnpos = [0,0,0]; _testradius = 2;
while {_spawnpos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_spawnpos = [getpos player, 3,_testradius, 4, 0,0.5,0] call bis_fnc_findSafePos;
		_testradius = _testradius * 2;
	};

_runabout =  createVehicle ["B_Quadbike_01_F", _spawnpos, [], 0, "NONE"];





