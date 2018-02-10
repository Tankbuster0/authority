/*  Copyright 2016 Fluit

    This file is part of Dynamic Enemy Population.

    Dynamic Enemy Population is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation version 3 of the License.

    Dynamic Enemy Population is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dynamic Enemy Population.  If not, see <http://www.gnu.org/licenses/>.
*/
// This file creates patroling air vehicles

dep_fnc_spawn_air =
{
	private ["_start","_end","_startpos","_endpos","_waypoints","_vehicle","_group","_player","_safe"];
	_waypoints = _this select 0;

	_start = floor random (count _waypoints);
	_end = _start;
	_startpos = _waypoints select _start;
	_endpos = _waypoints select _end;
	while {(_startpos distance _endpos) < (dep_map_radius * 1.75)} do
	{
		_end = floor random (count _waypoints);
		_endpos = _waypoints select _end;
	};

	["Begin air patrol from %1 to %2", _start, _end] spawn dep_fnc_log;

	_return = [_startpos, 0, (dep_air_vehicles call BIS_fnc_selectRandom), civilian] call BIS_fnc_spawnVehicle;
	_vehicle = _return select 0;
	_group = _return select 2;
    switch (typeOf _vehicle) do
        {
        case "I_Heli_Transport_02_F":
            {
            if ((random 1) > 0.5  ) then
                {
                _vehicle setObjectTextureGlobal [0,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa"];
                _vehicle setObjectTextureGlobal [1,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa"];
                _vehicle setObjectTextureGlobal [2,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa"];
                }
                else
                {
                _vehicle setObjectTextureGlobal [0,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_ion_co.paa"];
                _vehicle setObjectTextureGlobal [1,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_ion_co.paa"];
                _vehicle setObjectTextureGlobal [2,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_ion_co.paa"];
                };
            };
        case  "O_Heli_Light_02_unarmed_F": {_vehicle setObjectTextureGlobal [0, "\a3\air_f\Heli_Light_02\Data\heli_light_02_ext_civilian_co.paa"]; };
        case "I_Heli_light_03_unarmed_F": { [_vehicle, ["Green",1], true] call BIS_fnc_initVehicle;};
        };
    _freeCargoPositions = _vehicle emptyPositions "cargo";
    if (_freeCargoPositions >= 1) then {
        _freeCargoPositions = ceil random _freeCargoPositions;
        for "_y" from 1 to _freeCargoPositions do {
            _soldiername = dep_mil_units call BIS_fnc_selectRandom;
            _soldier = [_group, _soldiername, (getPosATL _vehicle)] call dep_fnc_createunit;
            _soldier assignAsCargo _vehicle;
            _soldier moveInCargo _vehicle;
        };
    };

    if (_vehicle isKindOf "Plane") then {
        _vehicle flyInHeight 100;
    } else {
        _vehicle flyInHeight 50;
        _group setCombatMode "RED";
    };

    _player = dep_players call BIS_fnc_selectRandom;
    if !(isNil "_player") then {
        _player = getPos _player;
        _safe = [_player] call dep_fnc_outsidesafezone;
        if !(_safe) then {
            _player = _player getpos [dep_safe_rad, random 360];
        };
        _wp = _group addWaypoint [_player, 1000];
        _wp setWaypointBehaviour "SAFE";
        if ((random 1) < 0.5) then {
            _wp setWaypointSpeed "NORMAL";
        } else {
            _wp setWaypointSpeed "LIMITED";
        };
        _wp setWaypointFormation "COLUMN";
        _wp setWaypointType "MOVE";
    };

	_wp = _group addWaypoint [_endpos, 0];
	_wp setWaypointBehaviour "SAFE";
	if ((random 1) < 0.5) then
	{
		_wp setWaypointSpeed "NORMAL";
	} else {
		_wp setWaypointSpeed "LIMITED";
	};
	_wp setWaypointFormation "COLUMN";
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 300;
	_wp setWaypointStatements ["true", "cleanUpveh = vehicle leader this; {deleteVehicle _x} forEach crew cleanUpveh + [cleanUpveh];"];

	_vehicle;
};

waitUntil {!isNil "dep_air_patrols"};
waitUntil {dep_air_patrols > 0};

private ["_vehicles", "_waypoints", "_waypoints_available", "_interval"];
_waypoints = [];
_vehicles = [];

// Find waypoints
_newdir = 0;
for "_c" from 0 to 15 do
{
    _pos = dep_map_center getpos [dep_map_radius + 1000, _newdir];
    _newdir = _newdir + (360 / 16);
    if (dep_debug) then
    {
        _m = createMarker[format["dep_air_wp_%1", _c], _pos];
        _m setMarkerType "o_plane";
        _m setMarkerText (str _c);
        _m setMarkerColor "ColorRed";
    };
    _waypoints = _waypoints + [_pos];
};

//_interval = round ((4096 / (dep_map_center select 0)) * 600);
_interval = 900;
["Air patrol interval is %1 seconds.", _interval] spawn dep_fnc_log;

waitUntil {dep_num_players > 0};

while {true} do
{
    {
        _vehicle = _x;
        if (!isNull _vehicle) then
        {
            if (!alive _vehicle || !canMove _vehicle) then
            {
                [_vehicle] spawn dep_fnc_delete_vehicle;
                _vehicles = _vehicles - [_vehicle];
                sleep _interval;
            };
        } else {
            _vehicles = _vehicles - [_vehicle];
        };
    } forEach _vehicles;
    while {(count _vehicles) < dep_air_patrols && dep_num_players > 0} do
    {
        waitUntil {!dep_exceeded_group_limit};
        waitUntil {!dep_exceeded_ai_limit};
        _vehicle = [_waypoints] call dep_fnc_spawn_air;
        _vehicles = _vehicles + [_vehicle];
        sleep _interval;
    };
    sleep (random _interval);
};