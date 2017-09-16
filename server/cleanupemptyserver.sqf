//by tankbuster
//execvmd by assaultphasefinished
 #include "..\includes.sqf"
_myscript = "cleanupemptyserver";
__tky_starts;
sleep 10;
//diag_log "***cues runs. deleting deads, weapons etc";
if (count (allPlayers - (entities "HeadlessClient_F")) < 1) then
{
	{deleteVehicle _x } foreach allDeadMen;
	sleep 1;
	{deletegroup _x} foreach allGroups;
	{if (!(alive _x)) then {deleteVehicle _x}} foreach entities [[fobvehicleclassname, forwardpointvehicleclassname, "groundWeaponHolderSimulated", "WeaponHolderSimulated", "GroundWeaponHolder"], [], false, false];
	{deletevehicle _x} foreach entities [["WeaponHolderSimulated"], [], false, false];
};
__tky_ends