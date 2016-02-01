///////LV_fnc_nearestBuilding.sqf 0.4 - SPUn / LostVar
//Returns array of real buildings, excluding other "house" objects
//_type "all in radius" returns [all buildings in radius] or nil
//_type "nearest one" returns [nearest building] or nil


private["_houseObjects","_type","_center","_center0","_radius","_buildings","_bld"];
_type = _this select 0;
_center = _this select 1;
_radius = _this select 2;
//diag_log format ["***type %1, _center %2, radius %3", _type,_center,_radius];
if(_center in allMapMarkers)then{
	_center0 = getMarkerPos _center;
}else{
	if (typeName _center isEqualTo "ARRAY") then{
		_center0 = _center;
	}else{
		_center0 = getPos _center;
	};
};

switch (_type) do {
	case "all in radius":{
		//_houseObjects = nearestObjects [_center0, ["house"], _radius];
		_houseObjects = _center0 nearObjects ["House_F", _radius];
	};
	case "nearest one":{
		//_houseObjects = nearestObjects [_center0, ["house"], 500];
		_houseObjects = _center0 nearObjects ["House_F", 500];
	};
};
//diag_log format ["_houseObjects @ 32 %1", _houseObjects];
//diag_log format ["count _houseObjects @ 33 %1", count _houseObjects];
//if(isNil("_houseObjects"))exitWith{diag_log "***exiting at 34";nil};
if((count _houseObjects) isEqualTo 0)exitWith{nil};

_buildings = [];
{
	if ((str(_x buildingPos 0) != "[0,0,0]") and (!(["addon", typeOf _x]call BIS_fnc_inString)) and (!(["stone_shed", typeOf _x]call BIS_fnc_inString) )) then
			{_buildings pushBack _x};
	//if ((_x buildingPos 0 select 0) != 0) then {_buildings pushBack _x};
}forEach _houseObjects;
//diag_log format ["***_buildings @ 43 is %1", _buildings];
//diag_log format ["***_buildings count @44 is %1", count _buildings];
if((count _buildings) isEqualTo 0)exitWith{diag_log "***exiting at 44";nil};
//{diag_log format ["%1, %2", _foreachindex, _x]} foreach _buildings;
switch (_type) do {
	case "all in radius":{
		_buildings;
	};
	case "nearest one":{
		_bld = _buildings select 0;
		{
			if((_x distance _center)<(_bld distance _center))then{ _bld = _x; };
		}forEach _buildings;
		_buildings = [_bld];
		_buildings;
	};
};
_buildings