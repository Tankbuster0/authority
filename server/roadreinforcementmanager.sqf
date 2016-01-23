//by tankbuster
_myscript = "roadreinforcementmanager.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
waituntil {sleep 10; (west countSide allPlayers) > 0};
while !(roadblockscleared) do
{
	sleep 1800 + random 900;

	if ((west countSide allPlayers) < 1) exitWith {};

	if ((roadblockreturndata select 4) > 0) then {_handle2 = [_ptarget] execVM "server\makeroadreinforcement.sqf";};// only make roadreinf if there are roadblocks

	diag_log "****rrm calls mrr!";
};


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];