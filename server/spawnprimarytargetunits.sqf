#define filename "spawnprimarytargetunits.sqf"
//by tankbuster
_myscript = "spawnprimarytargetunits.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_currentprimarytarget","_pt_pos","_pt_radius","_pt_type","_pt_name","_lc","_start","_composition","_count","_grpname","_mypos","_mydir","_veh","_vehdata","_townroadsx","_townroads","_civcount","_fciv","_civfootgroup","_pos","_cfunit","_dcar","_dcarcount","_dcargroup","_roadnogood","_road1","_objs","_road2","_dir","_unit","_crewcount","_ii","_unit2","_roadposarray","_null","_pcar","_pcarcount","_nb", "_removeenemyvests", "_allcompositionunits"];
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
	{if (_x isKindOf "Air") then {_x setVehicleLock "LOCKEDPLAYER";}; }foreach _allcompositionunits;

	};

for "_count" from _start to _lc do
{
	//diag_log format ["***spu loop %1", _count];
	_grpname = format ["grp%1", _count];
	_grpname = createGroup east;
	// statics start
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,50,0] call bis_fnc_findSafePos;
	_mydir = [_pt_pos, _mypos] call BIS_fnc_dirTo;
	switch ((floor (random 6))) do
		{
		case 0: {
				_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "rhs_d30_msv", _grpname ] call bis_fnc_spawnVehicle;
				};
		case 1: {
				_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_AA")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "rhs_Igla_AA_pod_msv", _grpname ] call bis_fnc_spawnVehicle;
				};
		case 2: {
				_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_AT")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "rhs_Metis_9k115_2_msv", _grpname ] call bis_fnc_spawnVehicle;
				};
		case 3: {
				_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_2mg")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "rhs_KORD_high_msv", _grpname ] call bis_fnc_spawnVehicle;
				};
		case 4: {
				_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_2mg")] call BIS_fnc_spawnGroup;
				[_mypos, _mydir, "RHS_NSV_TriPod_MSV", _grpname ] call bis_fnc_spawnVehicle;
				};
		case 5: {
				_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad")] call BIS_fnc_spawnGroup;
				_veh = createVehicle ["rhs_2b14_82mm_msv", _mypos, [],0,"NONE"];
				_veh setdir _mydir;
				createVehicleCrew _veh;
				_veh = createVehicle ["rhs_2b14_82mm_msv", ([_mypos, random 4, random 360] call bis_fnc_relPos), [],0,"NONE"];
				_veh setdir (_mydir + random 15);
				createVehicleCrew _veh;
				};
		};
	nul = [_grpname, _pt_pos] call bis_fnc_taskDefend;// defending infantry group
	_mypos = [_pt_pos, 0, _pt_radius, 3,0,50,0] call bis_fnc_findSafePos;
	_mydir = [_pt_pos, _mypos] call BIS_fnc_dirTo;
	_veh = createVehicle ["rhs_2b14_82mm_msv", _mypos, [],0,"NONE"];
	_veh setdir _mydir;
	createVehicleCrew _veh;
	_veh = createVehicle ["rhs_2b14_82mm_msv", ([_mypos, 4 + (random 4), random 360] call bis_fnc_relPos), [],0,"NONE"];
	_veh setdir (_mydir + random 15);
	createVehicleCrew _veh;
	nul = [_grpname, _pt_pos] call bis_fnc_taskDefend;// defending mortar groupa
	sleep 0.1;
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,50,0] call bis_fnc_findSafePos;
	switch ((floor (random 4))) do
		{
		case 0: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad")] call BIS_fnc_spawnGroup;};
		case 1: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_AT")] call BIS_fnc_spawnGroup;};
		case 2: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_sniper")] call BIS_fnc_spawnGroup;};
		case 3: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_2mg")] call BIS_fnc_spawnGroup;};
		};
	nul = [_grpname, _pt_pos, (_pt_radius / 2)] call BIS_fnc_taskpatrol;// patrolling infantry group
	sleep 0.1;
	_mypos = [_pt_pos, 0, _pt_radius, 5,0,50,0] call bis_fnc_findSafePos;
		switch ((floor (random 6))) do
		{
		case 0: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_2s3" >> "RHS_SPGSection_tv_2s3")] call BIS_fnc_spawnGroup;};
		case 1: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad_2mg")] call BIS_fnc_spawnGroup;};
		case 2: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad_aa")] call BIS_fnc_spawnGroup;};
		case 3: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad" )] call BIS_fnc_spawnGroup;};
		case 4: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad_2mg" )] call BIS_fnc_spawnGroup;};
		case 5: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_bmp3m" >> "rhs_group_rus_MSV_bmp3m_squad_sniper" )] call BIS_fnc_spawnGroup;};
		};
	sleep 0.1;// static  apc /ifv group
	_mypos = [_pt_pos, 0, _pt_radius, 5,0,50,0] call bis_fnc_findSafePos;
		switch ((floor (random 15))) do
		{
		case 0: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad" )] call BIS_fnc_spawnGroup;};
		case 1: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad_2mg")] call BIS_fnc_spawnGroup;};
		case 2: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad")] call BIS_fnc_spawnGroup;};
		case 3: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad_aa" )] call BIS_fnc_spawnGroup;};
		case 4: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80" >> "rhs_group_rus_msv_BTR80_squad_mg_sniper"  )] call BIS_fnc_spawnGroup;};
		case 5: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad" )] call BIS_fnc_spawnGroup;};
		case 6: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad_2mg" )] call BIS_fnc_spawnGroup;};
		case 7: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad_aa" )] call BIS_fnc_spawnGroup;};
		case 8: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad" )] call BIS_fnc_spawnGroup;};
		case 9: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad_2mg" )] call BIS_fnc_spawnGroup;};
		case 10: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_BMP3" >> "rhs_group_rus_MSV_BMP3_squad" )] call BIS_fnc_spawnGroup;};
		case 11: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad_2mg" )] call BIS_fnc_spawnGroup;};
		case 12: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_BMP3" >> "rhs_group_rus_MSV_BMP3_squad_mg_sniper" )] call BIS_fnc_spawnGroup;};
		case 13: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_bmp3m" >> "rhs_group_rus_MSV_bmp3m_squad"  )] call BIS_fnc_spawnGroup;};
		case 14: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_bmp3m" >> "rhs_group_rus_MSV_bmp3m_squad_sniper" )] call BIS_fnc_spawnGroup;};
		};
	nul = [_grpname, _pt_pos, (_pt_radius /2)] call BIS_fnc_taskpatrol;// patrolling  apc/ifv group
	sleep 0.1;
	if ((_pt_type == 1) and (cpt_radius > 150)) then //tanks only spawn at big towns, not at bases or airfields
	{
		_mypos = [_pt_pos, 0, _pt_radius, 5,0,50,0] call bis_fnc_findSafePos;
			switch ((floor (random 3))) do
		{
		case 0: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDSection" )] call BIS_fnc_spawnGroup;};
		case 1: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon_AA" )] call BIS_fnc_spawnGroup;};
		case 2: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_90" >> "RHS_t90aPlatoon")] call BIS_fnc_spawnGroup;};
		};
		sleep 0.1;
	};
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,50,0] call bis_fnc_findSafePos;
	_vehdata = [_mypos, random 360, "rhs_zsu234_aa", _grpname] call bis_fnc_spawnVehicle;
	doStop (_vehdata select 0);
		sleep 0.1;
	{
	if (_x isKindOf "Man") then {mancleanup pushback _x} else {vehiclecleanup pushback _x};
	if ((_x isKindOf "Man") and (vehicle _x == _x)) then {vehiclecleanup pushback (vehicle _x) };
	 }foreach (units _grpname);
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
			_cfunit addEventHandler ["killed", {if ((_this select 1) isKindOf "SoldierWB") then {nul = execVM "server\playerkilledciv.sqf"}}];
			//_cfunit addEventHandler [ "killed", {if ((_this select 1) isKindOf "SoldierWB") then {civkillcount = civkillcount +1};}];
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
			_unit assignAsDriver _veh;
			_unit moveInDriver _veh;
			_crewcount = [(typeof _veh), true] call BIS_fnc_crewCount;
			for "_ii" from 1 to (random _crewcount) do
				{
				_unit2 = _dcargroup createUnit [(selectRandom civs), (getpos _veh), [],0, "CAN_COLLIDE"];
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
