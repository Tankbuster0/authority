//by tankbuster
 #include "..\includes.sqf"
_myscript = "assaultphasefinished.sqf";
__tky_starts;
private ["_ruinstartcount","_ruinendcount","_heartandmindscore","_sm_required","_sm_hint","_smmhandle", "_handle2", "_handle4"];
if (primarytargetcounter isEqualTo 1) then
	{
	_handle4 = execVM "server\movebase.sqf";
	waitUntil {sleep 1;scriptDone _handle4};
	};

if (cpt_type != 1) exitWith // if it wasn't a civ town, go straight to primary target cleared
	{
	if (testmode) then
		{
		sleep 10;
		} else
		{
		sleep 30;
		};
	nul = execVM "server\primarytargetcleared.sqf";
	};
_ruinstartcount = nextpt getVariable "targetruincount";
_ruinendcount = (count (cpt_position nearObjects ["Ruins", cpt_radius]));
heartandmindscore = (_ruinendcount - _ruinstartcount) + civkillcount + reinforcementcounter + captivekillcounter;// plus a point if captive opfor are killed
diag_log format ["****h&m = %1, ruinend %2 ruinstart %3 civkill %4 reinfcntr %5", heartandmindscore, _ruinendcount, _ruinstartcount,civkillcount, reinforcementcounter];

sleep 1;
cpt_marker setMarkerBrush "Cross";
format ["Congratulations! You've driven the enemy from the AO."] remoteexec ["hint", -2];
/*
sleep 10;
_handle2 = [] execVM "server\SecondaryMissions\sm_manager.sqf";
waitUntil {sleep 1;scriptdone _handle2};
*/
nul =  execVM "server\primarytargetcleared.sqf";
cpt_marker setMarkerBrush "Solid";
__tky_ends