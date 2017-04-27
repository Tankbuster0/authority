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

	diag_log "*** arcm finished sleeping. now checking if target moved on and radar still up";

	if (_cptc != primarytargetcounter)  exitWith {diag_log "***arm quits because primary target moved on"};
	if !(alive pt_radar) exitwith {diag_log "***arm quits because radar destroyed"};


	if (((west countSide allPlayers) > 1)) then
		{
		diag_log "***arcm has enough players and is looking for a spot";
		//nul = [cpt_position, false,2,1,false, true, player,"random", 600, true, false,20,[0.25,0.25,0.8,0.45,0.6,0.45,0.45,0.55,1,0.55],nil,nil,nil] execVM "server\PT_ai\ai_reinforcementChopper.sqf";// only make airreinf if there are playerd
		_lpos = islandcentre;
		_testradius = 16;
		while {_lpos isEqualTo islandcentre } do
			{
			_lpos = [cpt_position, 1, _testradius, 20, 0, 0.25, 0] call BIS_fnc_findSafePos;
			_testradius = _testradius * 2;
			};
		diag_log format ["***arcm finds a nice spot at %1, %2 m from target centre", _lpos, _lpos distance cpt_position];
		_hpad = createVehicle ["Land_HelipadEmpty_F", _lpos, [],0, "NONE"];
		_nul = [_hpad] execVM "server\PT_ai\tky_aireinforcementchopper.sqf";
		reinforcementcounter = reinforcementcounter + 1;
		};
};



__tky_ends