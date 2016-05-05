_myscript = "playerrespawned.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
[player , [missionNamespace, "currentInventory"]] call bis_fnc_loadInventory;
sleep 1;
hint "respawn loadout applied";
if (isNil{fobveh}) then
	{
	fobveh = [missionNamespace, "fobveh", nil] call BIS_fnc_getServerVariable;
	};
sleep 0.5;
fobdeployactionid = player addaction ["Deploy FOB", "remoteexec ['tky_fnc_fobvehicledeploymanager',2]", "", 0,false,false, "", "(typeof (vehicle player) == "CUP_B_Mastiff_HMG_GB_W" ) and (round (speed vehicle player) isEqualTo 0)"];
// ^^ if respawning player report multiple addactions, remove this line

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

