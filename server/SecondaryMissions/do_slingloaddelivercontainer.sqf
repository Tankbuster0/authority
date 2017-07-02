//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_template";
__tky_starts;
private [];
missionactive = true;missionsuccess = false;_smcleanup = [];

_conttype = selectRandom huroncontainertypes;
switch (_conttype) do
	{
	case "B_Slingload_01_Ammo_F": {_misstxt = "an urgent ammunition resupply"};
	case "B_Slingload_01_Cargo_F": {_misstxt = "food, rations, water and porn resupply stat"};
	case "B_Slingload_01_Fuel_F": {_misstxt = "diesel and oil for their vehicles to continue operations"};
	case "B_Slingload_01_Medevac_F": {_misstxt = "urgent medical supplies for their forward medical facilities"};
	case "B_Slingload_01_Repair_F": {_misstxt = "need to repair a number of their heavy vehicles in theatre"};
	}

_displayname = [_conttype] call tky_fnc_getscreenname;


_redtargets = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 5000} };
// get all the red held target logics that are more than 5 kilometer away
_mytarget = selectRandom _redtargets;
_tname = _x getVariable ["targetname", "Springfield"];
_deliverypos = [0,0,0];
_testradius = 100;
while {_deliverypos in [[0,0,0], islandcentre] } do
	{
	_deliverypos = [cpt_position, 50, _testradius, 23, 0, 0.3, 0] call BIS_fnc_findSafePos;
	_testradius = _testradius * 2;
	};
// work out the direction of the objective from the logic

// work out the distance of the obj from the logic





 format ["Friendly missiondescription text ",2,false];
 failtext = "Dudes. You suck texts";
_
while {missionactive} do
	{
	sleep 3;
	if (/*failure conditions*/) then
		{
		missionsuccess = false;
		missionactive = false;
		};

	if (/*succeed conditions*/) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
