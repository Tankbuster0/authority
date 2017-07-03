//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_template";
__tky_starts;
private ["_smcleanup","_conttype","_misstxt","_displayname","_redtargets","_mytarget","_tname","_deliverypos","_testradius","_dir"];
missionactive = true;missionsuccess = false;_smcleanup = [];
_hurons = vehicles select {((typeof) _x isEqualTo "B_Heli_Transport_03_unarmed_F") and {alive _x} and {canMove _x}};

_conttype = selectRandom huroncontainertypes;
switch (_conttype) do
	{
	case "B_Slingload_01_Ammo_F": {_misstxt = "require an urgent ammunition resupply"};
	case "B_Slingload_01_Cargo_F": {_misstxt = "are in urgent need of food, rations, water and porn resupply stat"};
	case "B_Slingload_01_Fuel_F": {_misstxt = "have an immediate requirement of diesel and oil for their vehicles to continue operations"};
	case "B_Slingload_01_Medevac_F": {_misstxt = "need these critical medical supplies for their forward medical facilities"};
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
_dir = [cpt_position getdir _deliverypos] call TKY_fnc_cardinaldirection;
_dist = [cpt_position distance2d _deliverypos] call TKY_fnc_estimateddistance;
format ["Freindly forces %1. There's a %2 at the Airhead, slingload that to them %3m %4 %5", _misstxt, _displayname, _dist,_dir, _tname] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
[_deliverypos, west, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Motorized_MTP" >> "IRG_Technicals")] call BIS_fnc_spawngroup;
[_deliverypos, west, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad_Weapons")] call BIS_fnc_spawngroup;

if ((count _hurons) > 0) then //players already have a huron, don't give them another one
	{
	"Use your Huron helicopter to airlift the container." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
	}
	else
	{
		_nul = [_droppoint2, blufordropaircraft, "B_Heli_Transport_03_unarmed_F", [0,0,0], "Use this to do the slongload container mission.", "huron" ] execVM "server\spawnairdrop.sqf";
	};


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
