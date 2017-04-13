/*
				***		ARMA3Alpha MILITARIZE AREA SCRIPT v3.5 - by SPUn / KAARTO MEDIA	***

			Calling the script:
			
		default: 	nul = [this] execVM "LV\militarize.sqf";
		
		custom:		nul = [target, side, radius, spawn men, spawn vehicles, still, men ratio, vehicle ratio, 
							skills, group, custom init, ID, smokes, doors, classes] execVM "LV\militarize.sqf";

		Parameters:
		
	target 		=	center point (name of marker or object or unit which is the center point of militarized area,
									or position array)
	side 		=	(0 = civilian, 1 = blue, 2 = red, 3 = green) 													DEFAULT: 2
	radius 		=	(from center position) 																			DEFAULT: 150
	spawn men 	= 	[spawn land units, spawn water units]															DEFAULT: [true,false]
					(both values are true or false)
	spawn vehicles =[spawn land vehicles, spawn water vehicles, spawn air vehicles] 								DEFAULT: [true,false,false]
					(all values are true or false)	
	still 		= 	true or false 	(if false, then units will patrol in radius, checkin also buildings) 			DEFAULT: false
	men ratio 	=	(amount of spawning men is radius * men ratio, ie: 250 * 0.2 = 50 units) 						DEFAULT: 0.1
					NOTE: Array - you can also use following syntax: [amount,random amount] for example:
					[10,5] will spawn at least 10 units + random 1-5 units 
	vehicle ratio= 	(amount of spawning vehicles is radius * vehicle ratio, ie: 250 * 0.1 = 25 vehicles) 			DEFAULT: 0.05
					NOTE: Same array syntax as in "men ratio" works here too!
	skills 		= 	"default" 	(default AI skills) 																DEFAULT: "default"
				or	number	=	0-1.0 = this value will be set to all AI skills, ex: 0.8
				or	array	=	all AI skills invidiually in array, values 0-1.0, order:
		[aimingAccuracy, aimingShake, aimingSpeed, spotDistance, spotTime, courage, commanding, general, endurance, reloadSpeed] 
		ex: 	[0.75,0.5,0.6,0.85,0.9,1,1,0.75,1,1] 
	group 		= 	group name or nil (if you want units in existing group, set it here. if nil, new group is made) DEFAULT: nil
					EXAMPLE: (group player)
	custom init = 	"init commands" (if you want something in init field of units, put it here) 					DEFAULT: nil
				NOTE: Keep it inside quotes, and if you need quotes in init commands, you MUST use ' or "" instead of ".
				EXAMPLE: "hint 'this is hint';"
	ID 			= 	number (if you want to delete units this script creates, you'll need ID number for them) 		DEFAULT: nil
	smokes		=	true/false (if true, units will use smokes and chemlights when action is on)					DEFAULT: true
	doors 		=	true/false (if true, units will close doors behind them while patrolling)						DEFAULT: true
	classes		=	array	(classes from config_aissp.hpp, defines which unit classnames are being used)			DEFAULT: ["ALL"]


EXAMPLE: nul = [this,2,50,[true,true],[true,false,true],false,[10,0],0.1,[0.2,0.2,0.2,0.85,0.9,0.75,0.1,0.6,1,1],nil,nil,nil,true,true,["ALL"]] execVM "LV\militarize.sqf";
*/
if (!isServer)exitWith{};
private ["_greenMenArray","_grpId","_customInit","_cPos","_skls","_skills","_dir","_range","_unitType","_unit","_radius","_men","_vehicles","_still","_centerPos","_menAmount","_vehAmount","_milHQ","_milGroup","_menArray","_blueMenArray","_redMenArray","_yellowMenArray","_side","_pos","_yellowCarArray","_allUnitsArray","_menRatio","_vehRatio","_diveArray","_validPos","_side","_driver","_whichOne","_vehicle","_crew","_thisArray","_smokesAndChems","_doorHandling","_BLUdivers","_OPFdivers","_INDdivers","_input","_logic","_isActivated","_pos0","_wMode"];

private ["_divers","_landVeh","_waterVeh","_airVeh","_mRatio","_vRatio","_mGroup","_classModule","_classModuleFilters"];
_cPos = param [0];
_side = param [1,2];
_radius = param [2,150];
_men = param [3,[true,false]];//[_inf,_divers];
_vehicles = param [4,[true,false,false]];//[_landVeh,_waterVeh,_airVeh];
_still = param [5,false];
_menRatio = param [6,0.1];
_vehRatio = param [7,0.05];
_skills = param [8,"default"];
_milGroup = param [9,nil];
if(!isNil "_milGroup")then{if(_milGroup == "nil" || _milGroup == "nil0")then{_milGroup = nil;};};
_customInit = param [10,nil];
if(!isNil "_milGroup")then{if(_customInit == "nil" || _customInit == "nil0")then{_customInit = nil;};};
_grpId = param [11,nil];
_smokesAndChems = param [12,true];
_doorHandling = param [13,true];
_classModuleFilters = param [14,["ALL"]];

if(_cPos in allMapMarkers)then{
	_centerPos = getMarkerPos _cPos;
}else{
	if (typeName _cPos == "ARRAY") then{
		_centerPos = _cPos;
	}else{
		_centerPos = getPos _cPos;
	};
};

if(isNil("LV_classnames"))then{LV_classnames = compile preprocessFile "LV\LV_functions\LV_fnc_classnames.sqf";};
if(isNil("LV_validateClassArrays"))then{LV_validateClassArrays = compile preprocessFile "LV\LV_functions\LV_fnc_validateClassArrays.sqf";};
if(isNil("LV_ACskills"))then{LV_ACskills = compile preprocessFile "LV\LV_functions\LV_fnc_ACskills.sqf";};
if(isNil("LV_vehicleInit"))then{LV_vehicleInit = compile preprocessFile "LV\LV_functions\LV_fnc_vehicleInit.sqf";};
if(isNil("LV_fullLandVehicle"))then{LV_fullLandVehicle = compile preprocessFile "LV\LV_functions\LV_fnc_fullLandVehicle.sqf";};
if(isNil("LV_fullAirVehicle"))then{LV_fullAirVehicle = compile preprocessFile "LV\LV_functions\LV_fnc_fullAirVehicle.sqf";};
if(isNil("LV_fullWaterVehicle"))then{LV_fullWaterVehicle = compile preprocessFile "LV\LV_functions\LV_fnc_fullWaterVehicle.sqf";};

if(typeName _menRatio == "ARRAY")then{	
	_menAmount = (_menRatio select 0) + (random (_menRatio select 1));
}else{
	_menAmount = round (_radius * _menRatio);
};
if(typeName _vehRatio == "ARRAY")then{	
	_vehAmount = (_vehRatio select 0) + (random (_vehRatio select 1));
}else{
	_vehAmount = round (_radius * _vehRatio);
};
_allUnitsArray = [];


switch (_side) do { 
    case 1: {
        _milHQ = createCenter west;
		if(isNil("_milGroup"))then{_milGroup = createGroup west;}else{_milGroup = _milGroup;};
    }; 
    case 2: {
        _milHQ = createCenter east;
        if(isNil("_milGroup"))then{_milGroup = createGroup east;}else{_milGroup = _milGroup;};
    }; 
	case 3: {
        _milHQ = createCenter resistance;
        if(isNil("_milGroup"))then{_milGroup = createGroup resistance;}else{_milGroup = _milGroup;};
    }; 
    default {
        _milHQ = createCenter civilian;
        if(isNil("_milGroup"))then{_milGroup = createGroup civilian;}else{_milGroup = _milGroup;};
    }; 
};
_yellowCarArray = [];

_menArray = ([_classModuleFilters,[(_side), 6]] call LV_classnames);
_menArray = [_menArray] call LV_validateClassArrays;
if((count _menArray) == 0)then{
	_menArray = ([[],[(_side), 6]] call LV_classnames);
};
_menArray = selectRandom _menArray;
_diveArray = ([_classModuleFilters,[(_side), 7]] call LV_classnames);
_diveArray = [_diveArray] call LV_validateClassArrays;
if((count _diveArray) == 0)then{
	_diveArray = ([[],[(_side), 7]] call LV_classnames);
};
_diveArray = selectRandom _diveArray;

_wMode = 1;

if((_men select 0)||(_men select 1))then{
	for "_i" from 1 to _menAmount do{
		_validPos = false;
		while{!_validPos}do{
			_dir = random 360;
			_range = random _radius;
			_pos0 = [(_centerPos select 0) + (sin _dir) * _range, (_centerPos select 1) + (cos _dir) * _range, 0];
			_pos = [_pos0,0,35,1,_wMode,1,0] call BIS_fnc_findSafePos;
			if(_side > 0)then{
				if(surfaceIsWater _pos)then{
					if(_men select 1)then{
						_unitType = selectRandom _diveArray;
						_validPos = true;
					}else{
						_wMode = 0;
					};
				}else{
					if(_men select 0)then{
						_unitType = selectRandom _menArray;
						_validPos = true;
					}else{
						_wMode = 2;
					};
				};
			}else{
				if(!surfaceIsWater _pos)then{
					_unitType = selectRandom _menArray;
					_validPos = true;
				};
			};
		};
		_unit = _milGroup createUnit [_unitType, _pos, [], 0, "NONE"];
		_unit setPos _pos;

		if(!_still)then{
			if(_unitType in _menArray)then{
				nul = [_unit,_cPos,_radius,_doorHandling] execVM "LV\patrol-vD.sqf";
			}else{
				nul = [_unit,_pos] execVM 'LV\patrol-vH.sqf';
			};
		};
		_unit allowDamage false;
		_allUnitsArray set [(count _allUnitsArray), _unit];
			
		_unit addMagazine ["SmokeShell",2];
		_unit addMagazine [(selectRandom ["Chemlight_green","Chemlight_red","Chemlight_yellow","Chemlight_blue"]),2];
	};
};

_milGroup setBehaviour "SAFE";
_wMode = 1;

if((_vehicles select 0)||(_vehicles select 1)||(_vehicles select 2))then{
    for "_i" from 1 to _vehAmount do{
        	
		_validPos = false;
		while{!_validPos}do{
		
			_dir = random 360;
			_range = random _radius;
			_pos0 = [(_centerPos select 0) + (sin _dir) * _range, (_centerPos select 1) + (cos _dir) * _range, 0];
			_pos = [_pos0,0,50,5,_wMode,.25,0] call BIS_fnc_findSafePos;
			
			if(true)then{ //side > 0
				if(surfaceIsWater _pos)then{
					if(_vehicles select 1)then{
						_driver = [_pos, (_side),_classModuleFilters,nil,nil,false] call LV_fullWaterVehicle;
						if(!_still)then{nul = [vehicle _driver,_pos] execVM 'LV\patrol-vH.sqf';};
						_validPos = true;
					}else{
						_wMode = 0;
					};
				}else{
					if((_vehicles select 0)&&(_vehicles select 2))then{
						_whichOne = floor(random 10);
						if(_whichOne < 3)then{
							_driver = [_pos, (_side),_classModuleFilters,nil,nil,false] call LV_fullAirVehicle;
							if(!_still)then{nul = [_driver,_pos,[200,200]] execVM 'LV\patrol-vE.sqf';};
							vehicle _driver flyInHeight 10;
							_validPos = true;
						}else{
							_driver = [_pos, (_side),_classModuleFilters,nil,nil,false] call LV_fullLandVehicle;
							if(!_still)then{nul = [vehicle _driver,_pos] execVM 'LV\patrol-vE.sqf';};
							_validPos = true;
						};
					}else{
						if(_vehicles select 0)then{
							_driver = [_pos, (_side),_classModuleFilters,nil,nil,false] call LV_fullLandVehicle;
							if(!_still)then{nul = [vehicle _driver,_pos] execVM 'LV\patrol-vE.sqf';};
							_validPos = true;
						}else{
							if(_vehicles select 2)then{
								_driver = [_pos, (_side),_classModuleFilters,nil,nil,false] call LV_fullAirVehicle;
								if(!_still)then{nul = [_driver,_pos,[200,200]] execVM 'LV\patrol-vE.sqf';};
								vehicle _driver flyInHeight 10;
								_validPos = true;
							};
						};
					};
				};
			};
		
		};
		 
		_vehicle = vehicle _driver;
        _vehicle allowDamage false;
        
        _allUnitsArray set [(count _allUnitsArray), _vehicle];
        
		(units(group _driver)) joinSilent _milGroup; 
    };
};

	{ 
		if((typeName _skills != "STRING")&&((side _x) != civilian))then{ _skls = [_x,_skills] call LV_ACskills; }; 
		if(!isNil("_customInit"))then{ 
			[_x,_customInit] spawn LV_vehicleInit;
		};
	} forEach units _milGroup;


sleep 3;
{
    _x allowDamage true;
}forEach _allUnitsArray;

if(!isNil("_grpId"))then{
	call compile format ["LVgroup%1 = _milGroup",_grpId];
	call compile format["LVgroup%1spawned = true;", _grpId];
	_thisArray = [];
	{ 
		if(isNil("_x"))then{
			_thisArray set[(count _thisArray),"nil0"];
		}else{
			_thisArray set[(count _thisArray),_x];
		};
	}forEach _this;
	call compile format["LVgroup%1CI = ['militarize',%2]",_grpId,_thisArray];
};

if(_smokesAndChems)then{
[_milGroup] spawn {
	private ["_grp","_chance"];
	_grp = _this select 0;
	while{({alive _x}count units _grp) > 0}do{
			{
				if((behaviour _x) == "COMBAT")then{
					if(daytime > 23 || daytime < 5)then{
						_chance = floor(random 100);
						if(_chance < 3)then{
							if("Chemlight_green" in (magazines _x))exitWith{
								_x playActionNow "gestureCover";
								_x selectWeapon "ChemlightGreenMuzzle";
								_x fire ["ChemlightGreenMuzzle","ChemlightGreenMuzzle","Chemlight_green"];
							};
							if("Chemlight_red" in (magazines _x))exitWith{
								_x playActionNow "gestureCover";
								_x selectWeapon "ChemlightRedMuzzle";
								_x fire ["ChemlightRedMuzzle","ChemlightRedMuzzle","Chemlight_red"];
							};
							if("Chemlight_yellow" in (magazines _x))exitWith{
								_x playActionNow "gestureCover";
								_x selectWeapon "ChemlightYellowMuzzle";
								_x fire ["ChemlightYellowMuzzle","ChemlightYellowMuzzle","Chemlight_yellow"];
							};
							if("Chemlight_blue" in (magazines _x))exitWith{
								_x playActionNow "gestureCover";
								_x selectWeapon "ChemlightBlueMuzzle";
								_x fire ["ChemlightBlueMuzzle","ChemlightBlueMuzzle","Chemlight_blue"];
							};
						};
					};
					if("SmokeShell" in (magazines _x))then{ 
						_chance = floor(random 100);
						if(_chance < 3)exitWith{ //3
							_x playActionNow "gestureCover";
							_x selectWeapon "SmokeShellMuzzle";
							_x fire ["SmokeShellMuzzle","SmokeShellMuzzle","SmokeShell"];
						};
					};
				};
			}forEach units _grp;
		sleep 10;
	};
};
};