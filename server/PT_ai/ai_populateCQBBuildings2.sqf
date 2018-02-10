//// by tankbuster
// tripwire mine system by almaniak
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
_nreadblds3 = ((_cqbcentrepos) nearObjects ["house", _cqbradius]) select {((count (_x buildingpos -1)) > 4)};
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
			/*if ((count _cqbbldposs1) > 10) then
				{
					_cqbbldposs1 resize 10;
				};*/
			_cqbbldposs1 resize (ceil (count _cqbbldposs1 /2));
			//diag_log format ["*** in building %1, a %2, there are %3 non roofed poses", _myblding, typeof _myblding, count _cqbbldposs1];
			// ^^^ all the non roof positions in the house
			{
				_cqbgrp = createGroup [east, true];
				_cqbman = _cqbgrp createUnit [(selectRandom opfor_CQB_soldier), _x, [],0,"NONE"];
				[_cqbman, true, true] call tky_fnc_tc_setskill;
				_cqbman dowatch (_cqbman getpos [10,(_cqbman getdir _myblding)]);
				//diag_log format ["*** cqbman spawned at %1", getpos _cqbman];
				for "_d" from 0 to 359 step 45 do
					{//find the view direction that isnt obscured by a building
						_curobsfactor = lineIntersectsObjs [eyePos _cqbman, ATLToASL (_cqbman getpos [10,_d]), objNull, _cqbman, true, 32];
						if (_curobsfactor isEqualTo []) then
							{
								//diag_log format ["*** fella at %1 in the %2 is going to look %3", getpos _cqbman, typeof _myblding, _d];
								_cqbman doWatch (_cqbman getpos [5, _d]);
							};
					};
			} foreach _cqbbldposs1;
		};
} foreach _nreadblds2;
diag_log format ["*** aicqb2 starts tripmine stuff"];
_elligableTripMineBuildings = [
["Land_i_House_Big_01_V2_F",[[[-0.8,-5.5,-2.5], - 90],[[4.5,5,-2.5], + 90]]],
["Land_u_House_Big_01_V1_F",[[[-0.8,-5.5,-2.5], - 90],[[4.5,5,-2.5], + 90]]],
["Land_i_House_Big_02_V2_F",[[[0,4,-2.5], 0],[[-2.5,-3,-2.5], 0]]],
["Land_i_House_Big_02_V1_F",[[[0,4,-2.5], 0],[[-2.5,-3,-2.5], 0]]],
["Land_Shed_02_F", [[[0,-1.0,-0.8],0]]],
["Land_Shed_05_F", [[[-0.4,1.4,-0.7],0]]],
["Land_House_Small_02_F", [[[0.6,-1.7,-0.5], +90],[[0.5,4.6,-0.5], +90]]],
["Land_House_Small_01_F", [[[4.2,3.4,-0.4], 0],[[1.1,-0.1,-0.4], +90]]],
["Land_House_Small_03_F", [[[-0.7,-2,-1],0 ],[[2.8,3.4,-1], 90]]],
["Land_House_Small_05_F", [[[0,-0.9,-0.7], 0],[[-3.6,0.7,-0.7], 90]]],
["Land_Slum_01_F", [[[-0.7,-0.7,1],90]]],
["Land_House_Small_06_F", [[[-4.2,-1.6,-0.7], 270], [[0.8,1.9,-0.7], 0]]],
["Land_Slum_03_F", [[[3.6,-1,-0.2], 0], [[-2.7,-1.23,-0.2],0]]],
["Land_House_Small_04_F", [[[2.4,-4.6,-0.7],0], [[-0.6,4.2,-0.7],0], [[-2.1,-0.6,-0.7], 90]]],
["Land_House_Big_01_F", [[[6,5.8,-0.8],0], [[2.8,-1.2,-0.8],0]]],
["Land_Shop_Town_03_F", [[[2.8,-6.,-3],0], [[-3.2,-6.1,-3],0] ,[[-3,7.7,-3],0]]],
["Land_Shop_Town_01_F", [[[0,-4.1,-3],0], [[-1.8,5.9,-3],0] ]]
];
AM_fnc_CreateMine = {
	params ["_building","_localPos","_dir"];
	_m = createMine ["APERSTripMine", (_building modelToWorld _localPos) ,[], 0];
	// Add mine to cleanup array;
	CQBCleanupArr pushBack _m;
	[_m, "mymine"] call fnc_setvehiclename;
	_minedir = ((getdir _building)+ _dir);
	[mymine, _minedir] remoteExec ["setdir"];
	_m
};
_currentTripMinesBuild = 0;
{
	// Array structure is [["Land_i_House_Big_01_V2_F",[[[-0.8,-5.5,-2.5], - 90],[4.5,5,-2.5], + 90]]];
	//                       classname			pos relative to building, dir relative to building
	_bdng = _x;
	{
		//diag_log FORMAT ["***populateCQBBuildings: checking house %1 for %2 is %3",(_x select 0), (typeOf _bdng), (_x select 0) isEqualTo (typeOf _bdng)] ;
		if ( (_x select 0) isEqualTo (typeOf _bdng) ) then
		{
			//diag_log format ["*** cqb2 tripmine found a %1", _x];
			{
				//diag_log FORMAT ["***populateCQBBuildings: Placing tripwire in %1 at %2 and %3", (typeOf _bdng), (_x select 0), (_x select 1)] ;
				if ((random 1) > 0.9) then
				{
					_m = [_bdng, _x select 0, _x select 1] call AM_fnc_CreateMine;
					//diag_log format ["*** cqb2 mine %1 is at %2, dir is %3", _m, getpos _m, getdir _m];
					//[getpos _m] execVM "server\Debug\debug_makemarker.sqf";
				};
			} forEach (_x select 1);
			_currentTripMinesBuild = _currentTripMinesBuild + 1;
		};
	} forEach _elligableTripMineBuildings;
} forEach _nreadblds3;
handle_ai_pcqb_finished = true;
__tky_ends
