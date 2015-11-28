#define filename "initPlayerLocal.sqf"
scriptname "initPlayerLocal.sqf";
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
endLoadingScreen;
hint "Moving you to respawn!";
player setpos (getMarkerPos "respawn_west");
//larrows EH to better handle revive and respawn.
[ missionNamespace, "reviveRevived", {
	params[ "_unit", "_revivor" ];
	if ( isNull _revivor ) then {
		_nul = [] spawn {
			sleep playerRespawnTime;
			hint "You respawned";
			_nul = execVM "client\playerrespawned.sqf";
		};
	}else{
		hint format[ "You were revived by %1", name _revivor ];
	};
}] call BIS_fnc_addScriptedEventHandler;
player addEventHandler ["Respawn", {
deleteVehicle (_this select 1);
}];