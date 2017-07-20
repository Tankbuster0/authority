//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_blueconvoytoab";// bluconvoy drive to airbase from remote
__tky_starts;
private ["_numberoftrucks"];
missionactive = true;missionsuccess = false;_smcleanup = [];

_potentialstarts = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 3000} and ((_x getvariable "targetlandmassid") isEqualTo cpt_island)};

_mystart = selectRandom _potentialstarts;

	_nr1 = _mystart nearroads 2000;// all thr roads nearby
	_nr2 = _nr1 select {count ((roadsConnectedTo _x ) isEqualTo 1)}; // all the roads that have only 1 connection, ie, are dead ends
	_nr3 = selectRandom _nr2;// take an random dead end piece

	_rp0 = _nr3;
	_rp1 = (roadsConnectedTo _nr3) select 0;// the next road peice
	_rp2 = ((roadsConnectedTo _rp1) - [_rp0]) select 0;// the next road peice that isnt rp0

//domi version did it by placing a vehicle see below

/*
// places convoy vehicles on a straight piece of road. works best if the first is v close to the centre of a road piece.
private ["_pos","_dir","_count","_vehs","_ret","_convoyleadvehicle","_previous_pos","_nextposa","_counter","_nextposb","_vec","_type", "_mytruck"];
_pos = [_this, 0] call BIS_fnc_param;
_dir = [_this, 1] call BIS_fnc_param;
_count = [_this ,2] call BIS_fnc_param;
_ret = [];
_convoyleadvehicle = createVehicle [(bluconvoyvehicles select 0), _pos, [], 0, "NONE"];
_convoyleadvehicle setdir _dir;
_ret pushBack _convoyleadvehicle;
_previous_pos = getPosATL _convoyleadvehicle;
_nextposa = _convoyleadvehicle modeltoworld [0, -22, 0];
for [{_counter = 1}, {_counter < _count}, {_counter = _counter +1}]  do
	{
	_nextposb = position ([_nextposa] call d_fnc_getnearestroad);
	if ((_counter > 0) and (_counter < (_count-1))) then {_mytruck = (bluconvoyvehicles select 1)} else {_mytruck = (bluconvoyvehicles select 2)};//middle
	_vec= createVehicle [(_mytruck), _nextposb,[],0,"NONE"];
	_vec setdir ([_vec, _previous_pos] call bis_fnc_dirTo);
	_ret pushBack _vec;
	_previous_pos = getPosATL _vec;
	_nextposa = _vec modeltoworld [0,-22,0];
	};
_ret

*/

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
