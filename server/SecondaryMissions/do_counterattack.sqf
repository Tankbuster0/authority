//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_counterattack";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private ["_ep"];
private _smcleanup = [];
private _edgeroads0 = [];
private _edgeroads1 = [];
caunits = [];
for "_deg" from 0 to 355 step 5 do
	{
		_ep = getpos [(cpt_radius + 250), _deg];
		_myroads = _ep nearRoads 20 select ;
		{_edgeroads0 pushBackUnique _x} forEach _myroads;
	}; // array of roadpieces within 20 of a radius 250 outside the OA
// note roadpieces dont have a dir
{
	_myrp0 = _x;
	_myrp1 = (roadsConnectedTo _myrp0) select 0;
	_rpdir = _myrp0 getdir _myrp1;
	_refdir = cpt_position getdir _myrp0;
	if ( [_rpdir, _refdir, 45] call  tky_fnc_isNumInRangeDegrees) and {((_myrp0 distance2D getMarkerPos "fobmarker") > 75) and ((_mfpos distance2D forward) < 75) } then
		{
			_edgeroads1 pushBack _myrp0;
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
