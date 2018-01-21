//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_counterattack";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private _smcleanup = [];
private _edgeroads0 = []; private _edgeroads1 = [];
private ["_deg","_ep","_myroads","_mname","_foreachindex","_c1","_myrp0","_rcrp1","_rpdir","_refdir","_refdir2","_casquadcnt","_c","_cagroup","_carp","_carp2","_cavec","_veh","_cadest","_cawp","_camarkername","_cavehmarker"];
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

			if ( (( [_rpdir, _refdir, 45] call  tky_fnc_isNumInRangeDegrees) or ([(_rpdir + 180), (_refdir), 45] call tky_fnc_isNumInRangeDegrees)) and// find rp realy facing towards cpt
			    	{
			    		((_myrp0 distance2D getMarkerPos "fobmarker") > 75) and//not near fob
			    		((_myrp0 distance2D forward) > 75) and// not near forward
			    		(count (nearestTerrainObjects [player, ["bush", "tree", "rock"], 7, false, true]) < 3) and //not on a forest trail
			    		(((getpos _myrp0) getEnvSoundController "forest" ) < 0.9) and //not on a forest trail
			    		((_myrp0 distance2d blubasehelipad) > 300) and //not near the airbase
			    		(not ( surfaceIsWater (_myrp0 getpos [((_myrp0 distance2d cpt_position) /2),  (_myrp0 getdir cpt_position ) ])) )// no water inbetween rp and cpt
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
// edgeroads1 should now contain only roadpieces that, more or less, point towards the cpt and are not near the forward or fob
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
				cavecs pushback _veh;
				caunits append (crew _veh);
				_cadest = selectRandom (cpt_position nearRoads 75);
				_cawp = _cagroup addWaypoint [_cadest, 5];
				_cawp setWaypointType "unload";
				_cawp setWaypointCombatMode "red";
				_cawp setWaypointBehaviour "careless";
				_cawp setWaypointStatements ["true", "(group this) leavevehicle (vehicle this); (group this) setBehaviour 'combat'; [(group this), getpos this, 150] call BIS_fnc_taskPatrol"];
				_cagroup setCombatMode "red";
				_veh limitSpeed 50;
				_camarkername = format ["camname%1", _c];
				_cavehmarker = createMarker [_camarkername, _veh];
				_cavehmarker setMarkerShape "icon";
				_cavehmarker setMarkerType "o_support";
				[_veh, _cavehmarker] spawn
					{
						while {true} do
						{
						(_this select 1) setMarkerPos (getpos (_this select 0));
						(_this select 1) setMarkerText format ["%1, %2",floor (speed (_this select 0)), (expectedDestination (driver (_this select 0 ))) select 0];
						sleep 0.2;
						};
					};
			};
	}
	else
	{// not enough good places found for spawning CA troops
	};
caaction = "wait";
while {caaction isEqualTo "wait"} do
	{
		if ( (count (vehicles inAreaArray [cpt_position, 75, 75, 0, false, -1] select {(typeOf _x) in cavecs})) isEqualTo (count cavecs) ) then
			{// all the vecs are in the town, start checking
				caaction = "go-arrived";
				diag_log format ["*** caaction says all vecs in town"];
			};
		if ( count (cavecs select {alive _x}) < count cavecs) then
			{// a vec has died on the way
				caaction = "wait";
				cavecs = cavecs - [(cavecs select {not (alive _x)})];
				diag_log format ["*** caaction says a vec is dead in transit"];
			};
		if (count (cavecs select {(fuel _x) < 0.1 }) > 0) then
			{// a vec has run out of fuel
				caaction = "wait";
				caves = cavevs - [(cavecs select {((fuel _x) < 0.1)})];
				diag_log format ["***caaction says a vec is out of fuel in transit"];



			};


	};
while {missionactive} do
	{
	sleep 3;
	if (FALSE) then// failure. enemy get a vehicle or aircraft into the middle of the town
		{
		missionsuccess = false;
		missionactive = false;
		};

	if (({alive _x} count caunits) < 3) then // success. all or most enemy forces are destroyed
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
