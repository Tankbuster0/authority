//fnc_spawnrunabout by tankbuster
if not (hasInterface) exitwith {diag_log "*** spawnrunabout exits because is not running on a player!"};
private ["_caller","_requestedpos","_spawnpos","_testradius","_runabout"];


params [
["_target", player], //
["_caller", player] //

];

_requestedpos = getpos _caller;
_spawnpos = [0,0,0]; _testradius = 3;
while {_spawnpos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_spawnpos = [_requestedpos, 3,_testradius, 4, 0,50,0] call bis_fnc_findSafePos;
		_testradius = _testradius * 2;
	};

_runabout =  createVehicle ["CUP_B_M1030", _spawnpos, [], 0, "NONE"];




