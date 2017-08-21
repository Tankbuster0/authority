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
_hasLaser = {_x in (weapons player)} count ["Laserdesignator", "Laserdesignator_01_khk_F", "Laserdesignator_02", "Laserdesignator_02_ghex_F", "Laserdesignator_03", "Laserdesignator_mounted", "Laserdesignator_pilotCamera"];
if ((_hasLaser > 0)) then
{
	if ((!("LaserBatteries" in (magazines player)))) then
	{
		player addMagazine "LaserBatteries";
	};
};
if ((score player < 1)) then // Honestly... I'm not sure why you wanted to use "score" as this will show for regular players each new game. I suggest an alternative method.
{
	// TODO: Style the message using the new syntax... Doesn't seem to work (not even the example on the Wiki). It says Since Arma 3 v1.73.142260 and I'm testing on 1.74.142559 so no idea why it's not working!
	titleText [(format ["Welcome to Operation Authority, %1! If you are new to the mission then we recommend that you read the briefing and notes on the map screen in the top left corner. Press %2 to open the mission status dialog.", (name player), ((actionKeysNamesArray "User1") joinString " | ")]), "PLAIN", 4];
};
[] spawn
{
	waitUntil {(!isNull (findDisplay 46))};
	keyDownHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call tky_fnc_keyDownHandler;"];
};
player addEventHandler ["InventoryOpened",
{
	[] spawn
	{
		waitUntil {(!isNull (findDisplay 602))};
		[] call tky_fnc_inventory;
	};
}];
__tky_ends