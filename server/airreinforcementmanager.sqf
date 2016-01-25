//by tankbuster
_myscript = "airreinforcementmanager.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
_cptc = primarytargetcounter;
waituntil {sleep 10; (west countSide allPlayers) > 0};
while {(alive pt_radar)} do
{
	sleep 1800 + random 900;
	diag_log "*** arm finished sleeping. now checking if target moved on and radar still up";

	if (_cptc != primarytargetcounter)  exitWith {diag_log "***arm quits because primary target moved on"};
	if !(alive pt_radar) exitwith {diag_log "***arm quits because radar destroyed"};


	if (((west countSide allPlayers) < 1)) then
		{
		_handle2 = [primarytarget] execVM "server\makeairreinforcement.sqf";// only make roadreinf if there are playerd

		diag_log "****arm calls mar!";
		};
};



diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];