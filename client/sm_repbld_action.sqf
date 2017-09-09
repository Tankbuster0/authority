//by tankbuster
 #include "..\includes.sqf"
_myscript = "sm_repbld_action";
__tky_starts;
while {true} do
	{
	waitUntil {sleep 5; typeselected isEqualTo "repairlocalbuilding"};
	sleep 5;
	if (testmode) then {diag_log "*** sm_r_a starts because replocbld mission runs"};
	_bbox0 = boundingBox bldtorepair;
	_bb1 = _bbox0 select 0;
	_bb2 = _bbox0 select 1;

	_mx1y1 = [_bb1 select 0, _bb1 select 1, _bb1 select 2];// model bottom left
	_mx1y2 = [_bb1 select 0, _bb2 select 1, _bb1 select 2];// model top left
	_mx2y2 = [_bb2 select 0, _bb2 select 1, _bb1 select 2];// model top right
	_mx2y1 = [_bb2 select 0, _bb1 select 1, _bb1 select 2];// model bottom right

	_wx1y1 = bldtorepair modelToWorld _mx1y1;//world bottom left
	_wx1y2 = bldtorepair modelToWorld _mx1y2;//world top left
	_wx2y2 = bldtorepair modelToWorld _mx2y2;//world top right
	_wx2y1 = bldtorepair modelToWorld _mx2y1;//world bottom right

	_nrvecs = player nearEntities [["Truck_F", "Tank_F", "Offroad_01_repair_base_f"], 10];
		[
		bldtorepair,
		"Repair/Rebuild building.",
		"\a3\ui_f\data\IGUI\Cfg\actions\repair_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\actions\settimer_ca.paa",
		"(position player) inPolygon [_wx1y1, _wx1y2, _wx2y2 ,_wx2y1]",
		"(position player) inPolygon [_wx1y1, _wx1y2, _wx2y2 ,_wx2y1]",
		{hint "Repairing building!"},
		{},
		{hint "code to visually do the fix goes here"},
		{},
		[],
		(if ((player distance2d mybobcat) < 15) then {10} else {20}),
		_nil,
		true,
		false
		] call BIS_fnc_holdActionAdd;
	};


__tky_ends