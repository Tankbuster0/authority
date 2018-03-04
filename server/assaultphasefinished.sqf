//by tankbuster
 #include "..\includes.sqf"
_myscript = "assaultphasefinished.sqf";
__tky_starts;
private ["_ruinstartcount","_ruinendcount","_heartandmindscore","_sm_required","_sm_hint","_smmhandle", "_handle2", "_handle4"];
{deletevehicle _x} foreach pt_tripmines;
if (primarytargetcounter isEqualTo 1) then
	{
	taskbool = [taskname, "SUCCEEDED", true] call bis_fnc_taskSetState;
	handle_mb_finished = false;
	run_replacequads = false;
	_handle4 = execVM "server\movebase.sqf";
	waitUntil {handle_mb_finished};

	};
if (cpt_type != 1) exitWith // if it wasn't a civ town, go straight to primary target cleared
	{
	nul = execVM "server\primarytargetcleared.sqf";
	};
_ruinstartcount = nextpt getVariable "targetruincount";
_ruinendcount = (count (cpt_position nearObjects ["Ruins", cpt_radius]));
heartandmindscore = (_ruinendcount - _ruinstartcount) + civkillcount + reinforcementcounter + captivekillcounter;// plus a point if captive opfor are killed
diag_log format ["****h&m = %1, ruinend %2 ruinstart %3 civkill %4 reinfcntr %5", heartandmindscore, _ruinendcount, _ruinstartcount,civkillcount, reinforcementcounter];

sleep 1;
cpt_marker setMarkerColor "ColorUNKNOWN";

[""] call tky_fnc_usefirstemptyinhintqueue;
"Congratulations, you've driven the enemy from the AO." remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];

sleep 10;
handle_smm_finished = false;
_handle2 = [] execVM "server\SecondaryMissions\sm_manager.sqf";
waitUntil {handle_smm_finished};
smmissionstring = "There is currently no Secondary Mission";
publicVariable "smmissionstring";
if ((toLower ([taskname] call BIS_fnc_taskState)) != "succeeded" ) then
	{
	taskbool = [taskname, "SUCCEEDED", true] call bis_fnc_taskSetState;// #9 will set to succeed if ptc ==1 , otherwise, set it here after 2ndaries.
	};
nul =  execVM "server\primarytargetcleared.sqf";
__tky_ends