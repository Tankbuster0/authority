_myscript = "init.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
if (worldName == "Altis") then
	{
	_location = createlocation ["NameLocal",  [20983,7242,25.656], 100,100];
	_location setText "Feres airfield";
	_location = createLocation ["NameLocal", [23145,18443.621,3.1900], 100, 100];
	_location setText "Almyra airfield";
	_location = createLocation ["NameLocal", [9155.25,21538.2,16.0988], 100,100];
	_location setText "Abdera airfield";
	};
if (("rhs_main" in activatedAddons) and ("rhsusf_main" in activatedAddons)) then {RHS = true} else {RHS = false};

tky_super_hint = compilefinal "_parray = [_this, 0] call BIS_fnc_param;
	_text = [_this ,1] call BIS_fnc_param;
	{if (_x == player) then {hint _text; [playerSide, 'HQ'] sideChat _text;};}foreach _parray;"; call BIS_fnc_MP;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

// MHQ Curator Build Stuff

// Build Helipad, Can be NULL!
FOBHelipad = objNull;

//Hack around eventhandler crud
LastSelectedObjects = objNull; 

// Set explicit objects
[ cur, 
["B_HMG_01_F",0,
"B_HMG_01_high_F",0,
"B_GMG_01_F",0,
"B_GMG_01_high_F",0,
"B_Mortar_01_F",0,
"Land_BagBunker_Small_F",0,
"Land_BagFence_Corner_F",0,
"Land_BagFence_End_F",0,
"Land_BagFence_Long_F",0,
"Land_BagFence_Round_F",0,
"Land_BagFence_Short_F",0,
"Land_HBarrier_1_F",0,
"Land_HBarrier_3_F",0,
"Land_HBarrier_5_F",0,
"Land_HBarrierBig_F",0,
"Land_HBarrier_Big_F",0,
"Land_HBarrierTower_F",0,
"Land_HBarrierWall_corner_F",0,
"Land_HBarrierWall_corridor_F",0,
"Land_HBarrierWall4_F",0,
"Land_HBarrierWall6_F",0,
"Land_Razorwire_F",0,
"Land_HelipadSquare_F",0,
"RHS_M2StaticMG_MiniTripod_WD",0]
] call BIS_fnc_curatorObjectRegisteredTable;