#define filename "playerrespawned.sqf"
_thisscript = "playerrespawned.sqf";
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];

diag_log str _this;
deleteVehicle (_this select 1);// delete the old dead body
[player , [missionNamespace, "currentInventory"]] call bis_fnc_loadInventory;


diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];