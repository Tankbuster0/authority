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

//player setpos ([(getmarkerpos "respawn_west"), (3+ (random 3)), random 360] call bis_fnc_relPos);

#include "\a3\functions_f_mp_mark\Revive\defines.hpp"

//systemChat "Saving initial loadout";
//Save initial loadout
[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;


//Save loadout when ever we exit an arsenal
[ missionNamespace, "arsenalClosed", {
	//systemChat "Arsenal closed";
	[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_saveInventory;
}] call BIS_fnc_addScriptedEventHandler;


player addEventHandler [ "Respawn", {

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
		}else{
			h = [] spawn {
				sleep playerRespawnTime;
				//systemChat "Respawning - loading last saved";
				[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
			};
		};

	}else{
		//systemChat "Incapacitated";
	};
}];
player addEventHandler ["handleDamage", {_this call tky_fnc_hd}];// is respawn persistent. dont need to add it back after respawn or revive

[] execVM "client\playersetup.sqf";
