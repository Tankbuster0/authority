//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_sinktrawler";
__tky_starts;
private [];
missionactive = true;missionsuccess = false;_smcleanup = [];

_missionposs= (selectBestPlaces [cpt_position, 10000, "sea * waterDepth", 100,20]) select [0,5] ;

_missionpos = selectRandom _missionposs;

_smnrlog = ((_missionpos nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 2000} }) select 0;

_smnrtown = (_smnrlog getVariable "targetname");

_smdir = (_smnrtown getDir _missionpos);
_smdist = (_smnrtown distance2D _missionpos);

_smdir2 = [_smdir] call tky_fnc_cardinaldirection;
_smdist2 = [_smdist, 500] call tky_fnc_estimateddistance;


smmissionstring = format ["Native fishermen reported the presence of two unusual surface vessels %1 %2 of %3. Electronic intelligence gathering has determined them to be enemy. Sink them.", _smdist2, _smdir2,_smnrtown ];

smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];

smship1 = createvehicle ["C_Boat_Civil_04_F", _missionpos, [],0, "NONE"];
smship2 = createVehicle ["C_Boat_Civil_04_F", (_missionpos getpos [(100 + random 300) , random 360]),[],0,"NONE"];
pushback
 failtext = "Dudes. You suck texts";
_smcleanup pushback smship1; _smcleanup pushBack smship2;
while {missionactive} do
	{
	sleep 3;

	if (damage smship1 isEqualTo 1) then {nul = [smship1, "RANDOM", (10 + (random 10)), true] execVM "SecondaryMissions\sinkship.sqf" };
	if (damage smship2 isEqualTo 1) then {nul = [smship2, "RANDOM", (10 + (random 10)), true] execVM "SecondaryMissions\sinkship.sqf" };
	/*
can't think of a decent failure condition for this? find the aircraft they are using for attack and watch for it's death? but
what if they are using 2 aircraft?
hate using timers, but might have to


	*/


	if (false) then //
		{
		missionsuccess = false;
		missionactive = false;
		};

	if ((damage smship1) + (damage smship2) isEqualTo 2) then
		{
		sleep 10;
		missionsuccess = true;
		missionactive = false;
		"Both ships are gone. Nice work." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends

