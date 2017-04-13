//by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_reinforcementChoppermanager.sqf";
__tky_starts;
_cptc = primarytargetcounter;
waituntil {sleep 10; (west countSide allPlayers) > 0};
while {(alive pt_radar)} do
{
	//sleep 1800 + random 900;
	sleep 60;

	//diag_log "*** arm finished sleeping. now checking if target moved on and radar still up";

	if (_cptc != primarytargetcounter)  exitWith {diag_log "***arm quits because primary target moved on"};
	if !(alive pt_radar) exitwith {diag_log "***arm quits because radar destroyed"};


	if (((west countSide allPlayers) > 1)) then
		{
		nul = [cpt_position, false,2,0,false, true, getmarkerpos "forwardmarker","random", 3000, true, false,8,[0.25,0.25,0.8,0.45,0.6,0.45,0.45,0.55,1,0.55],[false, true, false, false],nil,nil,nil, false, false, "ALL"] execVM "LV\reinforcementChopper.sqf";// only make airreinf if there are playerd

		reinforcementcounter = reinforcementcounter + 1;
		};
};



__tky_ends