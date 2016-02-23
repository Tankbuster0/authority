// Script that processes objects placed by the curatorAddons
// Important things this script does: Make sure only 1 helipad can be placed and put scripts on placed helipad.

// Get curator object and the placed object
params [
["_cur", ""],
["_obj", ""]];
hint "Placed";
if ((typeOf _obj) == "Land_HelipadSquare_F") then{

	// Remove Helipad out of list
	cur addEventHandler [
	"CuratorObjectRegistered",
	{
		_classes = _this select 1;
		_costs = [];
		{
			_cost = 		
			switch (_x) do {
				case "RHS_Stinger_AA_pod_WD": {[true,0.3]};
				case "RHS_M252_WD": {[true,0.5]};
				case "RHS_M2StaticMG_MiniTripod_WD": {[true,0.1]};
				case "RHS_M2StaticMG_WD": {[true,0.2]};
				case "Land_BagBunker_Small_F": {[true,0]};
				case "Land_BagFence_Corner_F": {[true,0]};
				case "Land_BagFence_End_F": {[true,0]};
				case "Land_BagFence_Long_F": {[true,0]};
				case "Land_BagFence_Round_F": {[true,0]};
				case "Land_BagFence_Short_F": {[true,0]};
				case "Land_HBarrier_1_F": {[true,0]};
				case "Land_HBarrier_3_F": {[true,0]};
				case "Land_HBarrier_5_F": {[true,0]};
				case "Land_HBarrierBig_F": {[true,0]};
				case "Land_HBarrier_Big_F": {[true,0]};
				case "Land_HBarrierTower_F": {[true,0]};
				case "Land_HBarrierWall_corner_F": {[true,0]};
				case "Land_HBarrierWall_corridor_F": {[true,0]};
				case "Land_HBarrierWall4_F": {[true,0]};
				case "Land_HBarrierWall6_F": {[true,0]};
				case "Land_Razorwire_F": {[true,0]};
				case "Land_HelipadSquare_F":{[false,0]}; 
				default {[false,0]};
			};
			_costs = _costs + [_cost];
		} forEach _classes;
		_costs
	}
];
	
	findDisplay 312 closeDisplay 2;
	
	"Deploying Helipad." remoteExec ["hint", _cur];
	FOBHelipad = _obj;
	
};
