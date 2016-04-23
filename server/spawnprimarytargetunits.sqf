#define filename "spawnprimarytargetunits.sqf"
//by tankbuster
_myscript = "spawnprimarytargetunits.sqf";
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

		case "Almyra airfield": {_composition = almyracomposition};

		case "Abdera airfield": {_composition = abderacomposition};

		case "Feres airfield": {_composition = ferescomposition};

		case "Molos Airfield":{_composition = moloscomposition};

		};
	_allcompositionunits = [_pt_pos, 0, _composition] call BIS_fnc_ObjectsMapper;
	{
	if (_x isKindOf "Air") then {_x setVehicleLock "LOCKEDPLAYER";}; }foreach _allcompositionunits;
	}
	else
	{
	_allcompositionunits = [];
	};

for "_count" from _start to _lc do
{
	//diag_log format ["***spu loop %1", _count];
	_staticgrpname = format ["staticgrp%1", _count];
	// statics start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,50,0] call bis_fnc_findSafePos;
	_mydir = [_pt_pos, _mypos] call BIS_fnc_dirTo;
	switch ((floor (random 6))) do
		{
		case 0: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSquad")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "cup_b_d30_cdf", _staticgrp ] call bis_fnc_spawnVehicle;
				};
		case 1: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection_AA")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "cup_b_zu23_cdf", _staticgrp ] call bis_fnc_spawnVehicle;
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
		case 5: {
				_staticgrp = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSection")] call BIS_fnc_spawnGroup;
				_veh = createVehicle ["CUP_O_2b14_82mm_RU", _mypos, [],0,"NONE"];
				_veh setdir _mydir;
				createVehicleCrew _veh;
				_veh = createVehicle ["CUP_O_2b14_82mm_RU", ([_mypos, random 4, random 360] call bis_fnc_relPos), [],0,"NONE"];
				_veh setdir (_mydir + random 15);
				createVehicleCrew _veh;
				};
		};
	nul = [_staticgrp, _pt_pos] call bis_fnc_taskDefend;// defending infantry group
	_mypos = [_pt_pos, 0, _pt_radius, 3,0,50,0] call bis_fnc_findSafePos;
	_mydir = [_pt_pos, _mypos] call BIS_fnc_dirTo;
	_veh = createVehicle ["CUP_O_2b14_82mm_RU", _mypos, [],0,"NONE"];
	_veh setdir _mydir;
	createVehicleCrew _veh;
	_veh = createVehicle ["CUP_O_2b14_82mm_RU", ([_mypos, 4 + (random 4), random 360] call bis_fnc_relPos), [],0,"NONE"];
	_veh setdir (_mydir + random 15);
	createVehicleCrew _veh;
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
	sleep 0.1;
	//heavy armour and shit start
	if ((_pt_type == 1) and (cpt_radius > 150)) then //tanks only spawn at big towns, not at bases or airfields
	{
		_mypos = [_pt_pos, 0, _pt_radius, 5,0,50,0] call bis_fnc_findSafePos;
		_veh = selectRandom opfortanks;
		_statictanks = [_mypos, east, [_veh, _veh, _veh], [[0,10,0], [5,0,0], [10,0,0]]] call BIS_fnc_spawngroup;
		sleep 0.1;
	};
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,50,0] call bis_fnc_findSafePos;
	_vehdata = [_mypos, random 360, "CUP_O_2S6M_RU", east] call bis_fnc_spawnVehicle;// spawn another tunguska for fun :)
	doStop (_vehdata select 0);
	//heavy armour end
	sleep 0.1;
// add them all to cleanup arrays
	{
	if (_x isKindOf "Man") then {mancleanup pushback _x} else {vehiclecleanup pushback _x};
	if ((_x isKindOf "Man") and (vehicle _x == _x)) then {vehiclecleanup pushback (vehicle _x) };
	 }foreach (_allcompositionunits + (units _staticgrp) + (units _patrolinf) + (units _patrolveh) );
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
//createcivilians
if (_pt_type isEqualTo 1) then
		{
		//civs on foot
		_townroadsx = _pt_pos nearRoads _pt_radius;
		_townroads = _townroadsx call BIS_fnc_arrayShuffle;
		_civcount = (3 * _lc);
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
			_cfunit addEventHandler ["killed", {if (((_this select 1) getVariable "ACE_medical_lastDamageSource") isKindOf "SoldierWB") then {civkillcount = civkillcount +1};}];
			//_cfunit addEventHandler ["HandleDamage", {if (isNull (_this select 3)) then { diag_log format ["***%1 collision damage!"]; } else { _this select 2; }; }];
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
				_road1 = (selectRandom _townroads);
				_objs = (getpos _road1) nearEntities ["LandVehicle",5];
				if (((count _objs) < 1) and (count (roadsConnectedTo _road1) > 1 ))  then {_roadnogood = false};
				};
			_road2 = (roadsConnectedTo _road1) select 0;
			_dir = _road1 getdir _road2;
			_veh = createVehicle [(selectRandom civcars), (getpos _road1), [],0,"NONE"];
			_veh setdir _dir;
			_unit = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
			_unit addEventHandler ["killed", {if (((_this select 1) getVariable "ACE_medical_lastDamageSource") isKindOf "SoldierWB") then {civkillcount = civkillcount +1};}];
			_unit assignAsDriver _veh;
			_unit moveInDriver _veh;
			_crewcount = [(typeof _veh), true] call BIS_fnc_crewCount;
			for "_ii" from 1 to (random _crewcount) do
				{
				_unit2 = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
				_unit2 addEventHandler ["killed", {if (((_this select 1) getVariable "ACE_medical_lastDamageSource") isKindOf "SoldierWB") then {civkillcount = civkillcount +1};}];
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
