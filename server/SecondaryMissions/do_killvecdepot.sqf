//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_killvecdepot";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private [];
//select a town on same island of they have no helicopters
_vecdepottowns = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) > -1) and {(_x distance2d cpt_position) > 1000}};
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
_mfpos = _meadowdata select 0;
//^^ choose one to start with, then below, if it isnt good, keep choosing until it is.
while
	{(	((_mfpos distance2D getMarkerPos "fobmarker") < 100) or ((_mfpos distance2D forward) < 100) or (_mfpos inArea format ["cpt_marker_%1", primarytargetcounter] ) or (_mfpos distance2D (nearestBuilding _mfpos) < 40 )	)	}
		do //choose a position that isn't near the fobveh or the forward vehicle or inside the town marker
		{
		_meadowdata = selectRandom _meadows;
		_mfpos = _meadowdata select 0;
		};


_distanddir = [_mytarget] call tky_fnc_distanddirfromtown;
smmissionstring = format ["Do some shit at %1 and blah blah etc", _sometown getVariable "targetname"];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";

 failtext = "Dudes. You suck texts";
_
while {missionactive} do
	{
	sleep 3;
	if (/*failure conditions*/) then
		{
		missionsuccess = false;
		missionactive = false;
		failtext = "You suck. Mission failed because of reasons"; publicVariable "failtext";
		};

	if (/*succeed conditions*/) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
