#define filename "initPlayerLocal.sqf"
scriptname "initPlayerLocal.sqf";
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
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
