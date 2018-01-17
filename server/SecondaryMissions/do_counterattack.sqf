//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_counterattack";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private _smcleanup = [];
private _edgeroads0 = [];
private _edgeroads1 = [];
private ["_deg","_ep","_myroads","_edgeroads0","_mname","_foreachindex","_c1","_myrp0","_rcrp1","_rpdir","_myrp1","_refdir","_edgeroads1","_mine","_casquadcnt","_c","_cagroup","_carp","_carp2","_cavec","_veh","_smcleanup"];
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
			diag_log format ["*** dc #30 says rp0 is %1, is at %3 and has %2 connected pieces", _myrp0, count (roadsConnectedTo _myrp0), getpos _myrp0];
			_rpdir = _myrp0 getdir (_rcrp1 select 0);
			_refdir = cpt_position getdir _myrp0;
			//if (_rpdir > 180) then {_refdir2 = _refdir - 180};
			if ( (( [_rpdir, _refdir, 45] call  tky_fnc_isNumInRangeDegrees) or ([(_rpdir), (180 + _refdir), 45] call tky_fnc_isNumInRangeDegrees)) and
			    	{
			    		((_myrp0 distance2D getMarkerPos "fobmarker") > 75) and
			    		((_myrp0 distance2D forward) < 75) and
			    		(count (nearestTerrainObjects [player, ["bush"], 10, false, true]) < 3) and
			    		(((getpos _myrp0) getEnvSoundController "forest" ) < 1)
			    	}) then
				{
					_edgeroads1 pushBack _myrp0;
					_mname = format ["ca2%1", _foreachindex];
					_c1 = createmarker [_mname ,getpos _mine];
			  		_c1 setMarkerShape "ICON";
			  		_c1 setMarkerType "mil_flag";
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
				_cavec = selectRandom opforcaves;
				_veh = [getpos _carp, _carp getdir cpt_position, _cavec, _cagroup] call tky_fnc_spawnandcrewvehicle;

				// work out what comes back from this fnc so we can add them to caunits and smcleanup
				_cagroup addWaypoint [cpt_position, 0, 0];




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
