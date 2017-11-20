//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_heal1man";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private [];
switch (floor random 1) do
	{
		case 0:
		{
			comment "RTA heal game";
			// find a road piece less than 100m outside town, away from forward and fob road traffic victim heal.

			_nr = (cpt_position nearRoads 700) select {not (_x inArea "cpt_marker")}
			// from _nr, find all the rps that have a nearestterrainobjects wall near them
			//if there are some, select 1 at random, place the car there, face it towards the wall(usually a crashbarrier)
			// find the vector and setvelocity it at 20 to crash it into the wall
			// use sethitindex [1,1]and [3,1] to damage front wheels
			_nrb = _nr select {(count (nearestTerrainObjects [_x, ["Wall", 10, false, false]])) > 1};
			if (_nrb isEqualTo []) then
				{// no barriers, so make a roadside crash

				_roadpiece = selectRandom _nr;
				while {((_roadpiece nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 10]) isEqualTo [])} do
					{
						_roadpiece = selectRandom _nr;
					};
				_h1mc = createVehicle []


				}
			// if no barriers, get road dir using getdir roadsconnectedto, add 90 and shift the car until it's !onroad


			// get a position along side the car, spawn a civ and injure them, lay them down and disableai move them
			// perhaps put a driver inside and kill him

		};



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
