//by tankbuster
//execvmd by assaultphasefinished
_myscript = "movebase";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_blubasedroppos","_composition","_handle", "_mypos"];
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
diag_log format ["***movebase is at %1, pos = %2,", cpt_name, _blubasedroppos];

_handle = [_blubasedroppos, blufordropaircraft, "Land_Cargo40_military_green_F", [0,0,0]] execVM "server\spawnairdrop.sqf";
diag_log "*** returned from spawnairdrop";
sleep 10;
diag_log "***clearing landing point";
_naughtybaseobjects = _blubasedroppos nearobjects 15;
if (count _naughtybaseobjects > 0) then
	{
		{
		deletevehicle _x;
		diag_log format ["removing _naughtybaseobjects %1", _x];
		} foreach _naughtybaseobjects;
	};
sleep 2;
diag_log "***removing mycontainer and spawning composition";
waitUntil {sleep 1; not isnil "mycontainer"};
waitUntil {(getposATL mycontainer select 2) < 2};
deletevehicle mycontainer;
blubaseobjects = [cpt_position, 0, _composition] call tky_fnc_t_objectsmapper;
{_x setdamage 0;} foreach blubaseobjects;
_mypos = getpos ammoboxcone;
deleteVehicle ammoboxcone;
ammoboxpad setpos _mypos;
baseflag setFlagTexture "pics\wasp-inc_dirty_flag.paa";





diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];