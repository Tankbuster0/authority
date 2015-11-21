#define filename "initPlayerLocal.sqf"
scriptname "initPlayerLocal.sqf";
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
sleep 2;
startLoadingScreen ["Authority mission is setting up. Please wait."];
//"missionsetupprogress" addPublicVariableEventHandler {progressLoadingScreen missionsetupprogress };
while {missionsetupprogress < 0.95} do
	{
		sleep 1;
		progressLoadingScreen missionsetupprogress;
	};
waitUntil {initserverfinished};
endLoadingScreen;
hint "Moving you to respawn!";
player setpos (getMarkerPos "respawn_west");
//{_x setpos (getmarkerpos "respawn_west")} foreach playableunits;