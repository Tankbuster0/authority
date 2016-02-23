// Script that processes objects placed by the curatorAddons
// Important things this script does: Make sure only 1 helipad can be placed and put scripts on placed helipad.

// Get curator object and the placed object
params [
["_cur", ""],
["_obj", ""]];

//Cause bohemia fucked up, hack around null object
//hint format["removing %1", LastSelectedObjects];

{ if (LastSelectedObjects == "Land_HelipadSquare_F") exitWith {
_o = execvm "client\fn_resetCuratorBuildlist.sqf";

findDisplay 312 closeDisplay 2;

"Destroying Helipad.." remoteExec ["hint", _cur];
};
} forEach units group player;

