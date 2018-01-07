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
for "_deg" from 0 to 355 step 5 do
	{
		_ep = getpos [(cpt_radius + 250), _deg];
		_myroads = _ep nearRoads 20 select ;
		{_edgeroads0 pushBackUnique _x} forEach _myroads;
	};
// note roadpieces dont have a dir
{
	_myrp0 = _x;
	_myrp1 = (roadsConnectedTo _myrp0) select 0;
	_rpdir = _myrp0 getdir _myrp1;
	_refdir = cpt_position getdir _myrp0;
	_rpdir = _rpdir + 1000;
	_refdir = _refdir + 1000;// add 1000 to them so that the 359 degrees is nearly 01 failure problem cannot arise;
	if (
	    	(_rpdir < (_refdir + 45)) or
	    	(_rpdir > (_refdir - 45)) or
	    	((_rpdir + 180) < (_refdir + 225)) or
	    	((_rpdir + 180) > (_refdir + 135))
	   ) and
		{((_myrp0 distance2D getMarkerPos "fobmarker") > 75) and ((_mfpos distance2D forward) < 75) }

	    then
		{
			_edgeroads1 pushBack _myrp0;
		};
} forEach _edgeroads0;
// edgeroads1 should now contain only roadpeices that, more or less, point towards the cpt and are not near the forward or fob




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
