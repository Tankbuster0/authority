//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_counterattack";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
smmissionstring = format ["The enemy reserves are attacking %1. Get your forces organised there and kill them all. Expect mostly mechanised infantry and perhaps an aircraft or two.", cpt_name];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";
private ["_deg","_ep","_myroads","_myrp0","_rcrp1","_rpdir","_refdir","_casquadcnt","_c","_cagroup","_carp","_carp2","_cavec","_veh","_cadest","_cawp","_cavecshooters","_vec","_shootergrp","_mygunner","_camarkername","_cavehmarker","_pos1","_killgrp","_dirtext","_myvec"];
private _smcleanup = [];
private _edgeroads0 = []; private _edgeroads1 = []; private _castarttime = floor serverTime; private _warnflag = false;
cavecs = []; caunits = []; cavecintowncounter = 0;
for "_deg" from 0 to 355 step 5 do
	{
		_ep = cpt_position getpos [(cpt_radius + 500), _deg];
		_myroads = _ep nearRoads 40;
		{_edgeroads0 pushBackUnique _x} forEach _myroads;
	}; // array of roadpieces within 40 of a radius 500 outside the OA
// note roadpieces dont have a dir
diag_log format ["*** dca edgeroads0 @ 19 is count %1 and is %2 ", count _edgeroads0, _edgeroads0 ];
{
	_myrp0 = _x;
	_rcrp1 = roadsConnectedTo _myrp0;
	if ((count _rcrp1) > 1) then
		{
			_rpdir = _myrp0 getdir (_rcrp1 select 0);
			_refdir = cpt_position getdir _myrp0;

			if ( (( [_rpdir, _refdir, 50] call  tky_fnc_isNumInRangeDegrees) or ([(_rpdir + 180), (_refdir), 50] call tky_fnc_isNumInRangeDegrees)) and// find rp realy facing towards cpt
			    	{
			    		((_myrp0 distance2D getMarkerPos "fobmarker") > 75) and//not near fob
			    		((_myrp0 distance2D forward) > 75) and// not near forward
			    		(count (nearestTerrainObjects [player, ["bush", "tree", "rock"], 7, false, true]) < 3) and //not on a forest trail
			    		(((getpos _myrp0) getEnvSoundController "forest" ) < 0.9) and //not on a forest trail
			    		((_myrp0 distance2d blubasehelipad) > 300) and //not near the airbase
			    		(not (surfaceIsWater (_myrp0 getpos [((_myrp0 distance2d cpt_position) /2),  (_myrp0 getdir cpt_position ) ])) ) and// no water inbetween rp and cpt
			    		(not (surfaceIsWater (_myrp0 getpos [((_myrp0 distance2d cpt_position) /4),  (_myrp0 getdir cpt_position ) ])) ) and
			    		(not (surfaceIsWater (_myrp0 getpos [((_myrp0 distance2d cpt_position) /1.35),  (_myrp0 getdir cpt_position ) ])) )
			    	}) then
				{
					_edgeroads1 pushBack _myrp0;
				};
		};
} forEach _edgeroads0;
// edgeroads1 should now contain only roadpieces that, more or less, point towards the cpt and are not near the forward or fob
diag_log format ["*** er1 has count %1 elements ", count _edgeroads1];
if ((count _edgeroads1)> 2) then
	{// a couple of good places to spawn CA  troops
		_casquadcnt = 1 + (( (floor (((playersNumber west) min 6)/2)) + floor ( random (count _edgeroads1 / 3))) min 7);
		diag_log format ["*** dca going to make %1 squads", _casquadcnt];
		for "_c" from 1 to _casquadcnt do
			{
				_cagroup = createGroup [independent, true];
				_carp = selectRandom _edgeroads1;
				_edgeroads1 = _edgeroads1 - [_carp];
				_carp2 = (roadsConnectedTo _carp) select 0;
				_cavec = selectRandom indicavecs;
				_veh = [getpos _carp, _carp getdir cpt_position, _cavec, _cagroup] call tky_fnc_spawnandcrewvehicle;
				_veh setvariable ["startingpos", getpos _veh];
				_veh setUnloadInCombat [false, false];
				_cagroup allowFleeing 0;
				cavecs pushback _veh;
				caunits append (crew _veh);
				_smcleanup append (crew _veh);
				_smcleanup pushBack _veh;
				_cadest = selectRandom (cpt_position nearRoads 75);
				_cawp = _cagroup addWaypoint [_cadest, 5];
				_cawp setWaypointType "unload";
				_cawp setWaypointCombatMode "red";
				_cawp setWaypointBehaviour "careless";
				_cawp setWaypointForceBehaviour true;
				_cawp setWaypointStatements ["true", "(group this) leavevehicle (vehicle this); (group this) setBehaviour 'combat'; [(group this), getpos this, 150] call BIS_fnc_taskPatrol; (group this setCombatMode 'red' )"];
				_veh limitSpeed 20;
				_cavecshooters = fullcrew [_veh, "gunner", false];
				_cavecshooters append (fullcrew [_veh, "turret", false]);
				_shootergrp = createGroup [independent, true];
				{// get all the shooter (gunners + turrets) and put them in a more aggresive group so they engage while driving
					_mygunner = _x select 0;
					[_mygunner] joinSilent grpNull;
					sleep 1;
					[_mygunner] joinSilent _shootergrp;
					_mygunner setCombatMode "red";
				} foreach _cavecshooters;
				_shootergrp setcombatmode "red";
				[_cagroup, true, true] call tky_fnc_tc_setskill;
				_camarkername = format ["camname%1", _c];
				_cavehmarker = createMarker [_camarkername, _veh];
				_cavehmarker setMarkerShape "icon";
				_cavehmarker setMarkerType "o_support";
				[_veh, _cavehmarker] spawn
					{
						while {true} do
						{
						(_this select 1) setMarkerPos (getpos (_this select 0));
						(_this select 1) setMarkerText format ["%1, %2, %3, %4",floor (speed (_this select 0)),floor ( (_this select 0) distance2d ((expectedDestination (driver (_this select 0 ))) select 0)), count ((effectiveCommander (_this select 0)) targetsQuery [objNull, west, "SoldierWB", [],30]), waypointBehaviour [(group (effectiveCommander (_this select 0))),1] ];
						(_this select 1) setMarkerColor ("color" + (if (combatMode (driver (_this select 0)) != "Error") then {(combatMode (driver (_this select 0)))} else {"black"}));
						sleep 0.2;
						};
					};
				[_veh] spawn
					{
						private ["_pos1", "_killgrp"];
						while {alive (_this select 0)} do
							{
								_pos1 = getpos (_this select 0);
								sleep 30;
								if ((((getpos (_this select 0)) distance2D _pos1) < 4) and {(_pos1 distance2d cpt_position) > cpt_radius}) then
									{// vehicle stalled (mybe confused by forest track) and away from cpt, so killing and removing
										diag_log format ["*** dca spawned bit removes a %1 because it's stalled at %2", typeOf (_this select 0), getpos (_this select 0)];
										_killgrp = units (group (_this select 0));
										caunits = caunits - _killgrp;
										cavecs = cavecs - [(_this select 0)];
										{deleteVehicle _x;} foreach _killgrp;
										 (_this select 0) setdamage 1;
									};
							};
					};
			};
	}
	else
	{// not enough good places found for spawning CA troops
	};
sleep 10;
{
	if (isNull objectParent _x) then
		{// for whatever reason, someone is not in a vec
			caunits = caunits - [_x];
			deleteVehicle _x;
			diag_log format ["*** dca removed %1 because he's not in a vec early on"];
		};
} foreach caunits;
while {missionactive} do
	{
		sleep 3;
		if (not(_warnflag)) then
			{
				{
					if ((_x distance2d cpt_position) < (cpt_radius + 100)) then
					{
						_dirtext = "Satellite is tracking inbound enemy vehicles just " + ((cpt_position getDir _x) call TKY_fnc_cardinaldirection) + " of the town";
						_dirtext remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
						_warnflag = true;
					};
				} foreach cavecs;
			};
		if ((servertime > _castarttime + 60) and {serverTime < _castarttime + 70}) then
			{// mission has been running for between 60 and 70 seconds
				{
					if  (((_x getVariable ["startingpos", [0,0,0]]) distance2D _x) < 20) then
						{//vehicle stuck at start and not inside the cpt
							_x setdamage 1;
							diag_log format ["*** dca kills %1 which is a %2 because it's stuck at startpos %3 ", _x, typeOf _x, getpos _x];
						};
				}foreach cavecs;
			};
		{
			private _myvec = _x;
			if (((speed _x) isEqualTo 0) and {(count ((effectiveCommander _x) targetsQuery [objNull, west, "SoldierWB", (getpos _x), 30]) < 1) and (combatMode (group (effectiveCommander _x)) == "RED")}) then
				{// get them back in the vehicle and reset it so its carries on, hopefully
					{
						_x assignascargo _myvec;
            			_x moveincargo _myvec;
					} forEach units (effectiveCommander _x);
					group (effectiveCommander _x) setCombatMode "green";
					DIAG_LOG FORMAT ["*** DCA sets %1 at %2 combatmode green because its not under sttack anymore", typeof _myvec, getpos _myvec];
				};
		} forEach cavecs;
		/*{
			if ( (isNull (objectParent _x)) and {(not (_x inArea [cpt_position, 75,75,0,false,-1])) and (alive _x) }) then
				{// caunit is not in a vehicle, alive and away from the cpt (probably bailed from a damaged vec)
					(leader _x) doMove cpt_position;
					(group _x) setCombatMode "red";
				};
		} foreach caunits;*/
		if (FALSE) then// failure. enemy get a vehicle or aircraft into the middle of the town
			{// currently, there's no failure condition for this
			missionsuccess = false;
			missionactive = false;
			};
		if (({alive _x} count caunits) < 3) then // success. all or most enemy forces are destroyed
			{
			missionsuccess = true;
			missionactive = false;
			"Your team defeated the attack. Good work guys." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			{_x setDamage 1;} forEach caunits;
			};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
if (not missionsuccess) then {publicVariable "failtext"};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
