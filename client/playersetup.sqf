 #include "..\includes.sqf"
_myscript = "playersetup.sqf";
[islandcentre,2] params ["_spawnpos", "_testradius"];// <-- funcky new private :)
__tky_starts;
waitUntil {!isNull player};
//sleep 0.5;
[] execVM "client\tky_supportmanager.sqf";
[] execVM "client\makediary.sqf";
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
if ((score player < 1)) then
{
	private _key = if ((count (actionKeys "User1") isEqualTo 0)) then {"Left Windows"} else {((actionKeysNamesArray "User1") joinString " | ")};
	[(format ["<t size='1.0' color='#FFFF00'>Welcome to Authority, %1! Briefing and notes are on the map screen in the top left corner. <br />Press %2 to open the mission status dialog.</t>", (name player), _key]), -1, -1, 10, 1, 0, 12345] remoteExec ["BIS_fnc_dynamicText", player, false];
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
player addEventHandler ["killed", tky_fnc_killedEH];
if (player getUnitTrait "engineer") then
	{
	[] execVM "client\sm_repbld_action.sqf";
	};
player execVM "client\simpleEP.sqf";

if ("PARAM_Fatigue" call BIS_fnc_getParamValue == 0) then
	{
		player enableStamina false;
	};
if !("PARAM_AimSway" call BIS_fnc_getParamValue == 100) then
	{
		private _coef = ("PARAM_AimSway" call BIS_fnc_getParamValue) / 10;
		player setCustomAimCoef _coef;
		player setUnitRecoilCoefficient 0.2 + _coef;
	};

__tky_ends