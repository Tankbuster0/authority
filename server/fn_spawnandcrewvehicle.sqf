//fn_spawnandcrewvehicle
// by Moricky and Tankbuster
params ["_pos", "_dir", "_type", "_sidegroup"];// [position], direction, "classname", side/group (same as BIS_fnc_spawnvehicle)
_veharray = [_pos,_dir,_type, _sidegroup] call BIS_fnc_spawnvehicle;
_veh = _vehArray select 0;
_vehCrew = _vehArray select 1;
_vehGroup = _vehArray select 2;
if (count _vehCrew > 0) then
	{
        _crewType = typeof (_vehCrew select 0);
        while {_veh emptypositions "cargo" > 0} do
		{
            _unit = _vehGroup createunit [_crewType,(getpos _veh),[],0,"none"];
            _unit assignascargo _veh;
            _unit moveincargo _veh;
        };
    };
[_veh]