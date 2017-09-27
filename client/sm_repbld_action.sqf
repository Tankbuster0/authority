//by tankbuster
 #include "..\includes.sqf"
_myscript = "sm_repbld_action";
__tky_starts;
private ["_bbox0","_bb1","_bb2","_mx1y1","_mx1y2","_mx2y2","_mx2y1","_nrvecs"];
while {true} do
	{
	waitUntil {sleep 10; typeselected isEqualTo "repairlocalbuilding"};
	sleep 5;
	if (testmode) then {diag_log "*** sm_r_a starts because replocbld mission runs"};
	_bbox0 = boundingBox surfacebld;
	_bb1 = _bbox0 select 0;
	_bb2 = _bbox0 select 1;

	_mx1y1 = [_bb1 select 0, _bb1 select 1, _bb1 select 2];// model bottom left
	_mx1y2 = [_bb1 select 0, _bb2 select 1, _bb1 select 2];// model top left
	_mx2y2 = [_bb2 select 0, _bb2 select 1, _bb1 select 2];// model top right
	_mx2y1 = [_bb2 select 0, _bb1 select 1, _bb1 select 2];// model bottom right

	wx1y1 = surfacebld modelToWorld _mx1y1;//world bottom left
	wx1y2 = surfacebld modelToWorld _mx1y2;//world top left
	wx2y2 = surfacebld modelToWorld _mx2y2;//world top right
	wx2y1 = surfacebld modelToWorld _mx2y1;//world bottom right
	diag_log format ["*** Polygon corners are at %1 %2 %3 %4", wx1y1, wx1y2, wx2y2, wx2y1];
		[
		surfacebld,
		"Repair/Rebuild building.",
		"pics\holdAction_rebuild_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\actions\settimer_ca.paa",
		"(position player) inPolygon [wx1y1, wx1y2, wx2y2, wx2y1]",
		"(position player) inPolygon [wx1y1, wx1y2, wx2y2, wx2y1]",
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