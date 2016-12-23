//by tankbuster
//execvmd by assaultphasefinished
_myscript = "cleanupemptyserver";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
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
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];