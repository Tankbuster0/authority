//by tankbuster
//execvmd by assaultphasefinished
_myscript = "movebase";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
// when the first airbase is taken this scipt makes an airdrop of a container that lands on the spot where the blufor base is moving too
// the container unpacks into the blufor base. the base ammobox is moved (the respawn moves automatically)


//get the position for the airdrop.

//which airfield are we at?

switch (cpt_name) do
	{
	case "AAC airfield": {_blubasedroppos = [11526.2,11812.8,0]};
	case "Almyra airfield": {_blubasedroppos = [23231.6,18459.3,0]};
	case "Abdera airfield": {_blubasedroppos = [9186.27,21649,0]};
	case "Feres airfield": {_blubasedroppos = [20813.1,7243.86,0]};
	case "Molos Airfield": {_blubasedroppos = [26750.2,24615,0]};
	};
_handle = [_blubasedroppos, blufordropaircraft, "Land_Cargo40_military_green_F", [0,0,0]] execVM "server\spawnairdrop.sqf";

sleep 10;
{deletevehicle _x;}foreach(_blubasedroppos nearobjects 10); /clear the landing point

waitUntil

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];