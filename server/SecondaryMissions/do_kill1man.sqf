//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_kill1man";
__tky_starts;
private ["_1sttext","_kill1types","_mcode","_searchbuildings","_spawninsidehigh","_spawninsidelow","_spawnoutside","_spawnonroof","_mantokill","_unitinit","_insupports","_outsupports","_mtext","_targetman","_redtargets","_mytown","_tname","_tradius","_nearblds1","_nearblds0","_cblds1","_thisbld","_sof_bld_poss","_clbds2","_clbds1","_cblds2","_cblds3","_mybld","_mybldposs0","_mybldposs2","_mybldposs1","_mveh","_seldpos","_2ndtext","__tky_debug","_smk1mgrp","_mydude","_mandir","_mandist0","_3rdtext","_mandist1","_smcleanup", "_mybld2"];
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
_smcleanup = [];
_1sttext =  ["Locals report there is a ", "Freindly forces tell us there's a ", "Mobile phone intercepts show there might be a ", "Our forward forces observed a ", "Reports are coming in of a ", "Human gathered intel tells us there is a "];
_kill1types =
	[
		/*["missioncode",
			[buildings to use (array of classnames)],
			number of buildingposs to filter for, spawninsidehighflag, spawninsidelowflag, spawnoutsideflag, roofonlyflag << note that roof only must be exclusive
			[classnames of mantokill],"unitinit",
			["classnames of support units indoors"], << no more than 6 and man units only
			["classnames of support units outdoors"],
			["missiontextstrings"]
		]*/
		["cgl",
			["Land_FuelStation_Build_F", "Land_FuelStation_01_shop_F", "Land_FuelStation_01_workshop_F", "Land_FuelStation_02_workshop_F", "Land_GarageShelter_01_F", "Land_CarService_F"],
			6, false, true, false, false,
			["I_C_Soldier_Bandit_7_F"],"",
			[""],
			[""],
			"His activities are disturbing the fragile peace. Take him out"
		 ],
		["htg",
			["House_f"],
			6, false, true, false,false,
			["I_C_Soldier_Bandit_1_F"], "",
			["I_C_Soldier_Bandit_4_F"],
			[""],
			"He has been taking hostages for ransom. We need him taken out."
		],
		["eof",
			["Land_i_Barracks_V1_F"],
			20, false, true, false,false,
			["O_G_officer_F"], "",
			["O_G_Soldier_TL_F", "O_G_Soldier_AR_F","O_G_Soldier_AR_F","O_G_Soldier_AR_F","O_G_Soldier_AR_F", "O_G_medic_F", "O_G_Soldier_GL_F", "O_G_Soldier_GL_F"],
			["O_G_Offroad_01_armed_F", "O_APC_Wheeled_02_rcws_F", "O_G_Van_01_transport_F"],
			"He is thought to be planning a major counterattack in the North. Liquidate him, fast."
		],
		["sni",
			["House_f"],
			6, false, false, false, true,
			["O_T_Sniper_F"], "this setUnitPos 'DOWN'",
			["O_T_Spotter_F", "O_G_Soldier_AR_F","O_G_Soldier_AR_F","O_G_Soldier_AR_F", "O_G_medic_F"],
			[""],
			"He's been sniping civilians and our troops. He must be stopped quickly"
		],
		["bom",
			["Land_Warehouse_03_F", "Land_Warehouse_01_F", "Land_Warehouse_02_F", "Land_SCF_01_warehouse_F"],
			8,false, true, false, false,
			["I_G_Soldier_exp_F"], "",
			["I_G_Soldier_GL_F", "I_G_Soldier_GL_F","I_G_Soldier_GL_F","I_G_Soldier_GL_F", "I_G_medic_F"],
			[""],
			"He's a bombmaker we've tracked from the border. He needs to be taken out before he gets to work."
		],
		["esab",
			["Land_PowerLine_01_pole_transformer_F", "Land_PowerLine_01_pole_tall_F", "Land_HighVoltageTower_F", "Land_HighVoltageTower_large_F", "Land_PowLines_Transformer_F", "Land_spp_Transformer_F"],
			0,false, false, true, false,
			["I_C_Soldier_Para_8_F"], "",
			["I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_5_F"],
			["I_G_Offroad_01_armed_F", "I_G_Offroad_01_armed_F"],
			"This guy has already sabotaged some of the island electrical infrastructure and we believe he's going to continue. Stop him, permanently."
		]
	];
_blacklistedbuildings = ["Land_SCF_01_heap_bagasse_f", "land_slum_01_f", "land_slum_03_f",  "land_pierwooden_02_16m_f", "land_pierwooden_02_barrel_f", "land_pierwooden_02_ladder_f"];
// ^^^ note blacklisted buildings cannot be a base case.
//submissiondata = selectRandom _kill1types;
submissiondata = _kill1types select 3;
submissiondata params ["_mcode", "_searchbuildings","_bposthreshold" "_spawninsidehigh", "_spawninsidelow", "_spawnoutside", "_spawnonroof", "_mantokill", "_unitinit", "_insupports", "_outsupports", "_mtext"];
{
diag_log format ["***submissiondata %1, %2", _foreachindex, _x];
}foreach submissiondata;

_targetman = selectRandom _mantokill;
_redtargets = (cpt_position nearEntities ["Logic", 4000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {((_x distance2d cpt_position) > 700 and ((_x getVariable ["targetlandmassid", -1]) isEqualTo cpt_island))} };
//^^^ get nearby enemy towns between 700m and 5km away that are not blu town and on the same island
_mytown = selectRandom _redtargets;
// ^^^ select 1 at random
_tname = _mytown getVariable ["targetname", "Springfield"];
_tradius = _mytown getVariable ["targetradius", 125];
diag_log format ["*** dk1m chooses %1", _tname ];
_nearblds1 = nearestTerrainObjects [_mytown, ["house"],8000, false, true];
diag_log format ["*** dtk1m finds %1 'houses' ", count _nearblds1];
// ^^^ got some terrain objects,now filter it found our wanted building types
_cblds1 = [];// <<candidatebuildings1
_cblds2 = [];
{
	private ["_thisbld"];
	_thisbld = _x;
	{
	if ((_thisbld isKindOf _x) and {(not ((typeof _thisbld) in _blacklistedbuildings)) and (count (_thisbld buildingpos -1) > _bposthreshold ) and (abs( (boundingBoxReal _thisbld select 1 select 2) - (boundingBoxReal _thisbld select 0 select 2)) > 3) }) then
		{
		_cblds1 pushBack _thisbld;
		//diag_log format ["***dk1m loop _searchbuildings says %1 is in the _searchbuildings array, entry %2", _thisbld, _x ];
		};
	} foreach _searchbuildings;
} foreach _nearblds1;
//^^^ cblds1 buildings in our list of classes
diag_log format ["***dk1m has %1 candidate buildings to choose from were in the required class", count _cblds1];
if (_spawnonroof) then
	{
		{// keep only the buildings that have roof positions
		_mybld2 = _x;
		_sof_bld_poss = (_mybld2 buildingPos -1);// the buildingpositions of this building
		//diag_log format ["*** dk1m has building %1 at %2  and is going to send this array of positions to inhouse %3", _mybld2, getpos _mybld2, _sof_bld_poss];
			{
			//sleep 0.5;

			if (((count _x) > 2) and {(_x select 2) > 6} ) then //is it a real position array? for some reason, it gets passed [] sometimes, if it is, is it at least a 1s floor?
				{
					if ([ATLToASL _x] call tky_fnc_inhouse)  then
						{
						//diag_log format ["inhouse says %1 is indoors, building %2 ", _x, _mybld2];
						_donothing = true;//I think youre not allowed to have an empty block in a then statement and have just remarked out the diaglog above
						}
						else
						{// if the tested position is outside ie, on a roof
						diag_log format ["%1 in building %2 is outdoors and has saved the building for use as a sniper pos", _x, _mybld2];
						_cblds2 pushBackUnique _mybld2;// should be buildings that have roof positions higher than 6m
						};
				};
			} foreach _sof_bld_poss;
		}foreach _cblds1;
	} else
	{
	_cblds2 = _cblds1 select { (_spawnoutside) or ( ( (count (_x buildingPos -1 ) ) > 6) and (_spawninsidelow or _spawninsidehigh) and (not ((_x buildingExit 0)  isEqualTo [0,0,0]) ) )};
	};

///^^^cblds2 = buildings that conform to spawn hi/low/outside criteria & removes buildings with less than 5 poss as these are small or have only 'porch' positions & are actualy unenterable OR if spawnonroof, array will contain only blds with roof positions
diag_log format ["*** dk1m says _cblds2 is %1", _cblds2];
diag_log format ["*** dk1m has %1 useable buildings (ie, have enough interior positions)", count _cblds2];
_cblds3 = [_cblds2, [] , {_mytown distance2D _x}, "ASCEND"] call BIS_fnc_sortBy;
diag_log format ["*** _cblds3 is %1",_cblds3];
_mybld = (_cblds3 select 0);
//^^^ take the nearest building to the remote town
_mybldposs0 = (_mybld buildingPos -1);
diag_log format ["*** dk1m chooses %1 at %2, which is a %3, screenname %4 and has %5 positions", _mybld, getpos _mybld, typeOf _mybld, [(_mybld)] call tky_fnc_getscreenname, count _mybldposs0];
//_mybldposs2 = _mybldposs0 select { _x call tky_fnc_inhouse }; // take only the ones indoors. this isnt very good at flitering out porches, unfort. its also broken, so removed.
if ( not _spawnonroof) then
	{
	_mybldposs1 = _mybldposs0 select {( not ([_x] call tky_fnc_inhouse))};
	diag_log format ["*** dk1m removed roofs and has %1", _mybldposs1];
	}else
	{
	_mybldposs1 = _mybldposs0;
	diag_log format ["***dk1m roofs ok and has %1", _mybldposs1];
	};
// ^^^ if not spawnonroof, then remove all roof positions
_mybldposs2 = [_mybldposs1 , [], {_x select 2}, "ASCEND" ] call BIS_fnc_sortBy; // sort them by altitude, lowest first,
{
	_mveh = createvehicle ["Sign_Arrow_f", _x, [],0,"CAN_COLLIDE"];
} foreach _mybldposs2;
if (_spawninsidehigh and {_spawninsidelow}) then
	{
	_seldpos = selectRandom _mybldposs2;
	_2ndtext = " somewhere in the ";
	};
if (_spawninsidehigh and {not _spawninsidelow}) then
	{
	_seldpos = _mybldposs2 select ( count _mybldposs2 - (ceil random 4) );
	_2ndtext = " inside the ";
	};// will select last, 2nd tolast or third to last
if ((not _spawninsidehigh) and {_spawninsidelow}) then
	{
	_seldpos = _mybldposs2 select (floor (random 3));
	_2ndtext = " in the ";
	};//will select 1st,2nd or 3rd  bpos
if (_spawnoutside) then
	{
	_seldpos = [_mybld, 3, 20, 3,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_2ndtext = selectRandom [" in the vicinity of ", " near the ", " not far from the ", " around the ", " a short distance from the "];
	 };
if (_spawnonroof) then
	{
	_seldpos = _mybldposs2 select ( count _mybldposs2 - (ceil random 2));// select one of the last two positions
	_2ndtext = " on the roof of ";
	};

__tky_debug;
diag_log format ["*** high %1, low %2, outside %3, roof %4 actualpos = %5", _spawninsidehigh, _spawninsidelow, _spawnoutside, _spawnonroof, _seldpos];
_smk1mgrp = createGroup east;
_unitinit = "sk1mguy = this;" + _unitinit;

_targetman createUnit [_seldpos, _smk1mgrp, _unitinit, 0.6, "corporal"];
sk1mguy allowdamage false;
sk1mguy setpos _seldpos;
_smcleanup pushback sk1mguy;
_mybldposs2 = _mybldposs2 - ["_seldpos"];// remove the used position from the array of positions, just in case we need to put further units in the same building
diag_log format ["*** sk1mguy is at %1, spawned at %2", getpos sk1mguy, _seldpos];
sleep 3;
sk1mguy allowdamage true;

if ((count _insupports) > 0 ) then
	{
	_supportbldposs = +_mybldposs2;
		{
		_suppos = selectRandom _supportbldposs;
		_supportbldposs = _supportbldposs - [_suppos];
		_isman = _smk1mgrp createUnit [_x, _suppos, [], 0, "NONE"];
		_smcleanup pushback _isman;
		} foreach _insupports;
	};// ^^^ if insupports provided, spawn them

if ( (count _outsupports) > 0 ) then
	{
		{
		_ostype = _x;
		if (_ostype isKindOf "LandVehicle") then
			{
			_ospos = [_mybld, (sizeof _mybld), 500, 8 ,0,0.5,0,1,1] call tky_fnc_findSafePos;
			_ret = [_ospos, (_ospos getdir alpha_1), _ostype, _smk1mgrp] call BIS_fnc_spawnVehicle;
			_smcleanup pushBack (_ret select 0);
			}
			else
			{//assume its a man unit
			_ospos = [_mybld, (sizeof (typeof _mybld)), 500, 3 ,0,0.5,0,1,1] call tky_fnc_findSafePos;
			_osman = _smk1mgrp createUnit [_x, _ospos, [],0, "NONE"];
			_smcleanup pushback _osman;
			};
		}forEach _outsupports;



	};
_mandir = [(_mytown getDir _mybld)] call tky_fnc_cardinaldirection;
_mandist0 = floor (_mybld distance2D _mytown);

if (_mandist0 < 50) then {_3rdtext = "in the middle of " + _tname;};
if ( (_mandist0 >= 50) and (_mandist0 < _tradius ) )then {_3rdtext = " in the "+ _mandir + "ern quarter of " + _tname;};// <<< get the town radius & the cardinal direction so we can say "in the northern quarter of"
_mandist1 = str ([_mandist0, 100] call tky_fnc_estimateddistance);
if (_mandist0 >= _tradius) then {_3rdtext = _mandist1 +"m" + _mandir + " of " + _tname + " "};
diag_log format ["1sttext %1", _1sttext];
diag_log format ["sk1mguy %1", [sk1mguy] call tky_fnc_getscreenname];
diag_log format ["_2ndtext %1", _2ndtext];
diag_log format ["_mybld %1", [_mybld]  call tky_fnc_getscreenname];
diag_log format ["_3rdtext %1", _3rdtext];
diag_log format ["_mtext %1,", _mtext];

smmissionstring = (selectRandom _1sttext) + ([sk1mguy] call tky_fnc_getscreenname) + _2ndtext +  ([_mybld] call tky_fnc_getscreenname) + " " + _3rdtext + _mtext;

smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";

failtext = "Dudes. You suck texts";

while {missionactive} do
	{
	sleep 3;
	if (FALSE) then
		{
		missionsuccess = false;
		missionactive = false;
		};

	if (not alive sk1mguy) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
