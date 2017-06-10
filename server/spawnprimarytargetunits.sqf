//by tankbuster
#include "..\includes.sqf"
_myscript = "spawnprimarytargetunits";
__tky_starts;
private ["_currentprimarytarget","_pt_pos","_pt_radius","_pt_type","_pt_name","_lc","_start","_composition","_allcompositionunits","_count","_staticgrpname","_grpname","_mypos","_mydir","_staticgrp","_veh","_patrolinf","_staticveh","_patrolveh","_statictanks","_vehdata","_removeenemyvests","_mygroup","_townroadsx","_townroads","_civcount","_fciv","_civfootgroup","_pos","_cfunit","_dcar","_dcarcount","_dcargroup","_roadnogood","_road1","_objs","_road2","_dir","_unit","_crewcount","_ii","_unit2","_roadposarray","_null","_pcar","_pcarcount","_nb", "_microtown"];
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
		};
	_allcompositionunits = [_pt_pos, 0, _composition] call tky_fnc_t_objectsmapper;
	sleep 0.05;
	{
		if (_x isKindOf "Air") then {_x setVehicleLock "LOCKEDPLAYER";};
	}foreach _allcompositionunits;
	}
	else
	{
	_allcompositionunits = [];
	};
mortar_gunners = [];
for "_count" from _start to _lc do
{
	sleep 0.05;
	diag_log format ["***spu %1 from %2 to %3 ", _count, _start, _lc];
	_staticgrpname = format ["staticgrp%1", _count];
	// statics start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_mydir = _pt_pos getdir _mypos;
	if (testmode) then {diag_log "**** sptu starts static spawn"};
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

	nul = [_staticgrp, _pt_pos] call bis_fnc_taskDefend;// defending infantry group
	_mypos = [_pt_pos, 0, _pt_radius, 3,0,0.5,0,1,1] call tky_fnc_findSafePos;
	_mydir = _pt_pos getdir _mypos;
__tky_debug;
if (testmode) then {diag_log "**** sptu adds a mortar"};
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
if (testmode) then {diag_log "**** sptu adds infantry patrols"};
	// patrolling infantry start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,0.5,0,1,1] call tky_fnc_findSafePos;
	switch ((floor (random 4))) do
		{
		case 0: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;};
		case 1: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam_AT")] call BIS_fnc_spawnGroup;};
		case 2: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_ReconSquad")] call BIS_fnc_spawnGroup;};
		case 3: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OFP_F" >> "Infantry" >> "OIA_InfTeam_MG")] call BIS_fnc_spawnGroup;};
		};
	nul = [_patrolinf, _pt_pos, (_pt_radius / 2)] call BIS_fnc_taskpatrol;
	// patrolling infantry end
	sleep 0.05;
if (testmode) then {diag_log "**** sptu adds static IFV"};
	// static IFV/ apc start
	_mypos = [_pt_pos, 0, _pt_radius, 5,0,0.5,0,1,1] call tky_fnc_findSafePos;

		_veh = selectRandom opforstaticlandvehicles;
		_staticveh = [_mypos, east, [_veh, "O_Soldier_SL_F", "O_Soldier_AT_F", "O_Soldier_GL_F"]] call BIS_fnc_spawngroup;

	sleep 0.05;
	// patrolling  apc /ifv group start
	if not (_microtown) then
		{
		 _mypos = [_pt_pos, 0, _pt_radius, 5,0,0.5,0,1,1] call tky_fnc_findSafePos;
		_veh = selectRandom opforpatrollandvehicles;
		_patrolveh = [_mypos, east, [_veh, "O_Soldier_SL_F", "O_Soldier_AT_F", "O_Soldier_GL_F"]] call BIS_fnc_spawngroup;
		nul = [_patrolveh, _pt_pos, (_pt_radius /2)] call BIS_fnc_taskpatrol;
		if (testmode) then {diag_log "**** sptu adds patyrolling apc/ifv because not microtown"};
		}
		else
		{
		if (testmode) then
			{diag_log "**** sptu not adding patrolling APC/AFC because its a microtown";};
		};
	// patrolling  apc/ifv group end
	sleep 0.05;
	//heavy armour and shit start
	if ((_pt_type isEqualTo 1) and (cpt_radius > 150)  and ((random 5) > 4)) then //tanks only spawn at big towns, not at bases or airfields
	{
		_mypos = [_pt_pos, 0, _pt_radius, 5,0,0.5,0,1,1] call tky_fnc_findSafePos;
		_veh = selectRandom opfortanks;
		_statictanks = [_mypos, east, [_veh, _veh], [[0,10,0], [5,0,0]] ]call BIS_fnc_spawngroup;
		sleep 0.05;
		if (testmode) then {diag_log "**** sptu adds MBT because its a large town"};
	}
	else
	{
		if (testmode) then {diag_log "**** sptu skips adding mbt becuase it's an airfield or a small town or it was randomly not done"};
	};
	//heavy armour end
	sleep 0.05;


// add them all to cleanup arrays
	if (testmode) then {diag_log "**** sptu adds them to cleanup array"};
	{
	if (_x isKindOf "Man") then {mancleanup pushback _x} else {vehiclecleanup pushback _x};
	if ((_x isKindOf "Man") and (vehicle _x == _x)) then {vehiclecleanup pushback (vehicle _x) };
	sleep 0.02;
	 }foreach (/*_allcompositionunits + */(units _staticgrp) + (units _patrolinf) + (units _patrolveh) );
};
__tky_debug;
_removeenemyvests = ["removeenemyvests",0] call BIS_fnc_getParamValue;
if (testmode) then {diag_log "**** sptu removes some opfor vests at random"};
{
	if (side _x isEqualTo east) then
		{
		_mygroup = _x;
		[_mygroup, true, true] call tky_fnc_tc_setskill;
		if (_removeenemyvests > 0) then
			{
				{
				if (_removeenemyvests < 0)  then
				    {
				    if (random 1 > 0.5) then
						{
						removeVest _x;
						};
					};
				} foreach units _mygroup;
			};
		};
} foreach allgroups;
if (testmode) then {diag_log "**** sptu might start nasty mortar helper"};
if (((west countSide allPlayers) > 2) and (not _microtown) and (false)) then //and false temporarily turns off this to see if we need it. Old mortars were too powerful
	{
		if (testmode) then {diag_log "**** sptu does actually start nasty mortar helper"};
		{
			[_x, [0.17,0.17,0.60,0.40,1,1,0.40,0.50,1,0.50], false,0] call tky_fnc_tc_setskill;
			// ^^^ mortar gunners have best spotdistance and spottime
			[_x] spawn // mortar gunner helper
				{
					private ["_nearblufors", "_mygunner", "_artytarget", "_iroa", "_aeta", "_amags", "_aka"];
					_mygunner = _this select 0;
					while {(alive _mygunner) and ("8Rnd_82mm_Mo_shells" in (getArtilleryAmmo [(vehicle _mygunner)]))} do

						{
						sleep 60 + (60 * random 5) ;
						_nearblufors = (position _mygunner) nearEntities ["B_Soldier_base_f", 400];
						if ((count _nearblufors) > 0) then
							{
							_artytarget = (selectRandom _nearblufors);
							_mygunner reveal [_artytarget, 3];
							_mygunner doArtilleryFire [(position _artytarget), "8Rnd_82mm_Mo_shells", 1 ];
							};
						};

				};
		} foreach mortar_gunners;
	};
//createcivilians
if (testmode) then {diag_log "**** sptu starts cvilian stuff"};
__tky_debug;
if (_pt_type isEqualTo 1) then
		{
		if (testmode) then {diag_log "**** sptu adds civilans on foot"};
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
			//_cfunit addEventHandler ["killed", {if (((_this select 1) getVariable "ACE_medical_lastDamageSource") isKindOf "SoldierWB") then {nul = execVM "server\playerkilledciv.sqf"}}];
			//_cfunit addEventHandler ["killed", {if ((faction ((_this select 0) getVariable "ACE_medical_lastDamageSource")) isEqualTo "CUP_B_GB") then {civkillcount = civkillcount +1};}];
			_cfunit addEventHandler ["killed", {if (([_this select 0, true] call BIS_fnc_objectSide) isEqualTo west) then
						{
						civkillcount = civkillcount +1;
						if (testmode) then {diag_log format ["civilian killed by %1", name _this select 0 ]};
						};
					}
				];
			nul = [_cfunit, (str primarytargetcounter)] execVM "server\UPS.sqf";
			_fciv pushback _civfootgroup;

			};
		if ((random 10) > 7) then //suicide bomber stuff
			{
			ssbgrp1 = createGroup [east, true];// suicide bomber stuff
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
		if (testmode) then {diag_log "**** sptu adds civilian drive cars"};
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
				sleep 0.05;
				_road1 = (selectRandom _townroads);
				_objs = (getpos _road1) nearEntities ["LandVehicle",7];
				if (((count _objs) < 1) and (count (roadsConnectedTo _road1) > 1 ))  then {_roadnogood = false};
				};
			_road2 = (roadsConnectedTo _road1) select 0;
			_dir = _road1 getdir _road2;
			_veh = createVehicle [(selectRandom civcars), (getpos _road1), [],0,"NONE"];
			_veh setdir _dir;
			_unit = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
			_unit addEventHandler ["killed", {if (([_this select 0, true] call BIS_fnc_objectSide) isEqualTo west) then
						{
						civkillcount = civkillcount +1;
						if (testmode) then {diag_log format ["civilian killed by %1", name _this select 0 ]};
						};
					}
				];
			//_unit addEventHandler ["killed", {if ((faction ((_this select 0) getVariable "ACE_medical_lastDamageSource")) isEqualTo "CUP_B_GB") then {civkillcount = civkillcount +1};}];
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
				//_unit2 addEventHandler ["killed", {if ((faction ((_this select 0) getVariable "ACE_medical_lastDamageSource")) isEqualTo "CUP_B_GB") then {civkillcount = civkillcount +1};}];
				_unit2 moveInAny _veh;
				};
			_dcar pushback _dcargroup;
			};
		_roadposarray = [];
		{_roadposarray pushback (getpos _x)} foreach _townroads;
		_null = [_fciv, _dcar, _roadposarray] execVM "server\cosPatrol.sqf";//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		if (testmode) then {diag_log "**** sptu adds civilian parked cars"};
		_pcar = [];
		_pcarcount = (2 * _lc);
		if !(_microtown) then
			{
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
				_nb = nearestBuilding _veh;
				if ((_veh distancesqr _nb) > 3.1) then
					{_dir = (_veh getdir ((roadsConnectedTo _road1) select 0));}
					 else
					{_dir = (getdir (nearestBuilding _veh));};
				_veh setdir _dir;
				_veh setpos (_veh modelToWorld [-5,0,-1.3]);
				};
			};
	};
__tky_ends
