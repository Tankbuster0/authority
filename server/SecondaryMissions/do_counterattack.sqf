//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_counterattack";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private _smcleanup = [];
private _edgeroads0 = [];
private _edgeroads1 = [];
private ["_deg","_ep","_myroads","_mname","_foreachindex","_c1","_myrp0","_rcrp1","_rpdir","_refdir","_refdir2","_casquadcnt","_c","_cagroup","_carp","_carp2","_cavec","_veh","_cawp","_camarkername","_cavehmarker"];
caunits = [];
for "_deg" from 0 to 355 step 5 do
	{
		_ep = cpt_position getpos [(cpt_radius + 500), _deg];
		_myroads = _ep nearRoads 50;
		{_edgeroads0 pushBackUnique _x} forEach _myroads;
	}; // array of roadpieces within 20 of a radius 250 outside the OA
// note roadpieces dont have a dir
diag_log format ["*** dca edgeroads0 @ 19 is count %1 and is %2 ", count _edgeroads0, _edgeroads0 ];
	{
			_mname = format ["ca1%1", _foreachindex];
			_c1 = createmarker [_mname ,getpos _x];
	  		_c1 setMarkerShape "ICON";
	  		_c1 setMarkerType "hd_dot";

	} foreach _edgeroads0;
{
	_myrp0 = _x;
	_rcrp1 = roadsConnectedTo _myrp0;
	if ((count _rcrp1) > 1) then
		{
			//diag_log format ["*** dc #30 says rp0 is %1, is at %3 and has %2 connected pieces", _myrp0, count (roadsConnectedTo _myrp0), getpos _myrp0];
			_rpdir = _myrp0 getdir (_rcrp1 select 0);
			_refdir = cpt_position getdir _myrp0;
			//if (_rpdir > 180) then {_refdir2 = _refdir - 180};
			if ( (( [_rpdir, _refdir, 45] call  tky_fnc_isNumInRangeDegrees) or ([(_rpdir + 180), (_refdir), 45] call tky_fnc_isNumInRangeDegrees)) and// find rp realy facing towards cpt
			    	{
			    		((_myrp0 distance2D getMarkerPos "fobmarker") > 75) and//not near fob
			    		((_myrp0 distance2D forward) > 75) and// not near forward
			    		(count (nearestTerrainObjects [player, ["bush", "tree", "rock"], 7, false, true]) < 3) and //not on a forest trail
			    		(((getpos _myrp0) getEnvSoundController "forest" ) < 0.9)//not on a forest trail
			    	}) then
				{
					_edgeroads1 pushBack _myrp0;
					_mname = format ["ca2%1", _foreachindex];
					_c1 = createmarker [_mname ,_myrp0];
			  		_c1 setMarkerShape "ICON";
			  		_c1 setMarkerType "mil_flag";
			  		diag_log format ["*** rp at %1 has dir %2 and dir to cpt is %3", getpos _myrp0, floor _rpdir, floor _refdir];

				};
		};
} forEach _edgeroads0;
// edgeroads1 should now contain only roadpeices that, more or less, point towards the cpt and are not near the forward or fob
diag_log format ["*** er1 has count %1 elements ", count _edgeroads1];

if ((count _edgeroads1)> 2) then
	{// a couple of good places to spawn CA  troops
		_casquadcnt = (1 + floor ( random (count _edgeroads1 / 3))) min 5;
		diag_log format ["*** dca going to make %1 squads", _casquadcnt];
		for "_c" from 1 to _casquadcnt do
			{
				_cagroup = createGroup [east, true];
				_carp = selectRandom _edgeroads1;
				_edgeroads1 = _edgeroads1 - [_carp];
				_carp2 = (roadsConnectedTo _carp) select 0;
				// choose which quilin to spawn according to island
				_cavec = selectRandom opforcavecs;
				_veh = [getpos _carp, _carp getdir cpt_position, _cavec, _cagroup] call tky_fnc_spawnandcrewvehicle;

				// work out what comes back from this fnc so we can add them to caunits and smcleanup
				_cawp = _cagroup addWaypoint [cpt_position, 0];
				_cawp setWaypointType "unload";
				_cawp setWaypointCompletionRadius (floor random 25);
				_cawp setWaypointCombatMode "red";
				_cawp setWaypointSpeed "limited";
				_cawp setWaypointStatements ["true", "[group this,(getpos forward)] call BIS_fnc_taskAttack"];
				_cagroup setCombatMode "red";
				_cagroup setSpeedMode "limited";
				_camarkername = format ["camname%1", _c];
				_cavehmarker = createMarker [_camarkername, _veh];
				_cavehmarker setMarkerShape "icon";
				_cavehmarker setMarkerType "o_support";
				[_veh, _cavehmarker] spawn
					{
						while {true} do
						{
						(_this select 1) setMarkerPos (getpos (_this select 0));
						sleep 1;
						};
					};
			};


	}
	else
	{// not enough good places found for spawning CA troops


	};






while {missionactive} do
	{
	sleep 3;
	if (FALSE) then// failure. enemy get a vehicle or aircraft into the middle of the town
		{
		missionsuccess = false;
		missionactive = false;
		};

	if (false) then // success. all or most enemy forces are destroyed (or they are stationary for a while)
		{
		missionsuccess = true;
		missionactive = false;
		"Your team defeated the counterattack. Good work guys." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
if (not missionsuccess) then {publicVariable "failtext"};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
