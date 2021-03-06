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
// This file spawns a roadblock at the given location.
private ["_pos", "_dir", "_newpos", "_campgroup", "_prop", "_soldier", "_gate", "_groups", "_totalenemies", "_objects"];
_pos    = _this select 0; // roadblock position
_dir    = _this select 1; // roadblock direction

_groups = [];
_totalenemies = 0;
_objects = [];

_campgroup = createGroup dep_side;
_groups = _groups + [_campgroup];
_campgroup setFormDir _dir;

_gate = "Land_BarGate_F" createVehicle _pos;
_gate setDir _dir;

if ((random 1) < 0.7) then
{
    _newpos = _gate getpos [6, _dir];
    _newpos = _newpos getPos [11, _dir - 90];
    _prop = "Land_Sign_WarningMilitaryArea_F" createVehicle _newpos;
    _prop setDir _dir + 180;
};

_newpos = _gate getPos [7, _dir];
_newpos = _newpos getPos [11, _dir - 90];
_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
_prop setDir _dir;

_newpos = _gate getPos [7, _dir];
_newpos = _newpos getPos [16, _dir - 90];
_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
_prop setDir _dir;

_newpos = _gate getPos [7, _dir];
_newpos = _newpos getPos [3, _dir + 90];
_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
_prop setDir _dir;

_newpos = _gate getPos [7, _dir];
_newpos = _newpos getPos [7, _dir + 90];
_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
_prop setDir _dir;


_newpos = _gate getpos [9, _dir + 180];
_newpos = _newpos getPos [4, _dir + 90];
_prop = "Land_HBarrier_5_F" createVehicle _newpos;
_prop setDir _dir;

_newpos = _gate getPos [9, _dir + 180];
_newpos = _newpos getPos [13, _dir - 90];
_prop = "Land_HBarrier_5_F" createVehicle _newpos;
_prop setDir _dir;

_newpos = _gate getPos [4, _dir + 180];
_newpos = _newpos getPos [5, _dir + 90];
_prop = (selectRandom ["Land_LampShabby_F","Land_TTowerSmall_1_F","Land_FieldToilet_F"]) createVehicle _newpos;
_prop setDir _dir;

_newpos = _gate getPos [14, _dir - 90];
if (random 1 > 0.5) then {
    _prop = "Land_BagBunker_Small_F" createVehicle _newpos;
    _prop setDir (_dir + 180);
} else {
    _prop = "Land_Cargo_House_V3_F" createVehicle _newpos;
    _prop setDir (_dir - 90);
};

_newpos = (position _gate) findEmptyPosition[0, 30, dep_box_ammo];
_prop = (selectRandom [dep_box_ammo, dep_box_special, dep_box_weapons, dep_box_ord]) createVehicle _newpos;
_prop setDir (_dir + 90);
sleep 0.02;

_newpos = _gate getPos [6, _dir + 90];
_gun1 = objNull;
if (random 1 < 0.3) then {
    _gun1 = dep_static_gmg createVehicle _newpos;
} else {
    _gun1 = dep_static_hmg createVehicle _newpos;
};
_objects = _objects + [_gun1];
_gun1 setDir _dir;
_newpos = _newpos getPos [1, (_dir + 180)];
_gunner1 = [_campgroup, dep_u_g_soldier, _newpos] call dep_fnc_createunit;
_gunner1 assignAsGunner _gun1;
_gunner1 moveInGunner _gun1;
_gunner1 setDir _dir;
_totalenemies = _totalenemies + 1;

sleep 0.2;
_newpos = _gate getPos [4, _dir + 180];
_newpos = _newpos getPos [4, _dir  - 90];
_soldier = [_campgroup, dep_u_g_sl, _newpos] call dep_fnc_createunit;
_totalenemies = _totalenemies + 1;
doStop _soldier;
for "_c" from 1 to (1 + round (random 1)) do
{
    _newpos = (position _gate) findEmptyPosition[0, 50, dep_u_g_at];
    _soldier = [_campgroup, dep_u_g_at, _newpos] call dep_fnc_createunit;
    _soldier setDir (random 360);
    _totalenemies = _totalenemies + 1;
    doStop _soldier;

    _newpos = (position _gate) findEmptyPosition[0, 50, dep_u_g_gl];
    _soldier = [_campgroup, dep_u_g_gl, _newpos] call dep_fnc_createunit;
    _soldier setDir (random 360);
    _totalenemies = _totalenemies + 1;
    doStop _soldier;
};
[_totalenemies, _groups, _objects];