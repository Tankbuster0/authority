//by tankbuster
_myscript = "spawnprimarytargetunits";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_currentprimarytarget","_pt_pos","_pt_radius","_pt_type","_pt_name","_lc","_start","_composition","_allcompositionunits","_count","_staticgrpname","_grpname","_mypos","_mydir","_staticgrp","_veh","_patrolinf","_staticveh","_patrolveh","_statictanks","_vehdata","_removeenemyvests","_mygroup","_townroadsx","_townroads","_civcount","_fciv","_civfootgroup","_pos","_cfunit","_dcar","_dcarcount","_dcargroup","_roadnogood","_road1","_objs","_road2","_dir","_unit","_crewcount","_ii","_unit2","_roadposarray","_null","_pcar","_pcarcount","_nb"];
_currentprimarytarget = _this select 0;// receives a logic
_pt_pos = getpos _currentprimarytarget;
_pt_radius = (_currentprimarytarget getVariable "targetradius");
_pt_type = (_currentprimarytarget getVariable "targettype");
_pt_name = (_currentprimarytarget getVariable "targetname");
_lc = (_pt_radius /75); //scales spawn levels according to radius
_start = ["enemyspawnlevel", 2] call BIS_fnc_getParamValue;
if ((_start == 3) and (_pt_radius == 150)) then {_start = 2};
_pt_radius = _pt_radius - 50;
if ((worldname in ["Altis", "alits"]) and (_pt_type == 2)) then
	{
	switch (_pt_name) do
		{
		case "AAC airfield": {_composition = aaccomposition};
		/*case "Almyra airfield": {_composition = almyracomposition};*/
		case "Abdera airfield": {_composition = abderacomposition};
		case "Feres airfield": {_composition = ferescomposition};
		case "Molos Airfield":{_composition = moloscomposition};
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
	sleep 0.1;
	//diag_log format ["***spu loop %1", _count];
	_staticgrpname = format ["staticgrp%1", _count];
	// statics start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,50,0] call bis_fnc_findSafePos;
	_mydir = [_pt_pos, _mypos] call BIS_fnc_dirTo;
	switch ((floor (random 5))) do
		{
		case 0: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSquad")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "CUP_O_D30_AT_RU", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 1: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection_AA")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "CUP_O_ZU23_RU", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 2: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection_AT")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "cup_o_metis_ru", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 3: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection_MG")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "cup_o_kord_high_ru", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 4: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection_MG")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "cup_o_kord_ru", _staticgrp ] call bis_fnc_spawnVehicle;
				};

		};

	nul = [_staticgrp, _pt_pos] call bis_fnc_taskDefend;// defending infantry group
	_mypos = [_pt_pos, 0, _pt_radius, 3,0,50,0] call bis_fnc_findSafePos;
	_mydir = [_pt_pos, _mypos] call BIS_fnc_dirTo;
	_veh = createVehicle ["O_Mortar_01_F", _mypos, [],0,"NONE"];
	_veh setdir _mydir;
	_mgunner = _staticgrp createUnit ["CUP_O_RU_Soldier", _mypos,[],0,"NONE"];
	_mgunner moveInGunner _veh;
	_mgunner assignAsGunner _veh;
	mortar_gunners pushback gunner _veh;
	group (gunner _veh) setCombatMode "RED";

	_veh = createVehicle ["O_Mortar_01_F", ([_mypos, 4 + (random 4), random 360] call bis_fnc_relPos), [],0,"NONE"];
	_veh setdir (_mydir + random 15);
	_mgunner = _staticgrp createUnit ["CUP_O_RU_Soldier", _mypos,[],0,"NONE"];
	_mgunner moveInGunner _veh;
	_mgunner assignAsGunner _veh;
	mortar_gunners pushback gunner _veh;
	group (gunner _veh) setCombatMode "RED";

	nul = [_staticgrp, _pt_pos] call bis_fnc_taskDefend;// defending mortar groupa
	sleep 0.1;
	// statics end

	// patrolling infantry start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,50,0] call bis_fnc_findSafePos;
	switch ((floor (random 4))) do
		{
		case 0: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection")] call BIS_fnc_spawnGroup;};
		case 1: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection_AT")] call BIS_fnc_spawnGroup;};
		case 2: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_SniperTeam")] call BIS_fnc_spawnGroup;};
		case 3: {_patrolinf = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection_MG")] call BIS_fnc_spawnGroup;};
		};
	nul = [_patrolinf, _pt_pos, (_pt_radius / 2)] call BIS_fnc_taskpatrol;
	// patrolling infantry end
	sleep 0.1;

	// static IFV/ apc start
	_mypos = [_pt_pos, 0, _pt_radius, 5,0,50,0] call bis_fnc_findSafePos;

		_veh = selectRandom opforstaticlandvehicles;
		_staticveh = [_mypos, east, [_veh, "CUP_O_RU_Soldier_SL", "CUP_O_RU_Soldier_MG", "CUP_O_RU_Soldier_MG", "CUP_O_RU_Soldier_AT","CUP_O_RU_Soldier_LAT", "CUP_O_RU_Soldier_GL"]] call BIS_fnc_spawngroup;

	sleep 0.2;
	// patrolling  apc /ifv group start
	_mypos = [_pt_pos, 0, _pt_radius, 5,0,50,0] call bis_fnc_findSafePos;
	_veh = selectRandom opforpatrollandvehicles;
	_patrolveh = [_mypos, east, [_veh, "CUP_O_RU_Soldier_SL", "CUP_O_RU_Soldier_MG", "CUP_O_RU_Soldier_MG", "CUP_O_RU_Soldier_AT","CUP_O_RU_Soldier_LAT", "CUP_O_RU_Soldier_GL"]] call BIS_fnc_spawngroup;
	nul = [_patrolveh, _pt_pos, (_pt_radius /2)] call BIS_fnc_taskpatrol;
	// patrolling  apc/ifv group end
	sleep 0.05;
	//heavy armour and shit start
	if ((_pt_type == 1) and (cpt_radius > 150)) then //tanks only spawn at big towns, not at bases or airfields
	{
		_mypos = [_pt_pos, 0, _pt_radius, 5,0,50,0] call bis_fnc_findSafePos;
		_veh = selectRandom opfortanks;
		_statictanks = [_mypos, east, [_veh, _veh, _veh], [[0,10,0], [5,0,0], [10,0,0]]] call BIS_fnc_spawngroup;
		sleep 0.05;
	};
	//heavy armour end
	sleep 0.05;
// add them all to cleanup arrays
	{
	if (_x isKindOf "Man") then {mancleanup pushback _x} else {vehiclecleanup pushback _x};
	if ((_x isKindOf "Man") and (vehicle _x == _x)) then {vehiclecleanup pushback (vehicle _x) };
	sleep 0.02;
	 }foreach (/*_allcompositionunits + */(units _staticgrp) + (units _patrolinf) + (units _patrolveh) );
};
_removeenemyvests = ["removeenemyvests",0] call BIS_fnc_getParamValue;
{
	if (side _x == east) then
		{
		_mygroup = _x;
		[_mygroup, true, true] call tky_fnc_tc_setskill;
		if (_removeenemyvests > 0) then
			{
				{
				if ((_removeenemyvests == 2) or ((_removeenemyvests == 1) and (random 1 > 0.8))) then
					{
					removeVest _x;
					}
				} foreach units _mygroup;
			};
		};
} foreach allgroups;
{
	[_x, [0.17,0.17,0.60,0.40,1,1,0.40,0.50,1,0.50], false,0] call tky_fnc_tc_setskill;
	// ^^^ mortar gunners have best spotdistance and spottime
	[_x] spawn // mortar gunner helper
		{
			private ["_nearblufors", "_mygunner", "_artytarget", "_iroa", "_aeta", "_amags", "_aka"];
			_mygunner = _this select 0;
			while {(alive _mygunner) and ("8Rnd_82mm_Mo_shells" in (getArtilleryAmmo [(vehicle _mygunner)]))} do

				{
				sleep 20 + (10 * random 5) ;
				_nearblufors = (position _mygunner) nearEntities ["CUP_Creatures_Military_BAF_Soldier_Base", 500];
				if ((count _nearblufors) > 0) then
					{
					_artytarget = (selectRandom _nearblufors);
					_mygunner reveal [_artytarget, 3];
					//_iroa = (position _artytarget) inRangeOfArtillery [[_mygunner], "8Rnd_82mm_Mo_shells"];
					//_aeta = (vehicle _mygunner) getArtilleryETA [position _artytarget, "8Rnd_82mm_Mo_shells"];
					//_amags = "8Rnd_82mm_Mo_shells" in (getArtilleryAmmo [(vehicle _mygunner)]);
					//_aka = _mygunner knowsAbout _artytarget;
					//diag_log format ["*** mortar guys at %5 told to fire!, is inrange %1 and ETA %2 has ammo %3 and has %4 knowledge of target", _iroa, _aeta, _amags, _aka, (position _mygunner) ];
					_mygunner doArtilleryFire [(position _artytarget), "8Rnd_82mm_Mo_shells", 2 ];
					};
				};

		};
} foreach mortar_gunners;
//createcivilians
if (_pt_type isEqualTo 1) then
		{
		//civs on foot
		_townroadsx = _pt_pos nearRoads _pt_radius;
		_townroads = _townroadsx call BIS_fnc_arrayShuffle;
		_civcount = (2 * _lc);
		_fciv = [];
		while {count _townroads < _civcount} do {_townroads append _townroads};
		for "_i" from 1 to _civcount do
			{
			sleep 0.2;
			_civfootgroup = format ["civftgrp%1", _i];
			_civfootgroup = createGroup civilian;
			_pos = getpos (selectRandom _townroads);
			_cfunit = _civfootgroup createUnit [(selectRandom civs), _pos, [],0,"NONE"];
			//_cfunit addEventHandler ["killed", {if (((_this select 1) getVariable "ACE_medical_lastDamageSource") isKindOf "SoldierWB") then {nul = execVM "server\playerkilledciv.sqf"}}];
			_cfunit addEventHandler ["killed", {if ((faction ((_this select 0) getVariable "ACE_medical_lastDamageSource")) isEqualTo "CUP_B_GB") then {civkillcount = civkillcount +1};}];
			nul = [_cfunit, (str primarytargetcounter)] execVM "server\UPS.sqf";
			_fciv pushback _civfootgroup;
			};
		//driven cars
		_dcar = [];
		_dcarcount = (3 * _lc);
		for "_i" from 1 to _dcarcount do
			{
			sleep 0.2;
			_dcargroup = format ["civcrgrp%1", _i];
			_dcargroup = createGroup civilian;
			_roadnogood = true;
			while {_roadnogood} do // make sure the roadpiece chosen doesn't already have a car on it.
				{
				sleep 0.05;
				_road1 = (selectRandom _townroads);
				_objs = (getpos _road1) nearEntities ["LandVehicle",5];
				if (((count _objs) < 1) and (count (roadsConnectedTo _road1) > 1 ))  then {_roadnogood = false};
				};
			_road2 = (roadsConnectedTo _road1) select 0;
			_dir = _road1 getdir _road2;
			_veh = createVehicle [(selectRandom civcars), (getpos _road1), [],0,"NONE"];
			_veh setdir _dir;
			_unit = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
			_unit addEventHandler ["killed", {if ((faction ((_this select 0) getVariable "ACE_medical_lastDamageSource")) isEqualTo "CUP_B_GB") then {civkillcount = civkillcount +1};}];
			_unit assignAsDriver _veh;
			_unit moveInDriver _veh;
			nul = [_unit, (str primarytargetcounter)] execVM "server\UPS.sqf";
			_crewcount = [(typeof _veh), true] call BIS_fnc_crewCount;
			for "_ii" from 1 to (random _crewcount) do
				{
				sleep 0.05;
				_unit2 = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
				_unit2 addEventHandler ["killed", {if ((faction ((_this select 0) getVariable "ACE_medical_lastDamageSource")) isEqualTo "CUP_B_GB") then {civkillcount = civkillcount +1};}];
				_unit2 moveInAny _veh;
				};
			_dcar pushback _dcargroup;
			};
		_roadposarray = [];
		{_roadposarray pushback (getpos _x)} foreach _townroads;
		_null = [_fciv, _dcar, _roadposarray] execVM "server\cosPatrol.sqf";//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		_pcar = [];
		_pcarcount = (3 * _lc);
		for "_i" from 1 to _pcarcount do
			{
			sleep 0.2;
			_roadnogood = true;
			while {_roadnogood} do // make sure the roadpiece chosen doesn't already have a car on it.
				{
				_road1 = (selectRandom _townroads);
				_objs = (getpos _road1) nearEntities ["LandVehicle",7];
				if (((count _objs) < 1) and (count (roadsConnectedTo _road1) == 2))  then {_roadnogood = false};
				};
			_veh = createVehicle [(selectRandom civcars), (getpos _road1), [],0, "NONE"];
			_nb = nearestBuilding _veh;
			if ((_veh distance _nb) > 10) then
				{_dir = (_veh getdir ((roadsConnectedTo _road1) select 0));}
				 else
				{_dir = (getdir (nearestBuilding _veh));};
			_veh setdir _dir;
			_veh setpos (_veh modelToWorld [-5,0,-1.3]);
			};
	};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
