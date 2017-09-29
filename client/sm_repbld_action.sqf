//by tankbuster
 #include "..\includes.sqf"
_myscript = "sm_repbld_action";
private ["_cwx1y1","_cwx1y2","_cwx2y2","_cwx2y1"];
while {true} do
	{
	waitUntil {sleep 10; startrlbaction};
	sleep 1;
	cwx1y1 = missionNamespace getVariable "wx1y1";
	cwx1y2 = missionNamespace getVariable "wx1y2";
	cwx2y2 = missionNamespace getVariable "wx2y2";
	cwx2y1 = missionNamespace getVariable "wx2y1";
	diag_log format ["*** Polygon corners are at %1 %2 %3 %4", cwx1y1, cwx1y2, cwx2y2, cwx2y1];
		[
		surfacebld,
		"Repair/Rebuild building.",
		"pics\holdAction_rebuild_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\actions\settimer_ca.paa",
		"(position player) inPolygon [cwx1y1, cwx1y2, cwx2y2, cwx2y1]",
		"(position player) inPolygon [cwx1y1, cwx1y2, cwx2y2, cwx2y1]",
		{hint "Repairing building! Hold SPACEBAR down. Don't stand too close."},
		{},
		{hint "Repair complete!"; deepbld setdamage 0;},
		{hint "You didn't finish the building repair!"},
		[],
		(if (count (player nearentities [["B_APC_Tracked_01_CRV_F", "B_Truck_01_Repair_F", "Offroad_01_military_base_F", "Offroad_01_repair_base_F",  "O_Truck_03_repair_F"],5]) > 0) then {10} else {20}),
		nil,
		true,
		false
		] call BIS_fnc_holdActionAdd;
	waitUntil {sleep 5; !missionactive};
	};


__tky_ends