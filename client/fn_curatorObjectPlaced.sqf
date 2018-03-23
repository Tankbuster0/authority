// Script that processes objects placed by the curatorAddons
// Important things this script does: Make sure only 1 helipad can be placed and put scripts on placed helipad.
// Get curator object and the placed object
params [
["_cur", ""],
["_obj", ""]];
fobjects pushback _obj;
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
				case "B_static_AA_F": {[true,0.3]};
				case "B_HMG_01_high_F": {[true,0.5]};
				case "B_Mortar_01_F": {[true,0.2]};
				case "Land_BagBunker_Small_F": {[true,0]};
				case "Land_BagFence_Corner_F": {[true,0]};
				case "Land_BagFence_End_F": {[true,0]};
				case "Land_BagFence_Long_F": {[true,0]};
				case "Land_BagFence_Round_F": {[true,0]};
				case "Land_BagFence_Short_F": {[true,0]};
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
	_con = "(isServer) and {(!fobserviceinuse) and ((count thislist) isEqualTo 1) and (typeof (thislist select 0) in allbluvehicles ) and (isplayer driver (thislist select 0)) and (FOBhelipad in (thistrigger nearobjects ['Helipad_base_F', 2]))}";
	_act = "fobserviceinuse = true; publicVariable 'fobserviceinuse'; [['fobserviceinuse', thisList, getpos thistrigger], 'gvs\generic_vehicle_service.sqf'] remoteExec ['execVM', (driver (thislist select 0))]";
	_fgvst = createTrigger ["EmptyDetector", getpos FOBhelipad, true];
	_fgvst setdir 333;// fob gvs trigs are setdir 333 so they can be identified and manualy deleted later
	_fgvst setTriggerArea [8,8,0,true];
	_fgvst setTriggerActivation ["ANY", "PRESENT", true];
	_fgvst setTriggerStatements [_con, _act, ""];
	diag_log format ["***curobjplaced makes trigger %1 at %2, statements are %3", _fgvst, getpos _fgvst, triggerStatements _fgvst];
	fobjects pushback _fgvst;
publicVariable "fobjects";
};
