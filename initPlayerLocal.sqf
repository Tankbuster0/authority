_myscript = "initplayerlocal.sqf";
0 =

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[ missionNamespace, "arsenalClosed",
	{
	//diag_log "*** VA closed!";
    [ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
	}] call BIS_fnc_addScriptedEventHandler;
	//^^ when player closes VA, save their loadout to server
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

#include "\a3\functions_f_mp_mark\Revive\defines.hpp"

//systemChat "Saving initial loadout";
//Save initial loadout
[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;

player addEventHandler [ "Respawn", {
	[SupportReq, ArtySupport] call BIS_fnc_removeSupportLink;
	BIS_supp_refresh = TRUE;
	//systemChat "Respawning";
	//systemChat format[ "state %1", GET_STATE_STR(GET_STATE( player )) ];

	if ( GET_STATE( player ) == STATE_RESPAWNED ) then {
		//systemChat "Died or Respawned via menu";
		_templates = [];
		{
			{
				_nul = _templates pushBackUnique _x;
			}forEach ( getMissionConfigValue [ _x, [] ] );
		}forEach [ "respawntemplates", format[ "respawntemplates%1", str playerSide ] ];

		if ( { "menuInventory" == _x }count _templates > 0 ) then {
			//systemChat "Respawning - saving menu inventory";
			[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
		}else
		{
			h = [] spawn
			{
				sleep playerRespawnTime;
				//systemChat "Respawning - loading last saved";
				[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
				fobdeployactionid = player addaction ["Deploy/ Undeploy FOB", "remoteexec ['tky_fnc_fobvehicledeploymanager',2]", "", 0,false,false, "", "( (typeof (vehicle player) isEqualTo fobvehicleclassname )  and ((assignedVehicleRole player) isEqualTo ['cargo'] ) and (not (isEngineOn (vehicle player))) ) "];
				//fobdeployactionid2 = player addaction ["New deploy checks", "client\tky_super_isflatempty.sqf", "", 0,false,false, "", "( (typeof (vehicle player) isEqualTo fobvehicleclassname )  and ((assignedVehicleRole player) isEqualTo ['cargo'] )  ) "];
				vehiclespawnerid = player addaction ["Make Quadbike", "client\fn_spawnrunabout.sqf","",0,false,true, "","((player distanceSqr blubasedataterminal) < 2)"];
				vehiclespawnerid2 = player addaction ["Make Quadbike", "client\fn_spawnrunabout.sqf","",0,false,true, "","((player distanceSqr fobdataterminal) < 2)"];
				prizeboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "((player distanceSqr prizebox) < 8)"];
				bfboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "((player distanceSqr bfbox) < 8)"];
				//prizevecrecovid = player addAction ["Recover prize vehicles from Airhead (local version)", "client\recoverprize.sqf", "",0,true,true, "", "(islandhop) and {(player distance2D fobdataterminal) < 2}" ];
				// ^^^ removed because the cheaper version in buildfob now works yey
			};
		};

	}else{
		//systemChat "Incapacitated";
	};
}];
//player addEventHandler ["handleDamage", {_this call tky_fnc_hd}];// is respawn persistent. dont need to add it back after respawn or revive
player setvariable ["isusingprizerecovery", false, true];

[] execVM "client\playersetup.sqf";
