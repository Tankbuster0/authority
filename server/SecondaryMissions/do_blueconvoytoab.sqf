//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_blueconvoytoab";// bluconvoy drive to airbase from remote
__tky_starts;
private ["_numberoftrucks"];
missionactive = true;missionsuccess = false;_smcleanup = [];
_potentialstarts = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 3000} };
// ^^^ improve this so it chooses potential start on same island
_mystart = selectRandom _potentialstarts;

	_nr1 = _mystart nearroads 2000;// all thr roads nearby
	_nr2 = _nr1 select {count ((roadsConnectedTo _x ) isEqualTo 1)}; // all the roads that have only 1 connection, ie, are dead ends
	_nr3 = selectRandom _nr2;// take an random dead end piece

	_rp0 = _nr3;
	_rp1 = (roadsConnectedTo _nr3) select 0;// the next road peice
	_rp2 = ((roadsConnectedTo _rp1) - [_rp0]) select 0;// the next road peice that isnt rp0



// go again if the above routine fails in some way
// check how we did this in domi.. might be better

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