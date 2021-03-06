//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_slingloaddelivercontainer";
__tky_starts;
//"B_Heli_Transport_03_unarmed_F"
private ["_smcleanup","_hurons","_conttype","_misstxt","_displayname","_contpos","_redtargets","_mytarget","_tname","_deliverypos","_testradius","_dir","_dist","_smgrp1","_smgrp2","_nul","_smoke1","_smoke2","_smheli","_smoker1","_smoker2"];
missionactive = true;missionsuccess = false;_smcleanup = [];
_hurons = vehicles select {(((typeof _x) isEqualTo blufordropaircraft) and (alive _x) and (canMove _x) and (fuel _x > 0))};
_conttype = selectRandom huroncontainertypes;
switch (_conttype) do
	{
	case "B_Slingload_01_Ammo_F": {_misstxt = "require an urgent ammunition resupply"};
	case "B_Slingload_01_Cargo_F": {_misstxt = "are in urgent need of food, rations, water and porn resupply stat"};
	case "B_Slingload_01_Fuel_F": {_misstxt = "have an immediate requirement of diesel and oil for their vehicles to continue operations"};
	case "B_Slingload_01_Medevac_F": {_misstxt = "need these critical medical supplies for their forward medical facilities"};
	case "B_Slingload_01_Repair_F": {_misstxt = "need to repair a number of their heavy vehicles in theatre"};
	};
_displayname = [_conttype] call tky_fnc_getscreenname;
_contpos = [blubasehelipad, 20, 100, 10, 0, 0.5, 0,1,1] call tky_fnc_findSafePos;
smcontainer = createVehicle [_conttype, _contpos,[],0,"NONE"];
[smcontainer, "smcontainer"] call fnc_setvehiclename;
_smcleanup pushback smcontainer;
_redtargets = (cpt_position nearEntities ["Logic", 10000]) select {((_x getVariable ["targetstatus", -1]) isEqualTo 1) and {(_x distance2d cpt_position) > 3000} };
// get all the red held target logics that are more than 5 kilometer away
_mytarget = selectRandom _redtargets;
_tname = _mytarget getVariable ["targetname", "Springfield"];
_deliverypos = [0,0,0];
_testradius = 100;
while {_deliverypos in [[0,0,0], islandcentre] } do
	{
	_deliverypos = [_mytarget, 50, _testradius, 23, 0, 0.3, 0,1,0] call tky_fnc_findSafePos;
	_testradius = _testradius * 2;
	};
// work out the direction of the objective from the logic
_dir = [_mytarget getdir _deliverypos] call TKY_fnc_cardinaldirection;
_dist = [_mytarget distance2d _deliverypos] call tky_fnc_estimateddistance;
smmissionstring = format ["Friendly forces %1. There's a %2 at the Airhead, slingload that to them %3m %4 of %5. Keep aircraft speed below 140 KMH for best results. If you don't already have a slingload capable to do the mission, one will be airdropped to you at the Airhead.", _misstxt, _displayname, _dist,_dir, _tname];
smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
publicVariable "smmissionstring";
_smgrp1 = [_deliverypos, west, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Motorized_MTP" >> "IRG_Technicals")] call BIS_fnc_spawngroup;
_smgrp2 = [_deliverypos, west, (configfile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry" >> "IRG_InfSquad_Weapons")] call BIS_fnc_spawngroup;
	{
	_smcleanup pushback _x;
	if ((vehicle _x) != _x)then {_smcleanup pushBack (vehicle _x);}
	} foreach ((units _smgrp1) + (units _smgrp2));
{if ((vehicle _x) isKindOf "LandVehicle") then {(vehicle _x) setfuel 0}} foreach (units _smgrp1);
if ((count _hurons) > 0) then //players already have a huron, don't give them another one
	{
	"Use your helicopter to slingload the container." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
	}
	else
	{
	_nul = [blubasehelipad, blufordropaircraft, bluforslingloadlifter, [0,0,0], "Use this to do the slingload container mission.", "huron" ] execVM "server\spawnairdrop.sqf";
	};
failtext = "Mission failure! You didn't get the supplies to the troops. They needed them badly.";
_smoke1= false;
_smoke2 = false;
waitUntil {sleep 4; count ( vehicles select {(((typeof _x) isEqualTo bluforslingloadlifter) and (alive _x) and (canMove _x) and (fuel _x > 0))}) > 0 };// there's a huron actually in game...
waitUntil {sleep 4; (
	(
	 	(((getpos smcontainer) select 2) > 10) and
		((speed (ropeAttachedTo smcontainer)) > 20)
	)
	or (damage smcontainer > 0.5) or
	(count (vehicles select
	 	{
	 		(((typeof _x) isEqualTo bluforslingloadlifter)
			 and (alive _x) and (canMove _x) and (fuel _x > 0))
		}) < 1 )
	)};// mission underway..
_smheli = ropeAttachedTo smcontainer;
smcontainer setOwner (owner _smheli);
sleep 20;
while {missionactive} do
	{
	sleep 3;
	if ((!(_smoke1)) and {(_smheli distance2d _deliverypos < 1000)}) then
		{
		_smoker1 = createvehicle ["SmokeShellBlue", _deliverypos, [],0,"NONE"];
		_smoke1 = true;
		_smcleanup pushback _smoker1;
		};
		if ((!_smoke2) and {((_smheli distance2d _deliverypos) < 100)}) then
		{
		_smoker2 = createvehicle ["SmokeShellBlue", _deliverypos, [],0,"NONE"];
		_smoke2 = true;
		_smcleanup pushback _smoker2;
		};
	if (
	    (!alive smcontainer) or
	    ( ((getpos smcontainer select 2) < 2 ) and {((smcontainer distance2d _deliverypos) > 50) and (isNull (ropeAttachedTo smcontainer)) } ) or
	    (count ( vehicles select {(((typeof _x) isEqualTo bluforslingloadlifter) and (alive _x) and (canMove _x) and (fuel _x > 0))}) < 1)
	    )
	     then
			{
			missionsuccess = false; publicVariable "missionsuccess";
			missionactive = false; publicVariable "missionactive";
			publicVariable "failtext";
			};
	if (
	    (isNull (ropeAttachedTo smcontainer)) and
			{
				((smcontainer distance2d _deliverypos) < 50) and
				((getpos smcontainer select 2)< 2)
			}
		) then
			{
			missionsuccess = true; publicVariable "missionsuccess";
			missionactive = false; publicVariable "missionactive";
			"Mission successful! They got the much needed supplies." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
	};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";
__tky_ends