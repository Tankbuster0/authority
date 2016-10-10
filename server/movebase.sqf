//by tankbuster
//execvmd by assaultphasefinished
_myscript = "movebase";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_blubasedroppos","_composition","_airstripdata","_secairstrip","_airportilsindata","_airstripilsindata","_ils1indata","_closestdistance","_closestone","_mydistance","_handle","_naughtybaseobjects","_naughtybaseobject","_mypos", "_candidatepos"];
// when the first airbase is taken this scipt makes an airdrop of a container that lands on the spot where the blufor base is moving too
// the container unpacks into the blufor base. the base ammobox is moved (the respawn moves automatically)


//get the position for the airdrop.

//which airfield are we at?
switch (cpt_name) do
	{
	case "AAC airfield":
		{
		_blubasedroppos = [11526.2,11812.8,0];
		_composition = aac_blubase;
		};
	case "Almyra airfield":
		{
		_blubasedroppos = [23231.6,18459.3,0];
		_composition = almyra_blubase;
		};
	case "Abdera airfield":
		{
		_blubasedroppos = [9186.27,21649,0];
		_composition = abdera_blubase;
		};
	case "Feres airfield":
		{
		_blubasedroppos = [20813.1,7243.86,0];
		_composition = feres_blubase;
		};
	case "Molos Airfield":
		{
		_blubasedroppos = [26750.2,24615,0];
		_composition = molos_blubase;
		};
	case "La Rochelle Aerodrome":
		{
		_blubasedroppos = [11689.1,13117.5,0];
		_composition = la_rochelle_blubase;
		};
	case "Aéroport de Tanoa":
		{
		_blubasedroppos = [6920.95,7243.08,0];
		_composition = aeroporto_de_tanoa_blubase;
		};
	case "Saint-George Airstrip":
		{
		_blubasedroppos = [11740.6,3138.2,0.00143909];
		_composition = st_george_blubase;
		};
	case "Bala Airstrip":
		{
		_blubasedroppos = [2138.08,3446.05,0];
		_composition = bala_blubase;
		};
	case "Tuvanaka Airbase":
		{
		_blubasedroppos = [2120.12,13330.4,0];
		_composition = tuvanaka_blubase;
		};
	};
// try to find the nearest ilsTaxiIn to the current airfield, its going to be the drop pos for containerised air prizes
//first get all the secondary airstrips
_airstripdata = [];
for  "_i" from 1 to 10 do // get airstrip data
	{
	_secairstrip =  format ["Airstrip_%1", _i];
	//diag_log format ["***mb @ 46 airstrip name is %1", _secairstrip];
	_airstripilsindata = getarray (configfile >> "CfgWorlds" >> worldName >> "SecondaryAirports" >> _secairstrip >> "ilsTaxiIn");
	//diag_log format ["***mb @ 48. _airstripilsindata = %1", _airstripilsindata];
	if ((count _airstripilsindata) > 0) then // we're looking at an existing airstrip
		{
		_ils1indata = _airstripilsindata select [0,2]; //take the first 2 numbers, it's the ilsIn1 entry. returns a 2d array
		//diag_log format ["*** mb @ 52, _ilsindata is %1", _ils1indata];
		_airstripdata pushback _ils1indata;// pushback it into a master array, so, this is a nested array of 2d positions

	//diag_log format ["***mb @ 55. _airstripdata %1", _airstripdata];

		};
	};
// now add the ilsin1 of the islands main airfield...
_airbaseilsindata = getarray (configFile >> "CfgWorlds" >> worldName >> "ilsTaxiIn");
_ils1indata = _airbaseilsindata select [0,2];
_airstripdata pushback _ils1indata;
// find the nearest one
_closestdistance = 99999999;
_closestone = [];
	{
		_mydistance = (_x distance _blubasedroppos);
		//diag_log format ["*** mb @ 60. comparing %1 and %1", _mydistance, _closestdistance];
		if (_mydistance <= _closestdistance) then
		{
			_closestdistance = _mydistance;
			_closestone = _x;
		};
	} foreach _airstripdata;

airhead_container_landing_point = _closestone;
diag_log format ["***move base says nearest ilsin1 is at %1", _closestone];
diag_log format ["***movebase is at %1, pos = %2,", cpt_name, _blubasedroppos];
headmarker1 setMarkerPos _blubasedroppos;
headmarker2 setMarkerPos _blubasedroppos;
headmarker2 setMarkerText "AIRHEAD";
_handle = [_blubasedroppos, blufordropaircraft, "Land_Cargo40_military_green_F", [0,0,0]] execVM "server\spawnairdrop.sqf";
diag_log "*** returned from spawnairdrop";
sleep 5;
diag_log "***clearing landing point";
waitUntil {sleep 1; not isnil "mycontainer"};
waitUntil {sleep 0.5;(getposATL mycontainer select 2) < 20};
_naughtybaseobjects = nearestobjects [_blubasedroppos, [], 40];
//_naughtybaseobjects = _blubasedroppos nearobjects 20;
if (count _naughtybaseobjects > 0) then
	{
		{
		if (_x in [fobveh, forward]) then //things that mustnt be deleted
			{
			diag_log format ["*** leaving _naughtybaseobject %1, %2", _x, typeof _x];
			//find safeplace and move the object
			//get which direction the vehicle is from the centre
			_dir1 = _blubasedroppos getdir _x;
			//get a candidate position 45m in that direction , 45m from the centre of blubasedroppos
			_candidatepos =  _blubasedroppos getpos [40, _dir1];
			//now find a good empty spot nearby
			_testradius = sizeOf (typeOf _x);
			_sizeof = sizeOf (typeOf _x);
			_candidatepos2 = [0,0,0];
			while {_candidatepos2 in [[0,0,0], islandcentre]} do
				{
				_candidatepos2 = [_candidatepos, 0, _testradius,_sizeof, 0,0,0] call BIS_fnc_findSafePos;
				_testradius = _testradius + _sizeof;
				};

			diag_log format ["*** moving forward from %1 to %2, a distance of %3", getpos forward, _candidatepos, ((getpos forward) distance2d _candidatepos) ];
			forward setVehiclePosition [_candidatepos, [],0,"NONE"];
			}
			else
			{
		    deletevehicle _x;
			diag_log format ["***removing _naughtybaseobject %1, %2", _x, typeOf _x];
			};
		} foreach _naughtybaseobjects;
	};
sleep 2;


waitUntil {(getposATL mycontainer select 2) < 2};
diag_log "***removing mycontainer and spawning composition";
deletevehicle mycontainer;
blubaseobjects = [cpt_position, 0, _composition] call tky_fnc_t_objectsmapper;
{_x setdamage 0;} foreach blubaseobjects;
_mypos = getpos ammoboxcone;
deleteVehicle ammoboxcone;
ammoboxpad setpos _mypos;
baseflag setFlagTexture "pics\hom_flag_white_stripe512.paa";
_mypos = getpos terminalcone;
deleteVehicle terminalcone;
blubasedataterminal setpos _mypos;




diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];