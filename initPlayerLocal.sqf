["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[ missionNamespace, "arsenalClosed",
	{
	diag_log "*** VA closed!";
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

player setpos ([(getmarkerpos "respawn_west"), (3+ (random 3)), random 360] call bis_fnc_relPos);
//larrows EH to better handle revive and respawn.
[ missionNamespace, "reviveRevived", {
	_nul = _this spawn
		{
		_unit = _this select 0;
		_revivor = _this select 1;
		diag_log format ["***reviveRevived _unit %1, revivor %2", _unit, _revivor];
		//if forced respawn or we bleed out
		if ( isNull _revivor ) then
			{
			//wait until player is actually respawned into alive state
			sleep playerRespawnTime;
			//Load last saved inventory
			diag_log "*** reviveRevived EH loads saved inv!";
			[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
			};
		};
} ] call BIS_fnc_addScriptedEventHandler;
player addEventHandler [ "Respawn",
	{
	if ( player getVariable [ "BIS_revive_incapacitated", false ] ) then
		{
		//Set correct loadout on incapacitated unit laying on floor in injured state
		//This is also the new unit if he is revived
		diag_log "*** loading reviveinventory";
		[ player, [ missionNamespace, "reviveInventory" ] ] call BIS_fnc_loadInventory;
		};
	//Did we respawn from the menu
	if ( missionNamespace getVariable [ "menuRespawn", false ] ) then
		{
		diag_log "*** loading menu respawn inventiry";
		[ player, [ missionNamespace, "currentInventory" ] ] call BIS_fnc_loadInventory;
		missionNamespace setVariable [ "menuRespawn", false ];
		};
	}];


player addEventHandler ["handleDamage", {_this call tky_fnc_hd}];// think this one is NOT respawn persistent. might need to readd it after respawn.