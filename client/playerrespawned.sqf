#define filename "playerrespawned.sqf"
_thisscript = "playerrespawned.sqf";
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
[player , [missionNamespace, "currentInventory"]] call bis_fnc_loadInventory;
sleep 1;
{
	if (getnumber (configfile >> "CfgVehicles" >> typeOf _x >> "side") == 1) then {deleteVehicle _x;};
} foreach allDeadMen;
// delete all west deadmen. cant find a better way to delete corpse of a respawned player
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];