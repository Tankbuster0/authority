// Script that processes objects placed by the curatorAddons
// Important things this script does: Make sure only 1 helipad can be placed and put scripts on placed helipad.

// Get curator object and the placed object
params [
["_cur", ""],
["_obj", ""]];

if (!(isNull _obj)) then {
LastSelectedObjects = typeOf _obj;
//hint format["changed: %1", LastSelectedObjects];
}