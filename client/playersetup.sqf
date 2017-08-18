 #include "..\includes.sqf"
_myscript = "playersetup.sqf";
[islandcentre,2] params ["_spawnpos", "_testradius"];// <-- funcky new private :)
__tky_starts;
waitUntil {!isNull player};
//sleep 0.5;
[] execVM "client\tky_supportmanager.sqf";
[]execVM "client\makediary.sqf";
while {_spawnpos isEqualTo islandcentre } do
	{
	_spawnpos = [ammobox, 2, _testradius, 4, 0, 0.5, 0,1,1] call tky_fnc_findSafePos;;
	_testradius = _testradius * 2;
	};
player setpos _spawnpos;
[ player, [ profileNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
player addEventHandler ["InventoryOpened",
{
	[] spawn
	{
		waitUntil {(!isNull (findDisplay 602))};
		[] call tky_fnc_inventory;
	};
}];
__tky_ends