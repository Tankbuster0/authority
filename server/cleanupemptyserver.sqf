//by tankbuster
//execvmd by assaultphasefinished
 #include "..\includes.sqf"
_myscript = "cleanupemptyserver";
__tky_starts;
sleep 10;
diag_log "***cues runs. deleting deads etc";
if (count (allPlayers - (entities "HeadlessClient_F")) < 1) then
{
	{deleteVehicle _x } foreach allDeadMen;
	sleep 1;
	{deletegroup _x} foreach allGroups;
}
else
{
	diag_log "***cues quits because server not empty";
};
__tky_ends