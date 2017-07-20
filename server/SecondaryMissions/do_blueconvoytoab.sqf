//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_blueconvoytoab";// bluconvoy drive to airbase from remote
__tky_starts;
private ["_smcleanup","_potentialstarts","_numberoftrucks","_mystart","_nr1","_nr2","_nr3","_trucks","_vec0","_nrs","_nextposa","_prevpos","_prevroadpiece","_nearroadstopos","_nextposb"];
missionactive = true;missionsuccess = false;_smcleanup = [];

_potentialstarts = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 3000} and ((_x getvariable "targetlandmassid") isEqualTo cpt_island)};
_numberoftrucks = 2 + (floor (playersNumber west /3));
_mystart = selectRandom _potentialstarts;

_nr1 = _mystart nearroads 2000;// all thr roads nearby
_nr2 = _nr1 select {count ((roadsConnectedTo _x ) isEqualTo 1)}; // all the roads that have only 1 connection, ie, are dead ends
_nr3 = selectRandom _nr2;// take an random dead end piece
_trucks = selectRandom blufortrucktypes;

_vec0 = createVehicle [(selectRandom _trucks), getpos _nr3, [],0,"NONE"];
_vec0 setdir (_vec0 getdir ((_nrs roadsConnectedTo) select 0)); // we know theres a roadconnectedto so orient the vehicle towards it
_nextposa = _vec0 modeltoworld [0, 22, 0]; //look 22m infront
_prevpos = getpos _nr3;
_prevroadpiece = nr3;
for "_i" from 1 to _numberoftrucks do
	{
	_nearroadstopos = _nextposa nearRoads 15;// get rp near the position in front of the previous truck
	_nearroadstopos = _nearroadstopos - [_prevroadpiece];// just in case, remove the previous rp from any found
	if (_nearroadstopos isEqualTo []) then
		{
		_nearroadstopos = (_nextposa nearRoads 25);
		_nearroadstopos = _nearroadstopos - [_prevroadpiece];// just in case the nr 15 didnt get anything, we look further out
		};
	_nearroadstopos = [_nearroadstopos,[],{_prevpos distance2d _x},"ASCEND"] call BIS_fnc_sortby;// sort them so select 0 is closet to prevpos
	_nextposb = getpos (_nearroadstopos select 0);// get its position
	_vec0 = createVehicle [(selectRandom _trucks), getpos _nextposb, [],0,"NONE"];
	_vec0 setdir  (_prevroadpiece getDir _vec0); // set its direction away from the previous truck position

	_nextposa = _vec0 modelToWorld [0,22,0]; // get a pos in front of the truck for next iteration
	_prevpos = _nextposb; // reset for next loop
	_prevroadpiece = (_nearroadstopos select 0);// reset for next loop




	};



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
