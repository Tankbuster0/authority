//// by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_populatecqbbuildings2";
__tky_starts
params [
	["_cqbcentrepos", cpt_position],
	["_cqbradius", cpt_radius],
	["_amount", 0.2],// chance each building will be populated
	["_scalebyplayercount", false]// if true, number of poss in each house is playercount * 2
	];
private ["_nreadblds"];

_nreadblds = (nearestTerrainObjects [_cqbcentrepos, ["house", "church", "chapel", "lighthouse", "fuelstation", "fortress"], _cqbradius, false, true]) select {(count ( _x buildingpos -1))< 4};
// ^^ all the houses with more than 4 buildingposs

diag_log format ["*** pcqb2 finds %1 buildings with more than 4 poss", count _nreadblds];

{
	_myblding = _x;
	if ((random 1) < _amount) then
		{
			_cqbbldposs = (_myblding buildingPos -1) select {[atltoasl _x] call tky_fnc_inhouse};
			// ^^^ all the non roof positions in the house
			{
				_cqbgrp = createGroup ["east", true];
				_cqbman = _cqbgrp createUnit [(selectRandom opfor_CQB_soldier), _x, [],0,"NONE"];
				for "_d" from 0 to 359 step 45 do
					{//find the view direction that isnt obscured by a building
						_curobsfactor = lineIntersectsObjs [eyePos _cqbman, ]



					}


			} foreach _cqbbldposs;

		};



} foreach _nreadblds;





__tky_ends
