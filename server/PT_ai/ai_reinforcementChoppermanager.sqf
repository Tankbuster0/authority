//by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_reinforcementChoppermanager.sqf";
__tky_starts;
private ["_cptc","_lpos","_testradius","_hpad","_nul"];
_cptc = primarytargetcounter;
waituntil {sleep 10; (west countSide allPlayers) > 0};
while {(alive pt_radar)} do
{
	sleep 1800 + random 900;
	//sleep 30;
	if (_cptc != primarytargetcounter)  exitWith {diag_log "***arm quits because primary target moved on"};
	if !(alive pt_radar) exitwith {diag_log "***arm quits because radar destroyed"};


	if (((west countSide allPlayers) > 1)) then
		{
		_lpos = islandcentre;
		_testradius = 16;
		while {_lpos isEqualTo islandcentre } do
			{
			_lpos = [cpt_position, 1, _testradius, 20, 0, 0.5, 0,1,1] call tky_fnc_t_findSafePos;;
			_testradius = _testradius * 2;
			};
		diag_log format ["***arcm finds a nice spot at %1, %2 m from target centre", _lpos, _lpos distance cpt_position];
		_hpad = createVehicle ["Land_HelipadEmpty_F", _lpos, [],0, "NONE"];
		_nul = [_hpad] execVM "server\PT_ai\tky_aireinforcementchopper.sqf";
		reinforcementcounter = reinforcementcounter + 1;
		};
};
__tky_ends