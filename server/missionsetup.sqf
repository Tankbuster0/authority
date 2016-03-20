//by tankbuster
_myscript = "missionssetup";
private ["_foundairfields","_mapsize","_mapcentre","_locs","_airfield","_newdrypos","_1pos","_y","_postest", "_airfield"];
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

_airfield = foundairfields call bis_fnc_selectRandom;//choose a random airfield

_newdrypos =[0,0,0];
roadreinforcementvehicles = [];
fobdeployed = false;
publicVariable "fobdeployed";
_1pos = getpos _airfield;
while {_newdrypos in [[0,0,0], islandcentre]} do
	{
	_newdrypos = [_1pos,800,1300, 2.5, 0, 5, 1] call bis_fnc_findSafePos;
	};
_newdrypos set [2,0];
//"respawn_west" setmarkerpos _newdrypos;
//deleteMarker "respawn_west";
ammobox setpos _newdrypos;
ammoboxrespawnid = [west, ammobox, "Main Ammobox"] call BIS_fnc_addrespawnposition;
sleep 1;
for "_q" from 1 to 3 do
	{
	sleep 0.5;
	_mypos = [_newdrypos, 3,30,3,0,20,0] call bis_fnc_findSafePos;
	_mytruck = createVehicle ["rhsusf_m998_w_2dr", _mypos,[],0,"NONE"];
	sleep 0.5;
	_mypos = [_newdrypos, 3,30,3,0,20,0] call bis_fnc_findSafePos;
	_mymortar = createVehicle ["RHS_M252_D", _mypos,[],0, "NONE"];
	};
_mypos = [_newdrypos, 3,30,3,0,20,0] call bis_fnc_findSafePos;
forward setVehiclePosition [_mypos, [],0, "NONE"];
forwardrespawnpositionid = [west,"forwardmarker", "Forward Vehicle"] call BIS_fnc_addrespawnposition;
missionrunning = true; publicVariable "missionrunning";
nextpt = _airfield;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
nextpt