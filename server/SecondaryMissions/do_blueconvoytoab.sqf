//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_blueconvoytoab";// bluconvoy drive to airbase from remote
__tky_starts;
private ["_smcleanup","_potentialstarts","_numberoftrucks","_mystart","_nr1","_nr2","_nr3","_trucks","_vec0","_vecx","_nrs","_nextposa","_prevpos","_prevroadpiece","_nearroadstopos","_nextposb"];
missionactive = true;missionsuccess = false;_smcleanup = [];

_potentialstarts = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 3000} and ((_x getvariable "targetlandmassid") isEqualTo cpt_island)};
diag_log format ["*** dbcta gets _potentialstarts count %1", count _potentialstarts];
_numberoftrucks = 2 + (floor ((playersNumber west) /3)) min 5;
_mystart = selectRandom _potentialstarts;
diag_log format ["*** dbcta gets chooses %1", _mystart];
_nr1 = _mystart nearroads 2000;// all thr roads nearby
_nr2 = _nr1 select {(roadsConnectedTo _x ) isEqualTo 1 }; // all the roads that have only 1 connection, ie, are dead ends

_nr3 = selectRandom _nr2;// take an random dead end piece
diag_log format ["*** dbcta chooses rp %1", _nr3];
_trucks = selectRandom blufortrucktypes;

_vec0 = createVehicle [(selectRandom _trucks), getpos _nr3, [],0,"NONE"];
_smcleanup pushback _vec0;
_vec0 setdir ( _vec0 getdir ((roadsConnectedTo _nr3) select 0) ); // we know theres a roadconnectedto so orient the vehicle towards it
_nextposa = _vec0 modeltoworld [0, 22, 0]; //look 22m infront
_prevpos = getpos _nr3;
_prevroadpiece = _nr3;
for "_i" from 1 to _numberoftrucks do
	{
	diag_log format ["*** dbcta inside loop %1 of %2", _i, _numberoftrucks];
	_nearroadstopos = _nextposa nearRoads 15;// get rp near the position in front of the previous truck
	_nearroadstopos = _nearroadstopos - [_prevroadpiece];// just in case, remove the previous rp from any found
	if (_nearroadstopos isEqualTo []) then
		{
		_nearroadstopos = (_nextposa nearRoads 25);
		_nearroadstopos = _nearroadstopos - [_prevroadpiece];// just in case the nr 15 didnt get anything, we look further out
		};
	_nearroadstopos = [_nearroadstopos,[],{_prevpos distance2d _x},"ASCEND"] call BIS_fnc_sortby;// sort them so select 0 is closet to prevpos
	_nextposb = getpos (_nearroadstopos select 0);// get its position
	_vecx = createVehicle [(selectRandom _trucks), getpos _nextposb, [],0,"NONE"];
	_vecx setdir (_prevroadpiece getDir _vecx); // set its direction away from the previous truck position
	_smcleanup pushback _vecx;
	_nextposa = _vecx modelToWorld [0,22,0]; // get a pos in front of the truck for next iteration
	_prevpos = _nextposb; // reset for next loop
	_prevroadpiece = (_nearroadstopos select 0);// reset for next loop
	};

_smnrlogs = ((getpos _nr3) nearEntities ["Logic", 4000]) select {( ((_x getVariable ["targetstatus", -1]) isEqualTo 1) and ((_x distance _nr3) < 4000) ) };
diag_log format ["***dbcta unsorted logics near the mission pos %1", _smnrlogs];
_sortedsmnrlogs = [_smnrlogs, [] , {_x distance2d _nr3}, "ASCEND"] call BIS_fnc_sortBy;
diag_log format ["***dst sorted the logics near mission pos %1", _sortedsmnrlogs];
_smnrlog = _sortedsmnrlogs select 0;
_smnrtown = (_smnrlog getVariable "targetname");
_smdir = [(_smnrlog getDir _nr3)] call tky_fnc_cardinaldirection;
_smdist = [(_smnrlog distance2D _nr3), 500] call tky_fnc_estimateddistance;
smmissionstring = format ["There's a convoy formed up %1m %2 %3 but the transport taking the driver crew has not made it. Send a team and get the convoy, in it's entirity to the centre of %4. They must stay together while on the move. Expect enemy activity all along the route.", _smdist, _smdir,_smnrtown, cpt_name ];
publicVariable "smmissionstring";
smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];

while {missionactive} do
	{
	sleep 3;

	if ( !(_smcleanup isEqualTo ((vehicles inAreaArray [_vecx, 100,100,0,false, -1]) select {(typeof _x) in _trucks} )) ) then
		{// ^^ if the cleanup array isnt the same as vehicles (but only those from the trucks array) within 100m of the 2nd truck
		missionsuccess = false;
		missionactive = false;
		};

	{// if a vehicle gets out of an 80 circle around mid vehicle
	if (not (_x inarea [_vecx, 80,80,0,false, -1] )) then
	 	{
	 	"You are dropping out of the convoy Stay together!" remoteExec ["Hint", _x];

	 	};
	}forEach _smcleanup;

	{
		if (not alive _x) exitWith
			{// fail if any vehicle dies
			missionactive = false;
			missionsuccess = false;
			};
	} foreach _smcleanup;

	if (FALSE) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends