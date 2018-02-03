//// by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_populatecqbbuildings2";
__tky_starts
params [
	["_cqbcentrepos", cpt_position],
	["_cqbradius", cpt_radius],
	["_amount", 0.66],// chance each building will be populated
	["_scalebyplayercount", false]// if true, number of poss in each house is playercount * 2
	];
private ["_nreadblds1","_nreadblds2","_cqbcentrepos","_cqbradius","_myblding","_amount","_cqbbldposs","_cqbgrp","_cqbman","_d","_curobsfactor"];
_nreadblds1 = ((_cqbcentrepos) nearObjects ["house", _cqbradius]) select {((count (_x buildingpos -1)) > 6)};
if ((count _nreadblds1) < 8) then
	{
		_nreadblds1 = ((_cqbcentrepos) nearObjects ["house", _cqbradius + 15]) select {((count (_x buildingpos -1)) > 4)};
		diag_log format ["***pcqb2 got few buildings to populate, so increased radius and allowed smaller buildings"];
	};
diag_log format ["*** found %1 blds have enough poses ", count _nreadblds1];
_nreadblds2 = _nreadblds1 call BIS_fnc_arrayShuffle;
if (count _nreadblds2 > 20) then
	{
		_nreadblds2 resize 20;
	};
{
	_myblding = _x;
	if ((random 1) > _amount) then
		{
			_cqbbldposs = (_myblding buildingPos -1) select {[atltoasl _x] call tky_fnc_inhouse};
			_cqbbldposs1 = _cqbbldposs call BIS_fnc_arrayShuffle;
			if ((count _cqbbldposs1) > 20) then
				{
					_cqbbldposs1 resize 20;
				};
			diag_log format ["*** in building %1, a %2, there are %3 non roofed poses", _myblding, typeof _myblding, count _cqbbldposs1];
			// ^^^ all the non roof positions in the house
			{
				_cqbgrp = createGroup [east, true];
				_cqbman = _cqbgrp createUnit [(selectRandom opfor_CQB_soldier), _x, [],0,"NONE"];
				[_cqbman, true, true] call tky_fnc_tc_setskill;
				_cqbman dowatch (_cqbman getpos [10,(_myblding getdir _cqbman)]);
				diag_log format ["*** cqbman spawned at %1", getpos _cqbman];
				for "_d" from 0 to 359 step 45 do
					{//find the view direction that isnt obscured by a building
						_curobsfactor = lineIntersectsObjs [eyePos _cqbman, ATLToASL (_cqbman getpos [10,_d]), objNull, _cqbman, true, 32];
						if (_curobsfactor isEqualTo []) then
							{
								diag_log format ["*** fella at %1 in the %2 is going to look %3", getpos _cqbman, typeof _myblding, _d];
								_cqbman doWatch (_cqbman getpos [5, _d]);
							};
					};
			} foreach _cqbbldposs1;
		};
} foreach _nreadblds2;
handle_ai_pcqb_finished = true;
__tky_ends
