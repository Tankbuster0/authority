//by tankbuster
_myscript = "doprimary.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_airfieldfilternames","_foundairfields","_locs","_currentprimarytarget","_thisscript", "_ptarget", "_npt"];
vehiclecleanup= []; mancleanup = []; returndata = nil; roadblockscleared = false;
sleep 5;
if (primarytargetcounter > 1) then
	{
	// 2nd, 3rd , 4th targets, etc
	_npt = [cpt_position] execVM "server\choosenextprimary.sqf";// creates global variable nextpt which is a logic
	waitUntil {scriptDone _npt};
	sleep 0.5;
	_ptarget = nextpt;// <-- dont forget nextpt is a logic
	_handle = [_ptarget] execVM "server\spawnroadblocks.sqf";
	waitUntil {sleep 1;(!(isnil "returndata"))};
	if ((returndata select 4) > 0) then {_handle2 = [_ptarget] execVM "server\makeroadreinforcement.sqf";};// only make roadreinf if there are roadblocks
	};
cpt_position = getpos nextpt;
cpt_radius = (nextpt getVariable "targetradius");
_ptarget = nextpt;
_handle1 = [_ptarget] execVM "server\spawnprimarytargetunits.sqf";
waitUntil {scriptDone _handle1};
//_handle2 = [_ptarget] execVM "server\makeroadreinforcement.sqf";
_flagpos = [cpt_position,1,20,3,0,20,0] call bis_fnc_findSafePos;
cpt_flag = "Flag_Red_F" createVehicleLocal _flagpos;
// create a marker
cpt_marker = createMarker [str primarytargetcounter, cpt_position];
cpt_marker setMarkerShape "ELLIPSE";
cpt_marker setMarkerType "Flag";
cpt_marker setMarkerSize [cpt_radius,cpt_radius];
cpt_marker setMarkerColor "ColorRed";
_roadblocktrigger = createTrigger ["EmptyDetector, cpt_position"];
_roadblocktrigger setTriggerArea [1,1,0,false];
_roadblocktrigger setTriggerActivation ["NONE", "NOT PRESENT", false];
_roadblocktrigger setTriggerStatements ["this && {alive _x} count (units (returndata select 3)) == 0 ", "hint' roadblocks cleared'", ""];
// make trigger that senses when town is empty of enemies
_trg = createTrigger ["EmptyDetector", cpt_position];
_trg setTriggerArea [(cpt_radius + 200),(cpt_radius + 200),0,false];
_trg setTriggerActivation  ["EAST", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "execVM 'server\primarytargetcleared.sqf'", ""];
// task stuff
taskname = "task" + str primarytargetcounter;
[west, [taskname], ["Clear the target of all enemy forces", "Clear target of enemy forces","cpt_marker"], cpt_position,1,2,true ] call bis_fnc_taskCreate;

if ((primarytargetcounter > 1)) then
	{if ((returndata select 4) > 0) then // if this isnt the first target and it has roadblocks spawned
		{
		0 spawn	{
			while {!roadblockscleared} do
				{
				sleep 5;
				deadgatecount = 0;
					{
					if ((_x animationPhase "Door_1_rot" == 1) or (!alive _x) or ((damage _x) > 0.8)) then {deadgatecount = deadgatecount +1};
					} foreach roadblockgates;
				if (deadgatecount == (count roadblockgates)) then
					{
					roadblockscleared = true;
						{
						_mytruck = _x;
							{_mytruck deleteVehicleCrew _x}foreach (crew _mytruck);
						deleteVehicle _mytruck;
						} foreach roadreinforcementvehicles;
					roadreinforcementvehicles = [];
					}
				//diag_log format ["***roadblock status %1 cleared of %2", deadgatecount, count roadblockgates];
				};

			};
		};
	};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];