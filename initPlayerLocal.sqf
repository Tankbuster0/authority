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
[] execvm "client\addactions.sqf";
player addEventHandler ["Respawn", {execVM "client\playerrespawns.sqf"}];
player addEventHandler ["GetInMan", {gotinvec = _this select 2; publicvariableserver "gotinvec"}];
[] execVM "client\playersetup.sqf";
