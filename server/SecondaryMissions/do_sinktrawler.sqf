//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_sinktrawler";
__tky_starts;
//// functions
tky_fnc_shiphit =
	{
	params ["_sh_engaging_vec"];
	smship1 removeallEventHandlers "handledamage";
	smship2 removeAllEventHandlers "handledamage";
	engagingveh = _sh_engaging_vec;
	attackunderway = true;
	};
private ["_smcleanup","_missionposs","_missionpos","_smnrlog","_smnrtown","_smdir","_smdist","_smdir","_smdist", "_engagingveh", "_1sinking", "_2sinking"];
missionactive = true;missionsuccess = false; attackunderway = false; engagingveh = objNull;
_1sinking = false; _2sinking = false;_smcleanup = [];
failtext = "You didn't sink those ships. Mission failed.";
_missionposs= (selectBestPlaces [cpt_position, 8000, "sea * waterDepth", 100,20]) select [0,5] ;
_missionpos1 = selectRandom _missionposs;
_missionpos = _missionpos1 select 0;
diag_log format ["***dst says %1 for mission pos", _missionpos];
_smnrlogs = (_missionpos nearEntities ["Logic", 8000]) select {( ((_x getVariable ["targetstatus", -1]) isEqualTo 1) and ((_x distance _missionpos) < 3000) ) };
diag_log format ["***dst unsorted logics near the mission pos %1", _smnrlogs];
sleep 5;
_sortedsmnrlogs = [_smnrlogs, [] , {_x distance2d _missionpos}, "ASCEND"] call BIS_fnc_sortBy;
diag_log format ["***dst sorted the logics near mission pos %1", _sortedsmnrlogs];
_smnrlog = _sortedsmnrlogs select 0;
_smnrtown = (_smnrlog getVariable "targetname");
_smdir = [(_smnrlog getDir _missionpos)] call tky_fnc_cardinaldirection;
_smdist = [(_smnrlog distance2D _missionpos), 500] call tky_fnc_estimateddistance;
smmissionstring = format ["Native fishermen reported the presence of two unusual surface vessels %1m %2 of %3. Overhead imagery has determined them to be enemy and intelligence gathering or maybe even mine layers. Sink them.", _smdist, _smdir,_smnrtown ];
publicVariable "smmissionstring";
smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
smship1 = createvehicle ["C_Boat_Civil_04_F", _missionpos, [],0, "NONE"];
sleep 0.5;
_ship2pos = smship1 getpos [(50 + random 200), random 360];
_ship2pos set [2, (abs (getTerrainHeightASL (_ship2pos)))];
smship2 = createVehicle ["C_Boat_Civil_04_F",_ship2pos ,[],0,"NONE"];
_ship1eh = smship1 addEventHandler ["handledamage", "if (isplayer (_this select 3)) then {[_this select 3] call tky_fnc_shiphit}"];
_ship2eh = smship2 addEventHandler ["handledamage", "if (isplayer (_this select 3)) then {[_this select 3] call tky_fnc_shiphit}"];
_smcleanup pushback smship1; _smcleanup pushBack smship2;
while {missionactive} do
	{
	sleep 3;
	if ( (not _1sinking) and {((damage smship1) isEqualTo 1)}) then
		{
		_1sinking = true;
		nul = [smship1, "RANDOM", (10 + (random 10)), true] execVM "server\SecondaryMissions\sinkship.sqf";
		};
	if ((not _2sinking) and { ((damage smship2) isEqualTo 1)}) then
		{
		_2sinking = true;
		nul = [smship2, "RANDOM", (10 + (random 10)), true] execVM "server\SecondaryMissions\sinkship.sqf";
		};
	if (not (isNull engagingveh) and {(fuel engagingveh isEqualTo 0) or (damage engagingveh > 0.9) or (not (someAmmo engagingveh))}  )then
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