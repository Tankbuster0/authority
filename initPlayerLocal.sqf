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
player addEventHandler ["respawn", {if !(player in BIS_revive_units) then  {[_this] execVM "client\playerrespawned.sqf"}}];
//^^ when player respawns, give them their last saved loadout