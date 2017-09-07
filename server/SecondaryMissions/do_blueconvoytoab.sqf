//by George
 #include "..\includes.sqf"
_myscript = "do_blueconvoytoab";// bluconvoy drive to airbase from remote
__tky_starts;
private ["_smcleanup","_potentialstarts","_numberoftrucks","_mystart","_nr1","_nr2","_nr3","_trucks","_trucktype","_vec0","_nextposa","_prevpos","_prevroadpiece","_nearroadstopos","_nextposb","_vecx","_smnrlogs","_sortedsmnrlogs","_smnrlog","_smnrtown","_smdir","_smdist","_smdist1", "_smtext"];
missionactive = true;missionsuccess = false;_smcleanup = [];
publicVariable "missionactive"; publicVariable "missionsuccess";
_potentialstarts = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 2500} and ((_x getvariable "targetlandmassid") isEqualTo cpt_island)};
diag_log format ["*** dbcta gets _potentialstarts count %1", count _potentialstarts];
_numberoftrucks = 2 + (floor ((playersNumber west) /3)) min 5;
_mystart = selectRandom _potentialstarts;
diag_log format ["*** dbcta gets chooses %1 which is %2", _mystart, _mystart getVariable "targetname"];
_nr1 = _mystart nearroads 2000;// all thr roads nearby
diag_log format ["*** dbcta gets nearby rps %1", _nr1];
_nr2 = _nr1 select {(count (roadsConnectedTo _x )) isEqualTo 1 }; // all the roads that have only 1 connection, ie, are dead ends
diag_log format ["*** dbcta gets deadends %1", _nr2];
_nr3 = selectRandom _nr2;// take an random dead end piece
diag_log format ["*** dbcta chooses rp %1", _nr3];
_trucks = selectRandom blufortrucktypes;
diag_log format ["***dbcta chooses %1 truck types", _trucks];
_trucktype = selectRandom _trucks;
diag_log format ["***dbcta going to spawn lead vehicle, a %1 at %2", _trucktype, getpos _nr3];
_vec0 = createVehicle [_trucktype, getpos _nr3, [],0,"NONE"];
_smcleanup pushback _vec0;
_vec0 setdir ( _vec0 getdir ((roadsConnectedTo _nr3) select 0) ); // we know theres a roadconnectedto so orient the vehicle towards it
_nextposa = _vec0 modeltoworld [0, 22, 0]; //look 22m infront
_prevpos = getpos _nr3;
_prevroadpiece = _nr3;
for "_i" from 2 to _numberoftrucks do
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
	_trucktype = selectRandom _trucks;
	diag_log format ["***dbcta going to spawn a %1 at %2", _trucktype, _nextposb];
	_vecx = createVehicle [_trucktype, _nextposb, [],0,"NONE"];
	_vecx setdir (_prevroadpiece getDir _vecx); // set its direction away from the previous truck position
	_smcleanup pushback _vecx;
	_nextposa = _vecx modelToWorld [0,22,0]; // get a pos in front of the truck for next iteration
	_prevpos = _nextposb; // reset for next loop
	_prevroadpiece = (_nearroadstopos select 0);// reset for next loop
	};
_smtext = [(_nr3)] call tky_fnc_distanddirfromtown;
smmissionstring = format ["There's a convoy formed up %1 but the transport taking the driver crew has not made it. Send a team and get the whole convoy to %2. They must stay together while on the move. Expect enemy activity all along the route.", _smtext, cpt_name ];
publicVariable "smmissionstring";
smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
while {missionactive} do
	{
	sleep 3;
		{// if a vehicle gets out of an 100 circle around mid vehicle
	if (not (_x inarea [_vecx, 100,100,0,false, -1] )) then
	 	{
		missionsuccess = false; publicVariable "missionsuccess";
		missionactive = false; publicVariable "missionactive";
	 	};
	}forEach _smcleanup;
	{// if a vehicle gets out of an 80 circle around mid vehicle
	if (not (_x inarea [_vecx, 80,80,0,false, -1] )) then
	 	{
	 		{
		 	"You are dropping out of the convoy. Stay together!" remoteExec ["Hint", _x];
		 	"alarmcar" remoteexec ["playsound", _x , false];// should play the car alarm to all vehicles in the convoy
		 	} foreach _smcleanup;
	 	};
	}forEach _smcleanup;
	{
		if (not alive _x) exitWith
			{// fail if any vehicle dies
			missionactive = false; publicVariable "missionactive";
			missionsuccess = false; publicVariable "missionsuccess";
			failtext = "You didn't keep the convoy together. Mission failed"; publicVariable "failext";
			};
	} foreach _smcleanup;
	if ( (count ((vehicles inAreaArray [cpt_position, 75,75,0, false, 5]) select {_x in _smcleanup})) isEqualTo (count _smcleanup) ) then
		{// all cleanup vehicles get into a 75m circle at the centre of the town marker. check 75 is radius or circumference
		missionsuccess = true; publicVariable "missionsuccess";
		missionactive = false; publicVariable "missionactive";
		"The convoy reached its destination! Great driving!" remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";
__tky_ends