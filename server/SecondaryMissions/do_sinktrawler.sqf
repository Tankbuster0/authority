//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_sinktrawler";
__tky_starts;
//// functions
_s1hit =
	{
	params ["_sh_engaging_vec"];
	smship1 removeallEventHandlers "handledamage";
	engagingveh1 = _sh_engaging_vec;
	attackunderway = true;
	};
_s2hit =
	{
	params ["_sh_engaging_vec"];
	smship2 removeallEventHandlers "handledamage";
	engagingveh2 = _sh_engaging_vec;
	attackunderway = true;
	};

private ["_smcleanup","_missionposs","_missionpos","_smnrlog","_smnrtown","_smdir","_smdist","_smdir2","_smdist2", "_engagingveh", "_1sinking", "_2sinking"];
missionactive = true;missionsuccess = false; attackunderway = false; engagingveh1 = objNull; engagingveh2 = objNull;
_1sinking = false; _2sinking = false;_smcleanup = [];
failtext = "You didn't sink those ships. Mission failed.";
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
ship1eh =  smship1 addEventHandler ["handledamage", "call fnc_s1hit"];#

_smcleanup pushback smship1; _smcleanup pushBack smship2;

while {missionactive} do
	{
	sleep 3;

	if ( (not _1sinking) and {((damage smship1) isEqualTo 1)}) then
		{
		_1sinking = true;
		nul = [smship1, "RANDOM", (10 + (random 10)), true] execVM "SecondaryMissions\sinkship.sqf";
		};
	if ((not _2sinking) and { ((damage smship2) isEqualTo 1)}) then
		{
		_2sinking = true;
		nul = [smship2, "RANDOM", (10 + (random 10)), true] execVM "SecondaryMissions\sinkship.sqf";
		};

	if (not (isNull engagingveh1) and {(fuel engagingveh1 isEqualTo 0) or (damage engagingveh1 > 0.9) or (not (someAmmo engagingveh1))}  )then
		{
		missionsuccess = false;
		missionactive = false;
		};
	if (not (isNull engagingveh2) and {(fuel engagingveh2 isEqualTo 0) or (damage engagingveh2 > 0.9) or (not (someAmmo engagingveh2))}  )then
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

