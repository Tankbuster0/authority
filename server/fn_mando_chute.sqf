
/*
   mando_chute.sqf v1.1
   by Mandoble. edited by tankbuster and champy

   Moves a chute to the landing position
*/

private ["_man","_chuto","_target_pos","_deg_sec","_dir","_ang","_posc","_dif","_difabs","_turn","_hspd","_max_spd","_deltatime","_timeold","_vh","_vz","_acc","_cone","_detached","_pos_man","_helper1","_rad","_is_ammo","_pos_conex"];
_helper1 = objNull;
_man = [_this, 0] call BIS_fnc_param;
_target_pos = [_this, 1] call BIS_fnc_param;
_rad = [_this, 2] call BIS_fnc_param;
_chuto = [_this, 3] call BIS_fnc_param;
_is_ammo = [_this, 4] call BIS_fnc_param;
//diag_log format ["***mando chute gets man %1, targetpos %2, rad %3, chuto %4, isammo %5", _man, _target_pos, _rad, _chuto, _is_ammo];
if (count _target_pos isEqualTo 2) then {_target_pos set [count _target_pos, 0]};
_ang = random 360;
_target_pos = if (_rad isEqualTo 0) then {
	[_target_pos select 0, _target_pos select 1, 0]
} else {
    [(_target_pos select 0) + (sin _ang) * _rad, (_target_pos select 1) + (cos _ang) * _rad, 0]
};

_deg_sec = 30;
_max_spd = 4;
_hspd = _max_spd;
_acc = 2;
_vh = 0;
_vz = -3;

_timeold = time;
_dir = getDir _chuto;
_chuto setDir _dir;
_posc = getPosASL _chuto;

//_cone = "RoadCone_F" createVehicleLocal [0,0,0];//Sign_F
_cone = "Land_ClutterCutter_small_F" createVehicleLocal [0,0,0];
_cone setDir _dir;
_cone setPosASL [_posc select 0, _posc select 1, (_posc select 2) - 2];
_posc = getPosASL _cone;
_detached = false;
sleep 1;
//diag_log format ["*** before main airborne loop, alivechuto %1, chuto altitude %2, man altitude %3", alive _chuto, ((getpos _chuto) select 2), ((getpos _man) select 2)];
while {alive _chuto && {(getPosATLVisual _chuto select 2) > 5}} do
{
	_deltatime = (time - _timeold) max 0.001;
	_timeold = time;

	_posc = getPosASL _cone;
	_ang = ((_target_pos select 0) - (_posc select 0)) atan2 ((_target_pos select 1) - (_posc select 1));
	if (([_target_pos select 0, _target_pos select 1, 0] distance [_posc select 0, _posc select 1, 0]) > (getPos _cone select 2)) then
		{
		if ((_vz + 0.5 * _deltatime) < -1.5) then
			{_vz = _vz + 0.5 * _deltatime};
		} else
		{
		if ((_vz - 0.5 * _deltatime) > -3) then
			{_vz = _vz - 0.5 * _deltatime};
		};

	_dif = _ang - _dir;
	if (_dif < 0) then {_dif = 360 + _dif};
	if (_dif > 180) then {_dif = _dif - 360};
	_difabs = abs _dif;

	_turn = if (_difabs > 0.01) then {_dif / _difabs} else {0};

	_dir = _dir + (_turn * ((_deg_sec * _deltatime) min _difabs));

	if (_vh < _hspd) then
		{
		_vh = _vh + (_acc * _deltatime);
		} else
		{
		if (_vh > _hspd) then {_vh = _vh - (_acc * _deltatime)};
		};

	_hspd = if (_difabs > 45) then {_max_spd / 3} else {_max_spd};
	_cone setDir _dir;
	_cone setVelocity [(sin _dir) * _vh, (cos _dir) * _vh, _vz];
	if (!isNull _man) then {_man setDir _dir};
	_chuto setPos (_cone modelToWorld [0,0,2]);
	_chuto setDir _dir;

	if (!_is_ammo && {!_detached} && {getposATL _man select 2 <= 4}) then
		{
		detach _man;
		_detached = true;
		_pos_man = getposATL _man;
		_helper1 = "Land_HelipadEmpty_F" createVehicleLocal [_pos_man select 0, _pos_man select 1, 0];
		_helper1 setPos [_pos_man select 0, _pos_man select 1, 0];
		_man setPos [_pos_man select 0, _pos_man select 1, 0];
		_man setVectorUp (vectorUp  _helper1);
		deleteVehicle _helper1;
		};
		if (_is_ammo && {!_detached} && {position _man select 2 <= 6}) then
		{
		//diag_log "*** is amm and not detached and z < 4. detaching";
		detach _man;
		_detached = true;
		_pos_man = position _man;
		_helper1 = "Land_HelipadEmpty_F" createVehicleLocal [_pos_man select 0, _pos_man select 1, 0];
		_helper1 setPos [_pos_man select 0, _pos_man select 1, 0];
		deleteVehicle _man;

		};

	sleep 0.01;
};
//diag_log "***mc exited main airborne loop";
//deleteVehicle _man; rdx CHAMPY
_pos_conex = [position _cone select 0,position _cone select 1,position _cone select 2];
//deleteVehicle _cone;
//deleteVehicle _chuto;
sleep 1;
if (_is_ammo) then
	{
	diag_log "*** airbox on the ground!";
	_airbox2 = createVehicle ["B_Supplycrate_F",_target_pos,[],0,"NONE"];// tanky code to create a public airdropped box
	_airbox2 addEventHandler ["killed",{deleteVehicle (_this select 0)}];
	_airbox2 setPos [_pos_man select 0, _pos_man select 1, 0];
	_airbox2 setVectorUp (vectorUp  _helper1);
	// tanky code end
	} else
	{
	if (getposATL _man select 2 <= -1) then
		{
		//diag_log "*** man on the ground";
		_pos_man = getposATL _man;
		_helper1 = "Land_HelipadEmpty_F" createVehicleLocal [_pos_man select 0, _pos_man select 1, 0];
		_helper1 setPos [_pos_man select 0, _pos_man select 1, 0];
		_man setPos [_pos_man select 0, _pos_man select 1, 0];
		_man setVectorUp (vectorUp  _helper1);
		};
	};
if (!(isnull _helper1)) then
	{deleteVehicle _helper1;};
//if (((getpos _helper1) select 0) != 0) then {deletevehicle _helper1};