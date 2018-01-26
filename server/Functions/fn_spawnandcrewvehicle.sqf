//fn_spawnandcrewvehicle
// by Moricky and Tankbuster
 #include "..\includes.sqf"
private ["_pos","_dir","_type","_sidegroup","_veharray","_veh","_vehArray","_vehCrew","_vehGroup","_crewType","_unit", "_dude"];
params ["_pos", "_dir", "_type", "_sidegroup"];// [position], direction, "classname", side/group (same as BIS_fnc_spawnvehicle)
_veharray = [_pos,_dir,_type, _sidegroup] call BIS_fnc_spawnvehicle;
_veh = _vehArray select 0;
_vehCrew = _vehArray select 1;
_vehGroup = _vehArray select 2;
if (count _vehCrew > 0) then
	{
        _dude = (getarray (configFile/"cfgVehicles"/(typeOf _veh)/ "typicalcargo")) select 0;
        if ((typeOf _veh) in ["I_Truck_02_transport_F"]) then {_dude = "I_soldier_F"};//BI put typical cargo for this as a civvy.
        while {_veh emptypositions "cargo" > 0} do
		{
            _unit = _vehGroup createunit [_dude,(getpos _veh),[],0,"none"];
            _unit assignascargo _veh;
            _unit moveincargo _veh;
        };
    };
_veh