//LV_fnc_ACAIkilled.sqf - removed dead bodies and wrecks when in valid distance
private ["_unit","_sUnit","_dissapearDistance","_nsUnit","_nearestUnit","_keep"];

_unit = param [0];
_sUnit = _unit getVariable "syncedUnit";
_dissapearDistance = _unit getVariable "dissapearDistance";

if(isMultiplayer)then{if(isNil("LV_GetPlayers"))then{LV_GetPlayers = compile preprocessFile "LV\LV_functions\LV_fnc_getPlayers.sqf";};};

while{true}do{
	_keep = _unit getVariable "LV_KEEP";
	if(isNil("_keep"))then{
		if(((typeName _sUnit) == "ARRAY")||(isMultiplayer))then{
			if(isMultiplayer)then{ _sUnit = call LV_GetPlayers;};
			if((count _sUnit)>1)then{
				_nearestUnit = _sUnit select 0;
				{
				  if((_x distance _unit)<(_nearestUnit distance _unit))then{
					_nearestUnit = _x;
				  };
				}forEach _sUnit;
				_nsUnit = _nearestUnit;
			}else{
				_nsUnit = _sUnit select 0;
			};	
		}else{
			_nsUnit = _sUnit;
		};	
		
		if((_unit distance _nsUnit) > _dissapearDistance)exitWith{
			deleteVehicle _unit;
		};
	};
	sleep 30;
};