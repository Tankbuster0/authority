//by tankbuster
 #include "..\includes.sqf"
_myscript = "missionsetup";
__tky_starts;
private ["_airfield","_beachheadpos","_airfieldpos","_q","_mypos","_mytruck","_mymortar","_frigateposdata","_l","_mydata1","_fpos","_pos", "_refuse"];
_airfield = foundairfields call bis_fnc_selectRandom;//choose a random airfield
enableVehicleCrashes = false;
_beachheadpos =[0,0,0];
roadreinforcementvehicles = [];
fobdeployed = false;
publicVariable "fobdeployed";
_airfieldpos = getpos _airfield;
_refuse = true;
while {((_beachheadpos in [[0,0,0], islandcentre]) or (_refuse))} do
	{
	_beachheadpos = [_airfieldpos,800,1500, 2.5, 0, 0.5, 1] call bis_fnc_findSafePos;
	_dir = _beachheadpos getDir _airfieldpos;
	_dist = _beachheadpos distance2D _airfieldpos;
	if ((surfaceIsWater (_beachheadpos getPos [(_dist * .25), _dir])) or (surfaceiswater (_beachheadpos getPos [(_dist * .50), _dir])) or (surfaceiswater (_beachheadpos getPos [(_dist * .75), _dir]))) then
		{
		refuse = true;
		//diag_log format ["***ms finds beachhead has water between it and airbase"];
		}
		else
		{_refuse = false;};
	};
_beachheadpos set [2,0];
ammoboxpad = createVehicle ["Land_HelipadEmpty_F", _beachheadpos, [],0, "NONE"];
ammobox setpos _beachheadpos;
ammobox attachTo [ammoboxpad];
ammoboxrespawnid = [west, ammobox, "Main Ammobox"] call BIS_fnc_addrespawnposition;
headmarker1 = createMarker ["headmarker1", _beachheadpos];
headmarker1 setMarkerShape "rectangle";
headmarker1 setMarkerSize [30,30];
headmarker1 setMarkerColor "colorwest";
headmarker1 setMarkerDir 45;
headmarker2 = createMarker ["headmarker2", _beachheadpos];
headmarker2 setMarkerShape "ICON";
headmarker2 setMarkerType "hd_dot";
headmarker2 setMarkerText "BEACHHEAD";
beachflag = "Flag_Blue_F" createVehicleLocal (_beachheadpos);
blueflags pushback beachflag;
sleep 1;
for "_q" from 1 to 3 do
	{
	sleep 0.5;
	_mypos = [0,0,0]; _testradius = 6;
	while {((_mypos in [[0,0,0], islandcentre]) or (surfaceIsWater _mypos) or (((nearestObject [_mypos, "LandVehicle"]) distancesqr _mypos) < 2.2))} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_mypos = [_beachheadpos, 4,_testradius, 6, 0,0.5,0] call bis_fnc_findSafePos;
		_testradius = _testradius * 2;
	};

	_mytruck = createVehicle ["B_Quadbike_01_F", _mypos,[],0,"NONE"];
	};

// Forward Set up

	_mypos = [0,0,0]; _testradius = 6;
	while {((_mypos in [[0,0,0], islandcentre]) or (surfaceIsWater _mypos) or (((nearestObject [_mypos, "LandVehicle"]) distanceSqr _mypos) < 2.2))} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_mypos = [_beachheadpos, 4,_testradius, 6, 0,0.5,0] call bis_fnc_findSafePos;
		_testradius = _testradius * 2;
	};


forward setVehiclePosition [_mypos, [],0];
forward setObjectTextureGlobal [0,"a3\soft_f_exp\lsv_01\data\nato_lsv_01_dazzle_co.paa"];
[forward,nil,["HideDoor1",0,"HideDoor2",1,"HideDoor3",0,"HideDoor4",1]] call bis_fnc_initVehicle;

/*
forward addEventHandler ["GetOut", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetout.sqf"}];
forward addEventHandler ["GetIn", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetin.sqf"}];
forward addEventHandler ["SeatSwitched", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetseatchanged.sqf"}];
forward addEventHandler ["Engine", {_nul = [_this select 0, _this select 1] execVM "server\functions\fn_handlefobengine.sqf"}];
*/
// ^^^ removed to test client side arty permission system in tky_supportmanager
forwardrespawnpositionid = [west,"forwardmarker", "Forward Vehicle"] call BIS_fnc_addrespawnposition;

{
	_tmp = Forward call compile format [ "get%1Cargo _this", _x ];
	_unique = [];
	{
		if !( _x in _unique ) then {
			_unique pushBack _x;
		};
	}forEach _tmp;
	CQBCleanupArr pushBack _unique;
}forEach [ "backpack", "item", "magazine", "weapon" ];
/*
//find a pos for the frigate
_fpos = locationPosition (nearestLocation [_mypos, "NameMarine"]);
// if the below routine doesnt find anywhere nice for the frigate, the above line will put it in the nearest bay location
_frigateposdata = selectBestPlaces [_mypos, 2000, "sea * waterDepth", 10,500];
// ^^ returns an array [ [2d position array], expression result (in this case, sea depth)];
if (isNil {_frigateposdata}) then
	{
	_fpos = _frigateposdata;
	}// if selectbestplaces doesnt find anywhere, use the nearest marine
	else
	{
	for "_l" from 0 to (count _frigateposdata) do
		{
		_mydata1 = (_frigateposdata select _l);
		_raisedmypos = _mypos;
		_raisedmypos set [2,10];
		if (((_mydata1 select 1) > 30) and (not( terrainIntersect [(_mydata1 select 0), (_raisedmypos)] ) ) ) exitWith {_fpos = _mydata1 select 0};

		};
	};

//Make stuff
// Frig


frigate = createVehicle ["C_Boat_Civil_04_F", _fpos, [], 0, "NONE"];
frigate setdir (random 360);
frigate setCaptive true;
// Arty Vehicle
_pos = position frigate;
_az =  getDir frigate;
_gopos = [position frigate, -17.5, +_az] call BIS_fnc_relPos;
_gopos = [_gopos select 0, _gopos select 1, (_gopos select 2) + 16.4];
frigate setVehicleLock "LOCKED";
*/
// Take out advanced ammo types;
Arty removeMagazinesTurret ["2Rnd_155mm_Mo_Cluster",[0]];
Arty removeMagazinesTurret ["6Rnd_155mm_Mo_AT_mine",[0]];
Arty removeMagazinesTurret ["6Rnd_155mm_Mo_mine",[0]];

// Support Arty Frig
//ArtySupport synchronizeObjectsAdd [Arty];
//Arty synchronizeObjectsAdd [ArtySupport];

//Setup requestor limit values
/*
{
	[SupportReq, _x, 0] call BIS_fnc_limitSupport;
}forEach [
	"Artillery",
	"CAS_Heli",
	"CAS_Bombing",
	"UAV",
	"Drop",
	"Transport"
];


//Setup provider values
{
	ArtySupport setVariable [(_x select 0),(_x select 1)];
}forEach [
	["BIS_SUPP_vehicles",[]],        //types of vehicles to use
	["BIS_SUPP_vehicleinit",""],    //init code for vehicle
	["BIS_SUPP_filter","SIDE"]        //whether default vehicles comes from "SIDE" or "FACTION"
];

//Set our limit on the requester for artillery to 1
[SupportReq, "Artillery", -1] call BIS_fnc_limitSupport;


BIS_supp_refresh = TRUE;

publicVariable "BIS_supp_refresh";
*/
_id1 = addMissionEventHandler ["HandleDisconnect", {_this execVM "server\cleanupemptyserver.sqf"}];
_id2 = addMissionEventHandler ["PlayerConnected", {	if ((west countSide allPlayers) < 1) then {0 setfog 0};}];
//_id2 = addMissionEventHandler ["PlayerConnected", {	diag_log format  ["*** playerconnected EH says %1 players in mission when someone connects", (west countside allplayers)];}];
// might need to change the <1 depending on how quick allplayers updated. if the player connecting counts as an allplayer, this wont work
//we are trying to trigger when first player joins an empty server.
/*WORKING
Arty setpos _gopos;
Arty attachTo [frigate];
*/
forward allowdamage true;
_nul = execVM "server\replacequads.sqf";
_nul = execVM "server\reloadarty.sqf";
// authfrigate = createvehicle ["cup frigate", _fpos]
forward setdamage 0;
missionrunning = true; publicVariable "missionrunning";
nextpt = _airfield;
previousmission = nextpt;
__tky_ends
nextpt