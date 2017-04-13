//LV_fnc_validateClassArrays.sqf - removes possible empty arrays - 1.0 - by SPUn / Kaarto Media
private ["_veh","_c","_i"];
_veh = param [0,[]];

_c = (count _veh) - 1;
for "_i" from _c to 0 step -1 do {
	if(isNil {_veh select _i})then{
		_veh deleteAt _i;
	}else{
		if(count (_veh select _i) == 0)then{
			_veh deleteAt _i;
		};
	};
};
_veh