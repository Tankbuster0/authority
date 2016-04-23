//by tankbuster
_myscript = "missionssetup";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_airfield","_newdrypos","_1pos","_q","_mypos","_mytruck","_mymortar","_frigateposdata","_l","_mydata1","_fpos"];
_airfield = foundairfields call bis_fnc_selectRandom;//choose a random airfield
enableVehicleCrashes = false;
_newdrypos =[0,0,0];
roadreinforcementvehicles = [];
fobdeployed = false;
publicVariable "fobdeployed";
_1pos = getpos _airfield;
while {_newdrypos in [[0,0,0], islandcentre]} do
	{
	_newdrypos = [_1pos,800,1300, 2.5, 0, 4, 1] call bis_fnc_findSafePos;
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
	_mytruck = createVehicle ["CUP_B_LR_Transport_GB_W", _mypos,[],0,"NONE"];
	sleep 0.5;
	_mypos = [_newdrypos, 3,30,3,0,20,0] call bis_fnc_findSafePos;
	_mymortar = createVehicle ["CUP_B_M252_USMC", _mypos,[],0, "NONE"];
	};
_mypos = [_newdrypos, 3,30,3,0,20,0] call bis_fnc_findSafePos;
forward setVehiclePosition [_mypos, [],0, "NONE"];
forwardrespawnpositionid = [west,"forwardmarker", "Forward Vehicle"] call BIS_fnc_addrespawnposition;
//find a pos for the frigate
_fpos locationPosition (nearestLocation [_mypos, "NameMarine"]);
// if the below routine doesnt find anywhere nice for the frigate, the above line will put it in the nearest bay location
_frigateposdata = selectBestPlaces [_mypos, 500, "waterDepth", 1,100];
// ^^ returns an array [ [2d position array], expression result (in this case, sea depth)];
// need to do this in a while loop to make sure it doesn't bomb out and not find a place
for "_l" from 0 to (count _frigateposdata) do
	{
	_mydata1 = _frigateposdata select _l;
	if ((_mydata1 select 1) > 30) exitWith {_fpos = _mydata1 select 0};

	};

frigate = createVehicle ["CUP_B_Frigate_ANZAC", _fpos, [], 0, "NONE"];
frigate setdir (random 360);
// authfrigate = createvehicle ["cup frigate", _fpos]


missionrunning = true; publicVariable "missionrunning";
nextpt = _airfield;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
nextpt