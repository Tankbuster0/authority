//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_killvecdepot";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private ["_targetvecs","_vecdepottowns","_candidatetown","_myplaces","_meadows","_smcleanup","_meadowdata","_vdpos","_countX","_countY","_z","_y","_pos","_veh","_q","_defpos","_team","_patrolbool","_staticveh","_patrolveh","_myarray","_vec","_wp","_distanddir"];
_targetvecs = [];
//select a town on same island of they have no helicopters
_vecdepottowns = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) > -1) and {(_x distance2d cpt_position) > 700}};
if ((call tky_fnc_fleet_heli_vtols) isEqualTo []) then
	{
		_vecdepottowns = _vecdepottowns select {(_x getVariable ["targetlandmassid", -1]) isEqualTo cpt_island};
		diag_log format ["***dkilldepot says team have no helis so only selecting dests on same island"];
	};
if ((count _vecdepottowns) < 1) then
	{// fallback just incase we find no towns
		_vecdepottowns = (cpt_position nearEntities ["Logic", 1000]) select {((_x getVariable ["targetstatus", -1]) > -1) and {(_x distance2d cpt_position) > 300}};
	};
_candidatetown = selectRandom _vecdepottowns;
_myplaces = selectbestplaces [_candidatetown, cpt_radius + 600, "meadow", 50,50];
_meadows = _myplaces select {((_x select 1) == 1)};
missionactive = true; missionsuccess = false; _smcleanup = [];
publicVariable "missionactive"; publicVariable "missionsuccess";
_meadowdata = selectRandom _meadows;
_vdpos = _meadowdata select 0;
//^^ choose one to start with, then below, if it isnt good, keep choosing until it is.
while
	{(	((_vdpos distance2D getMarkerPos "fobmarker") < 100) or ((_vdpos distance2D forward) < 100) or (_vdpos inArea format ["cpt_marker_%1", primarytargetcounter] ) or (_vdpos distance2D (nearestBuilding _vdpos) < 40 )	)	}
		do //choose a position that isn't near the fobveh or the forward vehicle or inside the town marker
		{
		_meadowdata = selectRandom _meadows;
		_vdpos = _meadowdata select 0;
		};
vehclass = selectRandom (opfortanks + opforbigartyvecs );
_countX = 2 + floor (random 2);
_countY = 2 + floor (random 3);
for "_z" from 1 to _countX do {
	for "_y" from 1 to _countY do {
		_pos = [
			(_vdpos select 0) + 12 * _z,
			(_vdpos select 1) + 12 * _y,
			0
		];
		_veh = createVehicle [vehclass, _pos, [],0, "NONE"];
		_targetvecs pushBack _veh;
	};
};
 for "_q" from 1 to floor ((1 + playersNumber west) / 1.5)  do
 	{
 		_defpos = [_vdpos, 15, 200, 10, 0, 0.75,0, 1, 1] call tky_fnc_findsafepos;
 		_defpos set [2,0];
 		switch ((floor (random 4))) do
 			{
 				case 0: {
  							_team = [_defpos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_F" >> "Support" >> "OI_support_MG")] call BIS_fnc_spawnGroup;
 							_patrolbool = [_team, _defpos, 10] call BIS_fnc_taskpatrol;
 							_smcleanup = _smcleanup + (units _team);
 						};
 				case 1: {
							_staticveh = [_defpos, east, [(selectRandom opforstaticlandvehicles), "O_Soldier_SL_F", "O_Soldier_AT_F", "O_Soldier_GL_F"]] call BIS_fnc_spawngroup;
							_smcleanup = _smcleanup + (units _staticveh);
						};
 				case 2: {
 							_patrolveh = [_defpos, east, [(selectRandom opforpatrollandvehicles), "O_Soldier_SL_F", "O_Soldier_AT_F", "O_Soldier_GL_F"]] call BIS_fnc_spawngroup;
							nul = [_patrolveh, _defpos, 10] call BIS_fnc_taskpatrol;
							_smcleanup = _smcleanup + (units _patrolveh);
						};
				case 3: {
							_myarray = [[_defpos select 0, _defpos select 1, 300], 0, (selectRandom opforairsupporttypes), east] call BIS_fnc_spawnVehicle;
							_vec = _myarray select 0;
							_vec setVelocity [150 * (sin (getdir _vec)), 150 * (cos (getdir _vec)), 10];
							_wp = (group driver _vec) addWaypoint [_vdpos, 0];
							_wp setWaypointBehaviour "SAFE";
							_wp setWaypointCombatMode "RED";
							_wp setWaypointCompletionRadius 2000;
							_smcleanup pushBack _vec;
							_smcleanup = _smcleanup + (crew _vec);
						};
 			};
 	};
_distanddir = [_vdpos] call tky_fnc_distanddirfromtown;
smmissionstring = format ["There's a concentration of enemy vehicles %1. We don't know what the enemy have planned for them so we think it would be best if they are destroyed.", _distanddir];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";
failtext = "Dudes. You suck texts";
while {missionactive} do
	{
	sleep 3;
	if (/*failure conditions*/false) then
		{
		missionsuccess = false;
		missionactive = false;
		failtext = "You suck. Mission failed because of reasons"; publicVariable "failtext";
		// note there is no failure condition for this mission
		};

	if (({alive _x} count _targetvecs) isEqualTo 0) then
		{
		missionsuccess = true;
		missionactive = false;
		"All the enemy vehicles have been destroyed, significantly degrading their strength in the area. Good job!" remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
