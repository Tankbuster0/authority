//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_sinktrawler";
__tky_starts;
private [];
missionactive = true;missionsuccess = false;_smcleanup = [];

_missionposs= (selectBestPlaces [cpt_position, 10000, "sea * waterDepth", 100,20]) select [0,5] ;

_missionpos = selectRandom





format ["Native fishermen reported the presence of two unusual trawlers %1 %2 of %3. Electronic intelligence gathering has determined them to be enemy. Sink them.",2,false];
 failtext = "Dudes. You suck texts";
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
