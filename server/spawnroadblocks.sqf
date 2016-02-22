//by tankbuster
_myscript = "spawnroadblocks.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_mypos","_myradius","_mypos0","_myroadarray1","_road1","_road2","_mypos2","_mname","_mkr","_myroads","_rd1","_rd2","_foreachindex","_groups", "_totalenemies", "_objects", "_campgroup"];
_currentprimarytarget = _this select 0;
roadblockgates =[];
_mypos = getPosATL _currentprimarytarget;
_myradius = _currentprimarytarget getvariable "targetradius";
if ((_currentprimarytarget getvariable "targettype" ) >2) exitWith {roadblockreturndata = [-1,-1,-1,-1,-1]};
_myroadarray1 = [];
for "_i" from 0 to 355 step 5 do
	{
	_road1 =  nil; _road2 = nil;
	_mypos2 = [_mypos, _myradius, _i] call BIS_fnc_relPos;
	_myroads = _mypos2 nearroads 15;
	if ((count _myroads) > 0) then //found a road at edge of circle
		{
		_road1 = (_myroads select 0);// call it _road1
		if ((count (roadsConnectedTo _road1)) > 1) then //_road1 actually has 2 roads connected to it ie, not a dead end
			{
			_road2 = (roadsConnectedTo _road1) select 0; // call it _road2
			_rd1 = _mypos distance _road1; _rd2 = _mypos distance _road2; // get thier distances from the centre
			if (_rd2 < (_rd1 - 10) ) then
				{
				// 2nd road it at least 10m further outside the town than the 1st one.
				_myroadarray1 pushback _road1;
				_i = _i + 10; // skip a bit around the edge to prevent getting another edgepoint nearby
				} else
				{ if (count (roadsConnectedTo _road1) > 2 ) then // try again if there's a second road piece connected to the original one.
					{
					_road3 = (roadsConnectedTo _road1) select 1;
					_rd3 = _mypos distance _road3;
					if (_rd3 < (_rd1 - 10)) then
						{
						_myroadarray1 pushback _road1;
						_i = _i +5;
						};
					};
				};
			};
		};
	};
	_groups = [];
	_totalenemies = 0;
	_objects = [];
	_campgroup = createGroup east;
{
	//--------------------roadblock script nicked from fluits dep
	private ["_pos", "_dir", "_newpos", "_prop", "_soldier", "_gate"];
	_pos    = getpos _x; // roadblock position
	_dir    = [ ( (roadsConnectedTo _x) select 0), _x] call BIS_fnc_dirTo;  // roadblock direction
	_outpos = [_x, _mypos] call BIS_fnc_dirTo;// direction away from town centre
	_groups = _groups + [_campgroup];
	_campgroup setFormDir _dir;
	_gate = "Land_BarGate_F" createVehicle _pos;
	roadblockgates pushback _gate;
	vehiclecleanup pushback _gate;

	_gate setDir _dir;
	if ((random 1) < 0.7) then
	{
	    _newpos = [_gate, 6, _dir] call BIS_fnc_relPos;
	    _newpos = [_newpos, 11, _dir - 90] call BIS_fnc_relPos;
	    _prop = "Land_Sign_WarningMilitaryArea_F" createVehicle _newpos;
	    vehiclecleanup pushback _prop;
	    _prop setDir _dir + 180;
	};
	_newpos = [_gate, 7, _dir] call BIS_fnc_relPos;
	_newpos = [_newpos, 11, _dir - 90] call BIS_fnc_relPos;
	_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir _dir;
	_newpos = [_gate, 7, _dir] call BIS_fnc_relPos;
	_newpos = [_newpos, 16, _dir - 90] call BIS_fnc_relPos;
	_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir _dir;
	_newpos = [_gate, 7, _dir] call BIS_fnc_relPos;
	_newpos = [_newpos, 3, _dir + 90] call BIS_fnc_relPos;
	_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir _dir;
	_newpos = [_gate, 7, _dir] call BIS_fnc_relPos;
	_newpos = [_newpos, 7, _dir + 90] call BIS_fnc_relPos;
	_prop = "Land_CncBarrier_stripes_F" createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir _dir;
	_newpos = [_gate, 9, _dir + 180] call BIS_fnc_relPos;
	_newpos = [_newpos, 4, _dir + 90] call BIS_fnc_relPos;
	_prop = "Land_Razorwire_F" createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir _dir;
	_newpos = [_gate, 9, _dir + 180] call BIS_fnc_relPos;
	_newpos = [_newpos, 13, _dir - 90] call BIS_fnc_relPos;
	_prop = "Land_Razorwire_F" createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir _dir;
	_newpos = [_gate, 4, _dir + 180] call BIS_fnc_relPos;
	_newpos = [_newpos, 5, _dir + 90] call BIS_fnc_relPos;
	_prop = (["Land_LampShabby_F","Land_TTowerSmall_1_F","Land_FieldToilet_F"] call BIS_fnc_selectRandom) createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir _dir;
	_newpos = [_gate, 10, _dir - 90] call BIS_fnc_relPos;
	if (random 1 > 0.5) then {
	    _prop = "Land_BagBunker_Small_F" createVehicle _newpos;
	    _prop setDir (_dir + 180);
	} else {
	    _prop = "Land_Cargo_House_V3_F" createVehicle _newpos;
	    _prop setDir (_dir - 90);
	};
	_newpos = (position _gate) findEmptyPosition[0, 30, "Box_East_Ammo_F"];
	_prop = (["Box_East_Ammo_F", "Box_East_WpsSpecial_F", "Box_East_Ammo_F"] call BIS_fnc_selectRandom) createVehicle _newpos;
	vehiclecleanup pushback _prop;
	_prop setDir (_dir + 90);
	sleep 0.02;
	_newpos = [_gate, 6, _dir + 90] call BIS_fnc_relPos;
	_gun1 = objNull;
	if (random 1 < 0.3) then {
	    _gun1 = "rhs_btr80_msv" createVehicle _newpos;
	} else {
	    _gun1 = "rhs_bmd2m" createVehicle _newpos;
	};
	vehiclecleanup pushback _gun1;
	_objects = _objects + [_gun1];
	_gun1 setDir _outpos;
	_newpos = [_newpos, 1, (_dir + 180)] call BIS_fnc_relPos;
	_gunner1 = _campgroup createUnit ["O_G_Soldier_F", _newpos, [],0,"NONE"];
	_gunner1 assignAsGunner _gun1;
	_gunner1 moveInGunner _gun1;
	_gunner1 setDir _outpos;
	_totalenemies = _totalenemies + 1;
	sleep 0.2;
	_newpos = [_gate, 4, _dir + 180] call BIS_fnc_relPos;
	_newpos = [_newpos, 4, _dir  - 90] call BIS_fnc_relPos;
	_soldier = _campgroup createUnit ["O_G_Soldier_SL_F", _newpos, [],0,"NONE"];
	_totalenemies = _totalenemies + 1;
	doStop _soldier;
	for "_c" from 1 to (1 + round (random 1)) do
	{
	    _newpos = (position _gate) findEmptyPosition [0, 50, "O_G_Soldier_LAT_F"];
	    _soldier = _campgroup createUnit ["O_G_Soldier_LAT_F", _newpos, [],0, "NONE"];
	    mancleanup pushback _soldier;
	    _soldier setDir (random 360);
	    _totalenemies = _totalenemies + 1;
	    doStop _soldier;
	    _newpos = (position _gate) findEmptyPosition[0, 50, "O_G_Soldier_GL_F"];
	    _soldier = _campgroup createUnit ["O_G_Soldier_GL_F", _newpos, [],0,"NONE"];
	    mancleanup pushback _soldier;
	    _soldier setDir (random 360);
	    _totalenemies = _totalenemies + 1;
	    doStop _soldier;
	};
} foreach _myroadarray1;
roadblockreturndata = [_totalenemies, _groups, _objects, _campgroup, (count _myroadarray1)];
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];