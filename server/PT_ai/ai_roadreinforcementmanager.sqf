//by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_roadreinforcementmanager.sqf";
__tky_starts;
_cptc = primarytargetcounter;
waituntil {sleep 10; (west countSide allPlayers) > 0};
while {!roadblockscleared} do
{
	sleep 3600 + random 900;
	//diag_log "*** rrm finished sleeping. now checking if target moved on and some roadblocks still up";
	if (_cptc != primarytargetcounter) exitWith {};
	if (roadblockscleared) exitwith {};
	if ((west countSide allPlayers) > 0) then
		{
		_handle2 = [primarytarget] execVM "server\PT_ai\ai_makeroadreinforcement.sqf";// only make roadreinf if there are players
		reinforcementcounter = reinforcementcounter + 1;
		};
};
__tky_ends