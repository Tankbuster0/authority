#define filename "spawnprimarytargetunits.sqf"
//by tankbuster
_myscript = "spawnprimarytargetunits.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_currentprimarytarget","_loc_pos","_pt_pos","_pt_radius","_pt_type","_mylogic","_lc","_count","_grpname","_mypos","_mydir","_mypos2"];
_currentprimarytarget = _this select 0;// recieves a logic
//diag_log format ["***doprimary.sqf @ 7 Primary units spawn actual %1, typename %2", _currentprimarytarget, typeName _currentprimarytarget];
//_loc_pos = getpos _currentprimarytarget;
_pt_pos = getpos _currentprimarytarget;
_pt_radius = (_currentprimarytarget getVariable "targetradius");
_pt_type = (_currentprimarytarget getVariable "targettype");
//diag_log format ["*** spawnprimaryunits @12 locpos %1 mylogic %2, ptpos %3, ptradius %4", _loc_pos, _mylogic, _pt_pos, _pt_radius];
_lc = (_pt_radius /75); //scales spawn levels according to radius
_pt_radius = _pt_radius - 50;
diag_log format ["sptu _pt_type %1", _pt_type];




for "_count" from 2 to _lc do
	{
	_grpname = format ["grp%1", _count];
	_grpname = createGroup east;

	_mypos = [_pt_pos, 0, _pt_radius, 4,0,30,0] call bis_fnc_findSafePos;
	switch ((floor (random 5))) do
		{
		case 0: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad")] call BIS_fnc_spawnGroup;};
		case 1: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_AA")] call BIS_fnc_spawnGroup;};
		case 2: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_section_AT")] call BIS_fnc_spawnGroup;};
		case 3: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_sniper")] call BIS_fnc_spawnGroup;};
		case 4: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> "rhs_group_rus_msv_infantry_squad_2mg")] call BIS_fnc_spawnGroup;};
		};
	nul = [_grpname, _pt_pos, _pt_radius] call BIS_fnc_taskpatrol;// patrolling infantry group
	sleep 0.1;
	_mypos = [_pt_pos, 0, _pt_radius, 8,0,30,0] call bis_fnc_findSafePos;
		switch ((floor (random 7))) do
		{
		case 0: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_2s3" >> "RHS_SPGSection_tv_2s3")] call BIS_fnc_spawnGroup;};
		case 1: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_btr70" >> "rhs_group_rus_msv_btr70_squad_2mg")] call BIS_fnc_spawnGroup;};
		case 2: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp1" >> "rhs_group_rus_msv_bmp1_squad_aa")] call BIS_fnc_spawnGroup;};
		case 3: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad" )] call BIS_fnc_spawnGroup;};
		case 4: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_90" >> "RHS_t90aPlatoon" )] call BIS_fnc_spawnGroup;};
		case 5: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_bmp2" >> "rhs_group_rus_msv_bmp2_squad_2mg" )] call BIS_fnc_spawnGroup;};
		case 6: {_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_MSV_bmp3m" >> "rhs_group_rus_MSV_bmp3m_squad_sniper" )] call BIS_fnc_spawnGroup;};
		};
	sleep 0.1;// static  apc /ifv group

	_mypos = [_pt_pos, 0, _pt_radius, 6,0,30,0] call bis_fnc_findSafePos;

		switch ((floor (random 14))) do
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
	nul = [_grpname, _pt_pos, _pt_radius] call BIS_fnc_taskpatrol;// patrolling  apc/ifv group
	sleep 0.1;
	if (_pt_type == 1) then //tanks only spawn at towns, not at bases or airfields
	{
		_mypos = [_pt_pos, 0, _pt_radius, 8,0,30,0] call bis_fnc_findSafePos;

			switch ((floor (random 3))) do
		{
		case 0: {diag_log format ["***sptu making t72"];_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_72" >> "RHS_T72BDSection" )] call BIS_fnc_spawnGroup;};
		case 1: {diag_log format ["***sptu making t80"];_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_80" >> "RHS_T80UPlatoon_AA" )] call BIS_fnc_spawnGroup;};
		case 2: {diag_log format ["***sptu making t90"];_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "rhs_faction_tv" >> "rhs_group_rus_tv_90" >> "RHS_t90aPlatoon")] call BIS_fnc_spawnGroup;};
		};
		sleep 0.1;
	};
	_mypos = [_pt_pos, 0, _pt_radius, 4,0,30,0] call bis_fnc_findSafePos;
	_grpname = [_mypos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_support_Mort")] call BIS_fnc_spawnGroup;
	_mydir = [_pt_pos, _mypos]  call BIS_fnc_dirTo;
	_mypos2 = [_mypos,2,4,0,0,30,0] call bis_fnc_findSafePos;
	[_mypos2, (_mydir + 180), "O_Mortar_01_F", _grpname] call bis_fnc_spawnVehicle;
	sleep 0.1;

{
if (_x isKindOf "Man") then {mancleanup pushback _x} else {vehiclecleanup pushback _x};
if ((_x isKindOf "Man") and (vehicle _x == _x)) then {vehiclecleanup pushback (vehicle _x) };
 }foreach (units _grpname);

	};


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

