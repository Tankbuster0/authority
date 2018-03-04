//by tankbuster
 #include "..\includes.sqf"
_myscript = "missionsetup";
__tky_starts;
private ["_airfield","_beachheadpos","_airfieldpos","_q","_mypos","_mytruck","_mymortar","_frigateposdata","_l","_mydata1","_fpos","_pos", "_refuse"];
_airfield = selectRandom foundairfields;//choose a random airfield
foundairfields = foundairfields - [_airfield];
myairfield = _airfield getvariable ["targetname", "spingfield"]; publicVariable "myairfield";
enableVehicleCrashes = false;
//addMissionEventHandler ["BuildingChanged", {diag_log format ["from %1, to %2, isruin %3", _this select 0, _this select 1, _this select 2]}];
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
[forward] call tky_fnc_setvehicleloadout;
[forward, "forward"] call fnc_setVehicleName;

forwardrespawnpositionid = [west,"forwardmarker", "Forward Vehicle"] call BIS_fnc_addrespawnposition;
/*
{
	_tmp = Forward call compile format [ "get%1Cargo _this", _x ];
	_unique = [];
	{
		if !( _x in _unique ) then {
			_unique pushBack _x;
		};
	}forEach _tmp;
	//CQBCleanupArr pushBack _unique;
}forEach [ "backpack", "item", "magazine", "weapon" ];
*/
// Take out advanced ammo types;
Arty removeMagazinesTurret ["2Rnd_155mm_Mo_Cluster",[0]];
Arty removeMagazinesTurret ["6Rnd_155mm_Mo_AT_mine",[0]];
Arty removeMagazinesTurret ["6Rnd_155mm_Mo_mine",[0]];

_id1 = addMissionEventHandler ["HandleDisconnect", {_this execVM "server\handleplayerdisconnect.sqf"}];

if (toLower (worldName) isEqualTo "tanoa") then
	{
	hs = createVehicle ["Land_Hospital_main_F", [5690,9937,0], [], 0, "NONE"];
	hs setDir 63;
	var = createVehicle ["Land_Hospital_side1_F", [0,0,0], [], 0, "NONE"];
	var attachTo [hs, [4.69775,32.6045,-0.1125]];
	detach var;
	var1 = createVehicle ["Land_Hospital_side2_F", [0,0,0], [], 0, "NONE"];
	var1 attachTo [hs, [-28.0336,-10.0317,0.0889387]];
	detach var1;
	};


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