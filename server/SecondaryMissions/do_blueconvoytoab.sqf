//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_blueconvoytoab";// bluconvoy drive to airbase from remote
__tky_starts;
private ["_numberoftrucks"];
missionactive = true;missionsuccess = false;_smcleanup = [];
_potentialstarts = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 3000} };
	{
	_nr1 = nearroads _x;
	_rp0 = _nr1 select 0;
	if (count (roadsConnectedTo _rp0) == 1) then //end road piece
		{
		_rp1 = roadsConnectedTo _rp0;
		if (count (roadsConnectedTo))
		};

	} foreach _potentialstarts;
smmissionstring = format ["Do some shit at %1 and blah blah etc", _sometown getVariable "targetname"];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";

//find a remote town with a nice string of joined roads

_numberoftrucks = (2 + (floor (playersNumber west /3))) min 5;
_
while {missionactive} do
	{
	sleep 3;
	if (/*failure conditions*/) then
		{
		missionsuccess = false;
		missionactive = false;
		};

	if (/*succeed conditions*/) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
