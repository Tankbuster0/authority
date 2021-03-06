 #include "..\includes.sqf"
_myscript = "playersetup.sqf";
[islandcentre,2] params ["_spawnpos", "_testradius"];// <-- funcky new private :)
__tky_starts;
waitUntil {!isNull player};

[] execVM "client\tky_supportmanager.sqf";
[] execVM "client\makediary.sqf";
while {_spawnpos isEqualTo islandcentre } do
	{
	_spawnpos = [ammobox, 2, _testradius, 4, 0, 0.5, 0,1,1] call tky_fnc_findSafePos;;
	_testradius = _testradius * 2;
	};
player setpos _spawnpos;

sleep 5;
[ player, [ profileNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
_hasLaser = {_x in (weapons player)} count ["Laserdesignator", "Laserdesignator_01_khk_F", "Laserdesignator_02", "Laserdesignator_02_ghex_F", "Laserdesignator_03", "Laserdesignator_mounted", "Laserdesignator_pilotCamera"];
if ((_hasLaser > 0)) then
{
	if (!("LaserBatteries" in (magazines player))) then
	{
		player addMagazine "LaserBatteries";
	};
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
waitUntil {(!isNull (findDisplay 46))};
sleep 2;
if ((score player < 1)) then
{
	private _key = if ((count (actionKeys "User1") isEqualTo 0)) then {"Left Windows"} else {((actionKeysNamesArray "User1") joinString " | ")};
	//[(format ["<t size='1.0' color='#FFFF00'>Welcome to Authority, %1! Briefing and notes are on the map screen in the top left corner. <br />Press %2 to open the mission status dialog.</t>", (name player), _key]), -1, -1, 20, 1, 0, 12345] remoteExec ["BIS_fnc_dynamicText", player, false];
	["pics\ctrglogo256.jpg", [0.1,0.1,0.75,0.75], 10,1, 2] spawn BIS_fnc_textTiles;
	sleep 4;
	[parseText (format ["<t size='2.2' color='#FFFF00'>Welcome to Authority, %1! Briefing and notes are on the map screen in the top left corner. <br />Press %2 to open the mission status dialog.</t>", (name player), _key]), [0.1,0.1,0.75,0.75], 10,8, 3] spawn BIS_fnc_textTiles;

};
if (([missionNamespace, "primarytargetcounter", 99] call BIS_fnc_getServerVariable) == 1) then
	{
		0=[[["On the shore, not far from ","align = 'center' size = '0.7' font='PuristaBold'"],[myairfield,"align = 'center' size = '0.7'","#aaaaaa"],["","<br/>"],["Take the airfield","align = 'center' size = '2.0'"]]] spawn BIS_fnc_typeText2;
	}
	else
	{
		0=[[["The friendly Airhead at ","align = 'center' size = '0.7' font='PuristaBold'"],[myairfield,"align = 'center' size = '0.7'","#aaaaaa"]]] spawn BIS_fnc_typeText2;
	}
	;
	// ^^^ need to add a primary target counter check. ot all players have zero score at the beach

__tky_ends