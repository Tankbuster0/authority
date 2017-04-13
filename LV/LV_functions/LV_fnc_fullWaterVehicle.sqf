//ARMA3Alpha function LV_fnc_fullVehicle v2.0 - by SPUn / Kaarto Media
//Spawns random water vehicle full of units and returns the driver 
private ["_hq","_grp","_veh","_man1","_man","_i","_pos","_side","_vehSpots","_vehicle","_vCrew","_crew","_driver","_classModuleFilters","_cMember","_clean"];
_pos = param [0,[0,0,0]];
_side = param [1,0];
_classModuleFilters = param [2,[]];
_syncedUnit = param [3,nil];
_dissapearDistance = param [4,nil];
_clean = param [5,false];

_veh = [];

switch(_side)do{
	case 1:{
		_hq = createCenter west;
		_grp = createGroup west;
	};
	case 2:{
		_hq = createCenter east;
		_grp = createGroup east;
	};
	case 3:{
		_hq = createCenter resistance;
		_grp = createGroup resistance;
	};
	case 0:{
		_hq = createCenter civilian;
		_grp = createGroup civilian;
	};
};
_veh = [_classModuleFilters,[(_side), 5]] call LV_classnames;

_veh = [_veh] call LV_validateClassArrays;
if((count _veh) == 0)then{
	_veh = ([[],[(_side), 5]] call LV_classnames);
};
_veh = selectRandom _veh;
if(typeName _veh == "ARRAY")then{_veh = selectRandom _veh;};

_vehSpots = getNumber (configFile >> "CfgVehicles" >> _veh >> "transportSoldier");
_vehicle = createVehicle [_veh, _pos, [], 0, "NONE"];
if(_clean)then{
	_vehicle setVariable ["syncedUnit",_syncedUnit,false];
	_vehicle setVariable ["dissapearDistance",_dissapearDistance,false];
	_vehicle addEventHandler ["killed", {_this execVM "LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
};
_vehicle setPos _pos;

_vCrew = [_vehicle, _grp] call BIS_fnc_spawnCrew;
_crew = crew _vehicle;
if(_clean)then{
	for "_i" from 0 to ((count _crew) - 1) do{
		_cMember = _crew select _i;
		_cMember setVariable ["syncedUnit",_syncedUnit,false];
		_cMember setVariable ["dissapearDistance",_dissapearDistance,false];
		_cMember addEventHandler ["killed", {_this execVM "LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
	};
};
				
if(_vehSpots > 0)then{
	_i = 1; 
	for "_i" from 1 to _vehSpots do {
		_man1 = getText (configFile >> "CfgVehicles" >> _veh >> "crew");
		_man = _grp createUnit [_man1, _pos, [], 0, "NONE"];
		_man moveInCargo _vehicle;
		if(_clean)then{
			_man setVariable ["syncedUnit",_syncedUnit,false];
			_man setVariable ["dissapearDistance",_dissapearDistance,false];
			_man addEventHandler ["killed", {_this execVM "LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
		};
		sleep 0.3 ;
	};
};

_driver = driver _vehicle;
_driver