//// by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_populatecqbbuildings2";
__tky_starts
params [
	["_cqbcentrepos", cpt_position],
	["_cqbradius", cpt_radius],
	["_amount", 0.2],
	["_scalebyplayercount", false]
	];
private ["_nreadblds"];

_nreadblds = (nearestTerrainObjects [_cqbcentrepos, ["house", "church", "chapel", "lighthouse", "fuelstation", "fortress"], _cqbradius, false, true]) select {(count ( _x buildingpos -1))< 4};






__tky_ends
