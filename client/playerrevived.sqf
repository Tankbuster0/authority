_myscript = "playerrevivied.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
[player , [profileNamespace, "reviveloadout"]] call bis_fnc_loadInventory;

hint "pre-reviveloadout applied!";


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
