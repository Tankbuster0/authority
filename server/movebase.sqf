//by tankbuster
//execvmd by assaultphasefinished
_myscript = "movebase";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_blubasedroppos","_composition","_airstripdata","_secairstrip","_airportilsindata","_airstripilsindata","_ils1indata","_closestdistance","_closestone","_mydistance","_handle","_naughtybaseobjects","_naughtybaseobject","_mypos"];
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
	};
_airstripdata = [];
for  "_i" from 1 to 20 do // get airstrip data
	{
	_secairstrip =  format ["Airstrip_%1", _i];
	_airportilsindata = getarray (configfile >> "CfgWorlds" >> worldName >> "SecondaryAirports" >> _secairstrip >> "ilsTaxiIn");
	if ( count _airstripilsindata > 0) then // we're looking at an existing airstrip
		{
		_ils1indata = _airstripilsindata select [0,2]; //take the first 2 numbers, it's the ilsIn1 entry. returns an array
		_airstripdata pushback _ils1indata;// nested array!
		};
	_closestdistance = 999999;
	_closestone = [];
		{
			_mydistance = (_x distance _blubasedroppos)
			if (_mydistance < _closestdistance) then
			{
				_closestdistance = _mydistance;
				_closestdistance = _x;
			};
		} foreach _airstripdata;
	};
airhead_container_landing_point = _closestone;
diag_log format ["***movebase is at %1, pos = %2,", cpt_name, _blubasedroppos];
headmarker1 setMarkerPos _blubasedroppos;
headmarker2 setMarkerPos _blubasedroppos;
headmarker2 setMarkerText "AIRHEAD";
_handle = [_blubasedroppos, blufordropaircraft, "Land_Cargo40_military_green_F", [0,0,0]] execVM "server\spawnairdrop.sqf";
diag_log "*** returned from spawnairdrop";
//sleep 10;
diag_log "***clearing landing point";
_naughtybaseobjects = nearestobjects [_blubasedroppos, [], 20];
if (count _naughtybaseobjects > 0) then
	{
		{
		if not ((typename _x) in [forwardpointvehicleclassname, fobvehicleclassname]) then //things that must not be deleted
			{
		    deletevehicle _x;
			diag_log format ["***removing _naughtybaseobject %1", _x];
			};
		} foreach _naughtybaseobjects;
	};
sleep 2;

waitUntil {sleep 1; not isnil "mycontainer"};
waitUntil {(getposATL mycontainer select 2) < 2};
diag_log "***removing mycontainer and spawning composition";
deletevehicle mycontainer;
blubaseobjects = [cpt_position, 0, _composition] call tky_fnc_t_objectsmapper;
{_x setdamage 0;} foreach blubaseobjects;
_mypos = getpos ammoboxcone;
deleteVehicle ammoboxcone;
ammoboxpad setpos _mypos;
baseflag setFlagTexture "pics\wasp-inc_dirty_flag.paa";
_mypos = getpos terminalcone;
deleteVehicle terminalcone;
blubasedataterminal setpos _mypos;




diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];