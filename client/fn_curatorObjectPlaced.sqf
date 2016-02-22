// Script that processes objects placed by the curatorAddons
// Important things this script does: Make sure only 1 helipad can be placed and put scripts on placed helipad.

// Get curator object and the placed object
params [
["_cur", ""],
["_obj", ""]];

if ((typeOf _obj) == "Land_HelipadSquare_F") then{

	// Remove Helipad out of list
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
	"RHS_M2StaticMG_MiniTripod_WD",0]
	] call BIS_fnc_curatorObjectRegisteredTable;
	
	findDisplay 312 closeDisplay 2;
	
	"Deploying Helipad." remoteExec ["hint", _cur];
	FOBHelipad = _obj;
	
};
