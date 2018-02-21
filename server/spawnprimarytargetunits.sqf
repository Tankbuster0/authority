//by tankbuster
#include "..\includes.sqf"
_myscript = "spawnprimarytargetunits";
__tky_starts;
handle_spt_finished = false;
private ["_currentprimarytarget","_pt_pos","_pt_radius","_pt_type","_pt_name","_lc","_microtown","_start","_composition","_allcompositionunits","_compgrp","_plt","_blah","_obs","_cplines","_linenames","_stname","_namewithoutid","_mbus","_boatdir","_boatpos","_myboat","_linea","_linebx","_lineb","_carposx","_carposy","_mycar","_spawndir","_count","_staticgrpname","_mypos","_mydir","_staticgrp","_veh","_mgunner","_patrolinf","_staticveh","_patrolveh","_statictanks","_removeenemyvests","_mygroup","_nearblufors","_mygunner","_artytarget","_iroa","_aeta","_amags","_aka","_townroadsx","_townroads","_civcount","_fciv","_civfootgroup","_pos","_cfunit","_ssman1","_d","_dcar","_dcarcount","_dcargroup","_roadnogood","_road1","_objs","_road2","_dir","_unit","_crewcount","_ii","_unit2","_roadposarray","_null","_pcar","_pcarcount","_nb"];
_currentprimarytarget = _this select 0;// receives a logic
_pt_pos = getpos _currentprimarytarget;
_pt_radius = (_currentprimarytarget getVariable "targetradius");
_pt_type = (_currentprimarytarget getVariable "targettype");
_pt_name = (_currentprimarytarget getVariable "targetname");
_lc = (_pt_radius /75); //scales spawn levels according to radius
if (_pt_radius isEqualTo 75) then {_microtown = true} else {_microtown = false};
_start = ["enemyspawnlevel", 2] call BIS_fnc_getParamValue;//default is 2
if ((_start == 3) and (_pt_radius == 150)) then {_start = 2};
_pt_radius = _pt_radius - 50;
__tky_debug
if ((worldname in ["Altis", "altis", "Tanoa", "tanoa"]) and (_pt_type == 2)) then
	{
	switch (_pt_name) do
		{
		case "AAC airfield": {_composition = aaccomposition};
		case "Abdera airfield": {_composition = abderacomposition};
		case "Feres airfield": {_composition = ferescomposition};
		case "Molos Airfield":{_composition = moloscomposition};
		case "Aéroport de Tanoa": {_composition = aeroporto_de_tanoa_compostion};
		case "Saint-George Airstrip": {_composition = st_george_composition};
		case "La Rochelle Aerodrome": {_composition = la_rochelle_composition};
		case "Bala Airstrip": {_composition = bala_composition};
		case "Tuvanaka Airbase": {_composition = tuvanaka_composition};
		case "Arnoldstein Airport": {composition = arnold_composition};
		case "Airport Lesce": {composition = lesce_composition};
		case "Airbase Boriana": {composition = boriana_composition};
		case "Maleficio Grass Strip": {composition = maleficio_composition};
		case "Airport Vatra": {composition = vatra_composition};
		case "Airport Fortieste": {composition = fortieste_composition};
		};
	_allcompositionunits = [_pt_pos, 0, _composition] call tky_fnc_t_objectsmapper;
	_compgrp = creategroup [east, true];
	sleep 0.05;
	__tky_debug
	{
		if (_x isKindOf "Air" and {faction _x in ["OPF_T_F", "OPF_F", "OPF_G_F"]} ) then
			{
			_plt = _compgrp createUnit ["O_survivor_F", [0,0,0], [],0, "NONE"];
			_plt moveInDriver _x;
			_plt assignAsDriver _x;
			_plt disableAI "All";
			_plt setdamage 0.9;
			_plt hideObjectGlobal true;
			_x setUnloadInCombat [false, false];
			_x setVehicleLock "LOCKED";
			_x setfuel 0;
			};
			if ((_x isKindOf "LandVehicle") or (_x isKindOf "Air")) then
				{
					[_x] call tky_fnc_initvehicle;
				};
	}foreach _allcompositionunits;
	}
	else
	{
	_allcompositionunits = [];
	};
_obs = nearestObjects [_pt_pos, [], (_pt_radius + 200), true];
_obs = _obs - allMissionObjects "All";
_cplines = [];
__tky_debug
_linenames = ["rd_line_5m.p3d", "runway_01_centerline_5m_f.p3d", "decal_white_line_f.p3d"];
{
	if (not ((typeOf _x) isEqualTo "EmptyDetector")) then
	{

		_stname = str _x;
		_namewithoutid = [_x] call tky_fnc_stripidandcolonandspace;
		if (((count _stname) > 12) and {_namewithoutid in _linenames} ) then
			{// get lines used for carparks
			_cplines pushBack _x;
			};
		if (((count _stname) > 12) and {_namewithoutid in  ["rd_taxi.p3d", "rd_busstop.p3d"] } ) then
			{
			if (((random 1) > 0.3) and {(_x nearObjects ["car_f", 6]) isEqualTo []}) then
				{
				_mbus = createvehicle ["C_Van_02_transport_F", getpos _x, [],0, "CAN_COLLIDE" ];
				_mbus setdir ( (getdir _x ) + 90);
				[_mbus] call tky_fnc_initvehicle;
				};
			};
		// put boats in some port objects
		if (_namewithoutid in boatspawnobjs)   then
		{
			switch (_namewithoutid) do
				{
					case "pierconcrete_01_steps_f.p3d": {_boatdir = (getdir _x); _boatpos = [-7,-3,4];};
					case "pierconcrete_01_4m_ladders_f.p3d": {_boatdir = (getdir _x); _boatpos = [9,0,3];};
					case "pierwooden_02_ladder_f.p3d": {_boatdir = ((getdir _x) - 90), _boatpos = [0,4.5,18];};
					case "pierwooden_01_dock_f.p3d": {_boatdir = (getdir _x); _boatpos = [1.5,2,6];};
					case "pierwooden_01_hut_f.p3d": {_boatdir = ((getdir _x) + 90); _boatpos = [1,2,17];};
					case "pierwooden_03_f.p3d": {_boatdir = (getdir _x); _boatpos = [-1.6,6,19];};
					case "canal_dutch_01_stairs_f.p3d": {_boatdir = ((getdir _x ) + 90); _boatpos = [0,-11,4];};
					case "pier_small_f.p3d": {_boatdir = (getdir _x);  _boatpos =  [3.5,0,2];};
					case "canal_wall_stairs_f.p3d": {_boatdir = (getdir _x); _boatpos = [0,-4.2,0];};
					case "pier_addon_f.p3d": {_boatdir = selectRandom [((getdir _x) - 90), ((getdir _x) + 90)]; _boatpos = [0,3,-2];};
				};
			if ( ( (getTerrainHeightASL (_x modelToWorldWorld _boatpos)) < -1 ) and {(random 1) > 0.5}) then //is the water deep enough and we are randomly going to make a boat
			{
				if (random 1 > 0.5 ) then
					{
						_myboat = createvehicle ["O_Boat_Armed_01_hmg_F", [0,0,0], [],0,"NONE"];
						_myboat allowDamage false;
						_myboat setdir _boatdir;
						sleep 0.2;
						_myboat setPosWorld (_x modelToWorld _boatpos);
						if (random 1 > 0.5) then {createVehicleCrew _myboat};
						sleep 1;
						_myboat allowDamage true;
					}
					else
					{
						_myboat = createvehicle [selectRandom ["C_Boat_Civil_01_f", "C_Boat_Civil_01_rescue_F", "C_Boat_Civil_01_police_F", "C_Boat_Transport_02_F", "C_Scooter_Transport_01_F"], [0,0,0], [],0,"NONE"];
						_myboat allowDamage false;
						_myboat setdir _boatdir;
						sleep 0.2;
						_myboat setPosWorld (_x modelToWorld _boatpos);
						sleep 1;
						_myboat allowDamage true;
						[_myboat] call tky_fnc_initvehicle;
					};
			};
		};
	};
} foreach _obs;
{// park some empty civ cars in car parks
_linea = _x;
_linebx = _cplines select {(_linea distance2d _x) < 4.95};
if ((count _linebx) > 0) then
	{
	_lineb = _linebx select 0;
	if ((_lineb distance2d _linea > 3) and {(floor (getdir _linea)) isEqualTo (floor (getdir _lineb))}) then
		{;
		_carposx = (((getpos _linea) select 0) + ((getpos _lineb) select 0)) /2;
		_carposy = (((getpos _linea) select 1) + ((getpos _lineb) select 1)) /2;
		if ( ((random 1) > 0.5) and {([_carposx, _carposy,0] nearObjects ["Car", 5]) isEqualTo []} ) then
			{
			_mycar = createvehicle [(selectRandom civcars), [_carposx, _carposy, 1.7], [],0,"CAN_COLLIDE"];
			[_mycar] call tky_fnc_initvehicle;
			if ((random 1) > 0.5) then
				{
				_mycar setdir (getdir _linea);
				}
				else
				{
				if ((getdir _linea) < 180) then {_spawndir = 180 + (getdir _linea)} else {_spawndir = 180 - (getdir _linea)};
				_mycar setdir _spawndir;
				};
			sleep 0.02;
			};
		};
	};
} foreach _cplines;
__tky_debug
mortar_gunners = [];
for "_count" from _start to _lc do
{
	sleep 0.05;
	_staticgrpname = format ["staticgrp%1", _count];
	// statics start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_mydir = _pt_pos getdir _mypos;
	__tky_debug
	switch ((floor (random 5))) do
		{
		case 0: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "O_static_AT_F", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 1: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam_AA")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "O_static_AA_F", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 2: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "O_static_AT_F", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 3: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "O_HMG_01_high_F", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 4: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "O_GMG_01_high_F", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		};
	__tky_debug
	if (diag_fpsmin < 10) then {diag_log format ["*** tky throttling %1 at %2 because fpsmin is %3",(__FILE__ select [(21 + (count worldName)), ((count __FILE__) - 4)]), __LINE__, diag_fpsmin ]; sleep 0.5;};
	nul = [_staticgrp, _pt_pos] call bis_fnc_taskDefend;// defending infantry group
	_mypos = [_pt_pos, 0, _pt_radius, 3,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_mydir = _pt_pos getdir _mypos;
	_veh = createVehicle ["O_Mortar_01_F", _mypos, [],0,"NONE"];
	_veh setdir _mydir;
	_mgunner = _staticgrp createUnit ["O_support_Mort_F", _mypos,[],0,"NONE"];
	_mgunner moveInGunner _veh;
	_mgunner assignAsGunner _veh;
	mortar_gunners pushback gunner _veh;
	group (gunner _veh) setCombatMode "RED";

	nul = [_staticgrp, _pt_pos] call bis_fnc_taskDefend;// defending mortar groupa
	sleep 0.05;
	// statics end
	// patrolling infantry start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,0.5,0,1,1] call tky_fnc_findSafePos;
	switch ((floor (random 4))) do
		{
		case 0: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;};
		case 1: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;};
		case 2: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_ReconSquad")] call BIS_fnc_spawnGroup;};
		case 3: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam_MG")] call BIS_fnc_spawnGroup;};
		};
	__tky_debug
	if (diag_fpsmin < 10) then {diag_log format ["*** tky throttling %1 at %2 because fpsmin is %3",(__FILE__ select [(21 + (count worldName)), ((count __FILE__) - 4)]), __LINE__, diag_fpsmin ]; sleep 0.5;};
	nul = [_patrolinf, _pt_pos, (_pt_radius / 2)] call BIS_fnc_taskpatrol;
	// patrolling infantry end
	sleep 0.05;
	// static IFV/ apc start
	_mypos = [_pt_pos, 0, _pt_radius, 5,0,0.5,0,1,1] call tky_fnc_findSafePos;

		_veh = selectRandom opforstaticlandvehicles;
		_staticveh = [_mypos, east, [_veh, "O_Soldier_SL_F", "O_Soldier_AT_F", "O_Soldier_GL_F"]] call BIS_fnc_spawngroup;
__tky_debug
	sleep 0.05;
	// patrolling  apc /ifv group start
	if not (_microtown) then
		{
		 _mypos = [_pt_pos, 0, _pt_radius, 5,0,0.5,0,1,1] call tky_fnc_findSafePos;
		_veh = selectRandom opforpatrollandvehicles;
		_patrolveh = [_mypos, east, [_veh, "O_Soldier_SL_F", "O_Soldier_AT_F", "O_Soldier_GL_F"]] call BIS_fnc_spawngroup;
		nul = [_patrolveh, _pt_pos, (_pt_radius /2)] call BIS_fnc_taskpatrol;
		};
	// patrolling  apc/ifv group end
	sleep 0.05;
	//heavy armour and shit start
	if ((_pt_type isEqualTo 1) and (cpt_radius > 150)  and ((random 5) > 3)) then //tanks only spawn at big towns, not at bases or airfields
	{
		_mypos = [_pt_pos, 0, _pt_radius, 5,0,0.5,0,1,1] call tky_fnc_findSafePos;
		_veh = selectRandom opfortanks;
		_statictanks = [_mypos, east, [_veh, _veh], [[0,10,0], [5,0,0]] ]call BIS_fnc_spawngroup;
		sleep 0.05;
	};
	//heavy armour end
	sleep 0.05;
if (diag_fpsmin < 10) then {diag_log format ["*** tky throttling %1 at %2 because fpsmin is %3",(__FILE__ select [(21 + (count worldName)), ((count __FILE__) - 4)]), __LINE__, diag_fpsmin ]; sleep 0.5;};
// add them all to cleanup arrays
__tky_debug
	{
	if (_x isKindOf "Man") then {mancleanup pushback _x} else {vehiclecleanup pushback _x};
	if ((_x isKindOf "Man") and (vehicle _x == _x)) then {vehiclecleanup pushback (vehicle _x) };
	sleep 0.02;
	 }foreach ((units _staticgrp) + (units _patrolinf) + (units _patrolveh) );
};
_removeenemyvests = ["removeenemyvests",0] call BIS_fnc_getParamValue;
__tky_debug
{
	if ((side _x) isEqualTo east) then
		{
			_mygroup = _x;
			{
				[_mygroup, true, true] call tky_fnc_tc_setskill;
				if ((_removeenemyvests > 0) and {(random 1) > 0.2}) then
				{
					removeVest _x;
					_x setDamage 0.5;
					_x removeItems "FirstAidKit";
				};
			} foreach units _mygroup;
		};
} foreach allgroups;
__tky_debug
	{
		[_x, [0.17,0.17,0.60,0.40,1,1,0.40,0.50,1,0.50], false,0] call tky_fnc_tc_setskill;
		// ^^^ mortar gunners have best spotdistance and spottime
		[_x] spawn // mortar gunner helper
			{
				private ["_nearblufors", "_mygunner", "_artytarget", "_iroa", "_aeta", "_amags", "_aka"];
				_mygunner = _this select 0;
				while {(alive _mygunner) and ("8Rnd_82mm_Mo_shells" in (getArtilleryAmmo [(vehicle _mygunner)]))} do

					{
					sleep 120 + (60 * random 10) ;
					_nearblufors = ((position _mygunner) nearEntities ["B_Soldier_base_f", 400]) select {(side _x) == west} ;
					if ((count _nearblufors) > 0) then
						{
						_artytarget = (selectRandom _nearblufors);
						_mygunner reveal [_artytarget, 3];
						_mygunner doArtilleryFire [(position _artytarget), "8Rnd_82mm_Mo_shells", 1 ];
						};
					};

			};
	} foreach mortar_gunners;
	__tky_debug
//createcivilians
if (_pt_type isEqualTo 1) then
	{
		//civs on foot
		_townroadsx = _pt_pos nearRoads (_pt_radius + 75);// road find radius needs to be bigger than normal radius

		if (count _townroadsx < 1) then {_townroadsx = _pt_pos nearRoads 125};
		_townroads = _townroadsx call BIS_fnc_arrayShuffle;
		_civcount = (1 * _lc);
		_fciv = [];
		while {count _townroads < _civcount} do {_townroads append _townroads};
		for "_i" from 1 to _civcount do
			{
			sleep 0.05;
			_civfootgroup = format ["civftgrp%1", _i];
			_civfootgroup = createGroup civilian;
			_pos = getpos (selectRandom _townroads);
			_cfunit = _civfootgroup createUnit [(selectRandom civs), _pos, [],0,"NONE"];
			_cfunit addEventHandler ["killed", {if ((_this select 2) isKindOf "SoldierWB") then {nul = execVM "server\playerkilledciv.sqf"}}];
			_cfunit addEventHandler ["killed", {if (([_this select 0, true] call BIS_fnc_objectSide) isEqualTo west) then
						{
						civkillcount = civkillcount +1;
						if (testmode) then {diag_log format ["civilian killed by %1", name _this select 0 ]};
						};
					}
				];
			nul = [_cfunit, (str primarytargetcounter)] execVM "server\UPS.sqf";
			_fciv pushback _civfootgroup;
__tky_debug
			};
		if ((random 10) > 4) then //suicide bomber stuff
			{
			ssbgrp1 = createGroup [east, true];
			_ssman1 = ssbgrp1 createUnit ["O_SoldierU_unarmed_F", _pt_pos, [],0,"NONE" ];
			removeAllWeapons _ssman1;
			removeUniform _ssman1;
			removeHeadgear _ssman1;
			removeVest _ssman1;
			_ssman1 forceAddUniform (selectRandom ["U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poor_1", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_redwhite", "U_C_man_sport_1_F", "U_C_Man_casual_6_F"]);
			_ssman1 addHeadgear (selectRandom ["H_Cap_red", "H_Cap_blu", "H_Cap_headphones", "H_StrawHat", "H_Hat_blue", "H_Hat_brown"]);
			_d = [_ssman1, 200, 100] call Saro_fnc_bomber;
			};
		//driven cars
		__tky_debug
		_dcar = [];
		_dcarcount = (1 * _lc);
		for "_i" from 1 to _dcarcount do
			{
			sleep 0.05;
			_dcargroup = format ["civcrgrp%1", _i];
			_dcargroup = createGroup civilian;
			_roadnogood = true;
			while {_roadnogood} do // make sure the roadpiece chosen doesn't already have a car on it.
				{
				_road1 = (selectRandom _townroads);
				_objs = (getpos _road1) nearEntities ["LandVehicle",7];
				if (((count _objs) < 1) and (count (roadsConnectedTo _road1) > 1 ))  then {_roadnogood = false};
				};
			_road2 = (roadsConnectedTo _road1) select 0;
			_dir = _road1 getdir _road2;
			_veh = createVehicle [(selectRandom civcars), (getpos _road1), [],0,"NONE"];
			_veh setdir _dir;
			[_veh] call tky_fnc_initvehicle;
			_unit = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
			_unit addEventHandler ["killed", {if (([_this select 0, true] call BIS_fnc_objectSide) isEqualTo west) then
						{
						civkillcount = civkillcount +1;
						if (testmode) then {diag_log format ["civilian killed by %1", name _this select 0 ]};
						};
					}
				];
			_cfunit addEventHandler ["killed", {if ((_this select 2) isKindOf "SoldierWB") then {nul = execVM "server\playerkilledciv.sqf"}}];
			_unit assignAsDriver _veh;
			_unit moveInDriver _veh;
			nul = [_unit, (str primarytargetcounter)] execVM "server\UPS.sqf";
			_crewcount = [(typeof _veh), true] call BIS_fnc_crewCount;
			for "_ii" from 1 to (random _crewcount) do
				{
				sleep 0.05;
				_unit2 = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
				_unit2 addEventHandler ["killed", {if (([_this select 0, true] call BIS_fnc_objectSide) isEqualTo west) then
						{
						civkillcount = civkillcount +1;
						if (testmode) then {diag_log format ["civilian killed by %1", name _this select 0 ]};
						};
					}
				];
				_cfunit addEventHandler ["killed", {if ((_this select 2) isKindOf "SoldierWB") then {nul = execVM "server\playerkilledciv.sqf"}}];
				_unit2 moveInAny _veh;
				};
			_dcar pushback _dcargroup;
			};
			__tky_debug
		_roadposarray = [];
		{_roadposarray pushback (getpos _x)} foreach _townroads;
		_null = [_fciv, _dcar, _roadposarray] execVM "server\cosPatrol.sqf";//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		__tky_debug
		_pcar = [];
		_pcarcount = (2 * _lc);
		if !(_microtown) then
			{
				__tky_debug
			for "_i" from 1 to _pcarcount do
				{
				sleep 0.05;
				_roadnogood = true;
				while {_roadnogood} do // make sure the roadpiece chosen doesn't already have a car on it.
					{
					_road1 = (selectRandom _townroads);
					_objs = (getpos _road1) nearEntities ["LandVehicle",7];
					if (((count _objs) < 1) and (count (roadsConnectedTo _road1) == 2))  then {_roadnogood = false};
					};
				_veh = createVehicle [(selectRandom civcars), (getpos _road1), [],0, "NONE"];
				[_veh] call tky_fnc_initvehicle;
				_nb = nearestBuilding _veh;
				__tky_debug
				if ((_veh distancesqr _nb) > 3.1) then
					{_dir = (_veh getdir ((roadsConnectedTo _road1) select 0));}
					 else
					{_dir = (getdir (nearestBuilding _veh));};
				_veh setdir _dir;
				_veh setpos (_veh modelToWorld [-5,0,-1.3]);
				};
			};
	};
handle_spt_finished = true;
__tky_ends
