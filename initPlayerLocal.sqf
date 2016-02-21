["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[ missionNamespace, "arsenalClosed", {
    [ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
}] call BIS_fnc_addScriptedEventHandler;
//^^ when player closes VA, save their loadout to server
[ player, "respawn", {
	diag_log "***respawn EH fired¬!!!!";
}] call BIS_fnc_addScriptedEventHandler;
//^^ when player respawns, give them their last saved loadout

sleep 1;
startLoadingScreen ["Authority mission is setting up. Please wait."];
while {missionsetupprogress < 0.95} do
	{
		sleep 1;
		progressLoadingScreen missionsetupprogress;
	};
waitUntil {initserverfinished};
player setVariable ["last_inventory_saved", -1];
endLoadingScreen;
//player setpos (getMarkerPos "respawn_west");
player setpos ([(getmarkerpos "respawn_west"), (3+ (random 3)), random 360] call bis_fnc_relPos);
//larrows EH to better handle revive and respawn.
[ missionNamespace, "reviveRevived", {
	params[ "_unit", "_revivor" ];
	if ( isNull _revivor ) then {
		_nul = [] spawn {
			sleep playerRespawnTime;
			_nul = execVM "client\playerrespawned.sqf";
		};
	}else{
		//hint format[ "You were revived by %1", name _revivor ];
		_nul = execVM "client\playerrevived.sqf";
	};
}] call BIS_fnc_addScriptedEventHandler;
player addEventHandler ["Respawn", {
deleteVehicle (_this select 1);
}];
player addEventHandler ["handleDamage", {_this call tky_fnc_hd}];// think this one is NOT respawn persistent. might need to readd it after respawn.


// MHQ Curator Build Stuff

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