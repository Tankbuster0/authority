_myscript = "initplayerlocal.sqf";

0 =

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[ missionNamespace, "arsenalClosed",
	{
	//diag_log "*** VA closed!";
    [ player, [ profileNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
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

player setvariable ["isusingprizerecovery", false, true];
// need to add these here as they used to be added by respawn eh at mission start. note that addaction is NOT respawn persistent.
				fobdeployactionid = player addaction ["Deploy/ Undeploy FOB", "remoteexec ['tky_fnc_fobvehicledeploymanager',2]", "", 0,false,true, "", "( (typeof (vehicle player) isEqualTo fobvehicleclassname )  and ((assignedVehicleRole player) isEqualTo ['cargo'] ) and (not (isEngineOn (vehicle player))) ) "];
				vehiclespawnerid1 = player addaction ["Make Quadbike", "client\fn_spawnrunabout.sqf","",0,false,true, "","(player distance2D blubasedataterminal) < 2"];
				vehiclespawnerid2 = player addaction ["Make Quadbike", "client\fn_spawnrunabout.sqf","",0,false,true, "","(player distance2D fobdataterminal) < 2"];
				bfboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "(player distance2d bfbox) < 3"];
				prizeboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "(player distance2D prizebox) < 3"];


/************************************************************************
*It's intended that ALL respawn eventhandlers be replaced with this one*
************************************************************************/
player addEventHandler ["Respawn", {execVM "client\playerrespawns.sqf"}];


[] execVM "client\playersetup.sqf";
