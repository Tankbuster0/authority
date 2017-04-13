/*				***		ARMA3Alpha REINFORCEMENT CHOPPER SCRIPT v1.3 - by SPUn / lostvar	***
				Spawns chopper which transports infantry group to position and leaves after that
		Calling the script:
			default: 		nul = [this] execVM "LV\reinforcementChopper.sqf";
			custom: 		nul = [spot,exact,side,type,captive,patrol,target,direction,distance,precise,
								cycle,groupSize,skills,group,custom init,ID] execVM "reinforcementChopper.sqf";
	Parameters:
	spot 	= 	landing spot 	(name of marker or object or unit, or position array) 									DEFAULT: this
	exact 	= 	true or false 	(true = tries landing exactly on *spot, false = finds place where it fits) 				DEFAULT: true
	side 	= 	1 or 2 			(1 = west, 2 = east) 																	DEFAULT: 2
	type 	= 	choppertype 	(1=AH9, 2=MH9, 3=KA60, 4=KA60_Unarmed, 5=mohawk)										DEFAULT: 3
	captive = 	true/false 		(if true, enemies wont notice them before chopper has landed) 							DEFAULT: false
	patrol 	= 	true/false 		(if false, units wont patrol in any way <- handy if you set (group player) as *group) 	DEFAULT: true
	target 	= 	patrol target 	(patrolling target for infantry group, options:											DEFAULT: player
								unit 	= 	units name, ex: enemyunit1
								marker 	= 	markers' name, ex: "marker01" (remember quotes with markers!)
								marker array = array of markers in desired order, ex: ["marker01","marker02","marker03"]
								group	= 	groups name, ex: (group enemy1)	OR BlueGroup17
								group array, ex: [(group player), (group blue2)]
								["PATROL",center position,radius] = uses patrol-vD.sqf, ex: ["PATROL",(getPos player),150]
	direction 	= 	"random" or 0-360 (direction where chopper comes from, use quotes with random!) 									DEFAULT: "random"
	distance 	= 	number (from how far KA60 comes from) 																				DEFAULT: 1500
	precise 	= 	true or false (true = heli will land even in middle of war, false = heli might have air fights etc before landing) 	DEFAULT: true
	cycle 		= 	true or false (if true and target is array of markers, unit will cycle these markers) 								DEFAULT: false
	groupSize 	= 	1-8 (infantry groups' size) 																						DEFAULT: 8
	skills 		= 	"default" 	(default AI skills) 																					DEFAULT: "default"
				or	number	=	0-1.0 = this value will be set to all AI skills, ex: 0.8
				or	array	=	all AI skills invidiually in array, values 0-1.0, order:
						[aimingAccuracy, aimingShake, aimingSpeed, spotDistance, spotTime, courage, commanding, general, endurance, reloadSpeed]
						ex: 	[0.75,0.5,0.6,0.85,0.9,1,1,0.75,1,1]
	group 		= 	group name OR nil (if you want units in existing group, set it here. if this is left empty, new group is made) 		DEFAULT: nil
	custom init = 	"init commands" (if you want something in init field of units, put it here) 										DEFAULT: nil
					NOTE: Keep it inside quotes, and if you need quotes in init commands, you MUST use ' or "" instead of ",
						 ex: "hint 'this is hint';"
	ID 			= 	number (if you want to delete units this script creates, you'll need ID number for them)							DEFAULT: nil
	EXAMPLE: 	nul = [player,false,2,3,false,true,player,"random",1000,true,false,8,0.75,nil,nil,33] execVM "reinforcementChopper.sqf";
*/
 #include "..\includes.sqf"
_myscript = "ai_reinforcementchopper.sqf";
__tky_starts;
private ["_captive","_patrol","_heliT","_chopperTypes","_chopperType","_setInit2","_setInit","_c0","_customInit","_tPos","_exactPos","_skls","_skills","_grpSize","_cycle","_precise","_man2","_direction","_distance","_targetM","_i2","_heliPad","_targetPos","_side","_targetMarker","_BLUmen","_OPFmen","_men","_hq","_grp1","_grp2","_man1","_man","_dir","_range","_pos","_heli","_vehSpots","_i","_wp1"];
//Extra options:
_doorHandling = true;
//Check parameters:
_tPos = if (count _this > 0) then {_this select 0};
_exactPos = if (count _this > 1) then {_this select 1; }else{true;};
_side = if (count _this > 2) then {_this select 2; }else{2;};
_chopperType = if (count _this > 3) then {_this select 3; }else{3;};
_captive = if (count _this > 4) then {_this select 4; }else{false;};
_patrol = if (count _this > 5) then {_this select 5; }else{true;};
_targetMarker = if (count _this > 6) then {_this select 6; }else{player;};
_direction = if (count _this > 7) then {_this select 7; }else{"random";};
_distance = if (count _this > 8) then {_this select 8; }else{1500;};
_precise = if (count _this > 9) then {_this select 9; }else{true;};
_cycle = if (count _this > 10) then {_this select 10; }else{false;};
_grpSize = if (count _this > 11) then {_this select 11; }else{8;};
_skills = if (count _this > 12) then {_this select 12; }else{[0.12,0.12,0.12,0.2,0.17,0.3,0.5,0.4,0.35,0.3];};// previous as set to "default"
_grp2 = if (count _this > 13) then {_this select 13; }else{nil;};
_customInit = if (count _this > 14) then {_this select 14; }else{nil;};
_grpId = if (count _this > 15) then { _this select 15;} else {nil};
	//Check if spot is marker, object, or position array:
	if(_tPos in allMapMarkers)then{
		_targetPos = getMarkerPos _tPos;
	}else{
		if (typeName _tPos isEqualTo "ARRAY") then{
			_targetPos = _tPos;
		}else{
			_targetPos = getPos _tPos;
		};
	};
//Prepare functions:
if(isNil("LV_ACskills"))then{LV_ACskills = compile preprocessFile "LV\LV_functions\LV_fnc_ACskills.sqf";};
if(isNil("LV_RandomSpot"))then{LV_RandomSpot = compile preprocessFile "LV\LV_functions\LV_fnc_randomSpot.sqf";};
if(isNil("LV_vehicleInit"))then{LV_vehicleInit = compile preprocessFile "LV\LV_functions\LV_fnc_vehicleInit.sqf";};
//Unit arrays:ADJ REV 21 JON
_BLUmen = ["B_soldier_AR_F","B_soldier_exp_F","B_Soldier_GL_F","B_soldier_M_F","B_medic_F","B_Soldier_F","B_soldier_repair_F","B_soldier_LAT_F","B_Soldier_SL_F","B_Soldier_lite_F","B_Soldier_TL_F"];
_OPFmen = ["O_T_Recon_TL_F","O_V_Soldier_LAT_ghex_F","O_T_Recon_LAT_F", "O_V_Soldier_ghex_F", "O_T_Sniper_F", "O_T_Sniper_F","O_V_Soldier_ghex_F","O_V_Soldier_ghex_F"];
_chopperTypes = ["O_T_VTOL_02_infantry_F","O_T_VTOL_02_vehicle_F","O_Heli_Transport_04_medevac_F"];//"O_HelO_Heli_Transport_04_bench_F"
//Side related group creation:
switch(_side)do{
	case 1:{
		_grp1 = createGroup west;
		if(isNil("_grp2"))then{_grp2 = createGroup west;}else{_grp2 = _grp2;};
		_men = _BLUmen;
	};
	case 2:{
		_grp1 = createGroup east;
		if(isNil("_grp2"))then{_grp2 = createGroup east;}else{_grp2 = _grp2;};
		_men = _OPFmen;
		diag_log format ["*** aireinfchopper chooses east side and men is %1", _men];
	};
};
//If *exact* is false, find landing spot which is not close another ones:
if(!_exactPos)then{
	if(isNil("REKA60padArray"))then{REKA60padArray = [];};
	_finding = 1;
	_ra = 20;
	while{_finding > 0}do{
		_tPos = [];
		while{count _tPos < 1}do{
			_spot = [_targetPos, _ra] call LV_RandomSpot;
			_tPos = _spot isflatempty [12,0,0.3,4,0,false,objnull];
			_ra = _ra + 10;
		};
		sleep 0.001;
		_targetPos = _tPos;
		_e1 = 0;
		_finding = 0;

		while{_e1<(count REKA60padArray)}do{
			if(((REKA60padArray select _e1) distance _targetPos)<3.8)then{_finding = 1;};
			_e1 = _e1 + 1;
		};
	};
	REKA60padArray set [(count REKA60padArray), _targetPos];
};
_heliT = _chopperTypes select (_chopperType - 1);
_heliPad = createVehicle ["Land_helipadEmpty_F", _targetPos, [], 0, "NONE"];
if(typeName _direction isEqualTo "STRING")then{_dir = random 360;}else{_dir = _direction;};
_range = _distance;
_pos = [(_targetPos select 0) + (sin _dir) * _range, (_targetPos select 1) + (cos _dir) * _range, 0];
_heli = createVehicle [_heliT, _pos, [], 0, "FLY"];
_heli setfuel 0.02;
_t_ehindex = _heli addeventhandler ["HandleDamage", {if ((_this select 4) isKindOf "MissileCore") then { 1; } else { _this select 2; }; }];
//diag_log format ["*** rc spawns an aircraft at %1", _pos];
if(_grpSize > (getNumber (configFile >> "CfgVehicles" >> _heliT >> "transportSoldier")))then{
	_vehSpots = getNumber (configFile >> "CfgVehicles" >> _heliT >> "transportSoldier");
}else{
	_vehSpots = _grpSize;
};
_man = _grp1 createUnit ["O_helipilot_F", _pos, [], 0, "NONE"];
_man moveInDriver _heli;
_man assignAsDriver _heli;
_hcrew = [_heli, _grp2] call bis_fnc_spawnCrew;
_man setUnitRank "SERGEANT";
if(_precise)then{_man setBehaviour "CARELESS";};
[_man,_heli,_targetPos] spawn {
	_man = _this select 0;
	_heli = _this select 1;
	_targetPos = _this select 2;
	waitUntil {sleep 1; !isNil "_man" && !isNil "_heli"};
	waitUntil {sleep 1; !alive _man || !canMove _heli || isNil "_man" || isNil "_heli"};
	if (true) exitWith {
		if (!isNil "_targetPos" && !isNil "REKA60padArray") then {
			if ((_heli distanceSqr _targetPos) > 7)then{REKA60padArray = REKA60padArray - [_targetPos];};
		};
		if(_heli distanceSqr _targetPos > 14.1)then{
			sleep 15;
			deleteVehicle _man;
			sleep 15;
			deleteVehicle _heli;
		};
	};
};
_i = 1;
for "_i" from 1 to _vehSpots do {
	_man1 = selectRandom _men;
	_man2 = _grp2 createUnit [_man1, _pos, [], 0, "NONE"];
	if(typeName _skills != "STRING")then{_skls = [_man2,_skills] call LV_ACskills;};
	_man2 moveInCargo _heli;
	if(!isNil("_customInit"))then{
		[_man2,_customInit] spawn LV_vehicleInit;
	};
};
if((_vehSpots isEqualTo 0)&&(_grpSize > 0))then{
	_man1 = _men selectRandom _men;
	_man2 = _grp2 createUnit [_man1, _pos, [], 0, "NONE"];
	if(typeName _skills != "STRING")then{_skls = [_man2,_skills] call LV_ACskills;};
	_man2 moveInTurret [_heli, [0]];
	if(!isNil("_customInit"))then{
		[_man2,_customInit] spawn LV_vehicleInit;
	};
};

if(!isNil("_grpId"))then{
	call compile format ["LVgroup%1 = _grp2",_grpId];
};
if(_captive)then{
	{ _x setCaptive true; }forEach units _grp1;
	{ _x setCaptive true; }forEach units _grp2;
};
_heli doMove _targetPos;
while { _heli distanceSqr _targetPos > 16.1 } do { sleep 4; };
doStop _heli;
_heli land "LAND"; //you can also try "GET OUT" (then it wont land, only hovers)
_tsmoke = createVehicle ["SmokeShellPurple", [_targetPos select 0, _targetPos select 1, 0],[],0, "CAN_COLLIDE"];
_helipad setpos getpos _tsmoke;
while { (getPos _heli) select 2 > 1 } do { sleep 2; };
if(_captive)then{
	{ _x setCaptive false; }forEach units _grp1;
	{ _x setCaptive false; }forEach units _grp2;
};

_grp2 leaveVehicle _heli;
{
	unassignVehicle _x;
	doGetOut _x;
	_x setBehaviour "COMBAT";
} forEach units _grp2;
_grp2 setCombatMode "RED";
while { (count (crew _heli)) > 1 } do { sleep 2;  };
_heli doMove _pos;
_heli setBehaviour "CARELESS";
if(_patrol)then{
	if(typeName _targetMarker isEqualTo "ARRAY")then{ //TARGET is array
		if((!((_targetMarker select 0) in allMapMarkers))&&(!((_targetMarker select 0) in allGroups)))then{
			if((typeName (_targetMarker select 0)) isEqualTo "STRING")then{
				if((_targetMarker select 0) isEqualTo "PATROL")then{ ////USE patrol-vD.sqf
					{
						_cPosition = _targetMarker select 1;
						_cRadius = _targetMarker select 2;
						nul = [_x,_cPosition,_cRadius,_doorHandling] execVM "LV\patrol-vD.sqf";
					}forEach units _grp2;
				};
			};
		}else{ //TARGET is array of Markers or Groups
			{
				_x setVariable ["target0",_targetMarker,false];
				_x setVariable ["mDis0", 1000, false];
				if(_cycle)then{
					nul = [_x,true] execVM "LV\LV_functions\LV_fnc_follow.sqf";
				}else{
					nul = [_x,false] execVM "LV\LV_functions\LV_fnc_follow.sqf";
				};
				sleep 2;
			}forEach units _grp2;
		};
	}else{
		if(_targetMarker in allMapMarkers)then{ /////TARGET is single Marker
			{ _x doMove getMarkerPos _targetMarker; } forEach units _grp2;
		}else{
				{ ////TARGET is single Unit/Object
					_x setVariable ["target0",_targetMarker,false];
					_x setVariable ["mDis0", 1000, false];
					nul = [_x] execVM "LV\LV_functions\LV_fnc_follow.sqf";
				}forEach units _grp2;
		};
	};
}else{
	//If patrol is set to false, units will idle. Additionally you can set custom actions here:
};
while { (_heli distanceSqr _pos > 14.1) } do { sleep 4; };
if ((_heli distanceSqr _targetPos) > 7)then{REKA60padArray = REKA60padArray - [_targetPos];};
if((_heli distanceSqr _pos < 20))exitWith{
	deleteVehicle _man;
	deleteVehicle _heli;
	deleteVehicle _helipad;
};
__tky_ends