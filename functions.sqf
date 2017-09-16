// functions by Tankbuster and others

KK_fnc_fileExists = {
    private ["_ctrl", "_fileExists"];
    disableSerialization;
    _ctrl = findDisplay 0 ctrlCreate ["RscHTML", -1];
    _ctrl htmlLoad _this;
    _fileExists = ctrlHTMLLoaded _ctrl;
    ctrlDelete _ctrl;
    _fileExists
};

tky_fnc_getscreenname =
{

	// with thanks to hoverguy and tryteyker
	private ["_suppliedtype","_type", "_cfg_type","_data", "_ret"];
	params ["_suppliedtype"];
	if ((typeName _suppliedtype) == "OBJECT") then
		{
		_type = (typeof _suppliedtype);
		}
		else
		{
		_type = _suppliedtype;
		};
	//assume classname is provided. if object is provided, get its classname
    switch (true) do
    {
        case(isClass(configFile >> "CfgMagazines" >> _type)): {_cfg_type = "CfgMagazines"};
        case(isClass(configFile >> "CfgWeapons" >> _type)): {_cfg_type = "CfgWeapons"};
        case(isClass(configFile >> "CfgVehicles" >> _type)): {_cfg_type = "CfgVehicles"};
        case(isClass(configFile >> "CfgGlasses" >> _type)): {_cfg_type = "CfgGlasses"};
    };
	_ret = getText (configFile >> _cfg_type >> _type >> "displayName");
	_ret
};

tky_fnc_hintandhqchat =
	{
	private ["_mytext"];
	params ["_mytext"];
	format ["AUTHORITY\n===========\n %1", _mytext] remoteexec ["hint", -2];
	//remoteexec []
	//[west, "HQ"] commandchat (format ["%1",_mytext]);
	//  got confused. might come back ti this :)
	};

fnc_setVehicleName =
{
	params ["_veh", "_name"];
	missionNamespace setVariable [_name, _veh, true];
	[_veh, _name] remoteExec ["setVehicleVarName", 0, _veh];
};

KK_fnc_removeUnknownUserActions = {
	for "_i" from 0 to (player addAction ["",""]) do {
		if !(_i in _this) then {
			player removeAction _i;
		};
	};
};

tky_fnc_cardinaldirection =
	{
	params ["_dir"];
	private ["_cardinaldir"];
	_cardinaldir = cardinaldirs select (([_dir, 45] call BIS_fnc_roundDir) /45);
	_cardinaldir
	};

tky_fnc_estimateddistance =
	{
	params [["_dist",0],[ "_factor", 50]];
	private ["_data1"];
	// because this rounds down, this will add half the factor to the dist
	_dist = _dist + (-1 + ( _factor /2));
	_data1 = [_dist, _factor, 10] call BIS_fnc_roundNum;

	_data1

	};
tky_fnc_fleet_armed_aircraft =
	{
	private ["_wvecs","_wvecsairarmed"];
	_wvecs = vehicles select
		{
			(([_x, true] call BIS_fnc_objectSide) isEqualTo west) and {((fuel _x) > 0.3) and (alive _x) and ((damage _x) < 0.4) and (((typeOf _x) isKindOf "Helicopter_Base_F") or ((typeOf _x) isKindOf "Plane_Base_F"))}
		};
	_wvecsairarmed = _wvecs select {((typeof _x) find "unarmed") isEqualTo -1}; // only armed vecs
	_wvecsairarmed
	};
tky_fnc_fleet_heli_vtols =
	{
	private ["_wvecs","_whelivtols"];
	_wvecs = vehicles select {(faction _x) in ["BLU_F", "BLU_T_F"] and {(alive _x) and (canMove _x)}};
	_whelivtols = _wvecs select	{( ((typeof _x) isKindof  "Helicopter_Base_F") or ((typeof _x) isKindof  "VTOL_Base_F") )	};
	_whelivtols
	};
//  _mfdist = [((cpt_position distance2D _mfpos) + 24 - cpt_radius), 50] call BIS_fnc_roundNum;

tky_fnc_inHouse = // by killzonekid, modified by tankbuster (to accept pos input), returns true if indoors
	{
	private _return = false;
	private _houseabove = false;
	//if sending pos, it must be asl
	params ["_indata"];
	private ["_pos", "_houseabove", "_wallscore"];
	private _ignoreObject = if (((typeName _indata) isEqualTo "OBJECT")) then {_indata} else {objNull};
	if ((typename _indata) isEqualTo "OBJECT") then
		{_pos = getPosWorld _indata}
		else
		{
		_pos = _indata;
		_pos set [2, (0.2 + (_pos select 2))];
		};
	//diag_log format ["*** indata  is %1 pos is %2  ignoreobj %3", _indata, _pos, _ignoreObject];
	lineIntersectsSurfaces [
		_pos,
		_pos vectorAdd [0, 0, 50],
		_ignoreObject, objNull, false, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	if ((not (isnil "_house")) and { _house isKindOf "House"})  then// i think this is right?
	{
		_houseabove = true;
	};
	_wallscore = 0;
	if (not _houseabove) then
		{
		_dirstocheck = [[2,0,0], [0,2,0], [-2,0,0], [0,-2,0]];
			{
			lineIntersectsSurfaces [
			_pos,
			_pos vectorAdd _x,
			_ignoreObject, objNull, false, 1, "GEOM", "NONE"
			] select 0 params ["","","","_house"];
			if ((not (isnil "_house")) and { _house isKindOf "House"})  then
				{
				_wallscore = _wallscore + 1;
				}
			} foreach _dirstocheck;
		};
	if ((_wallscore > 2) or (_houseabove)) then // found at least 2 walls nearby
		{_return = true};
	_return
	};

tky_fnc_distanddirfromtown =
{
	private ["_sortedtargets","_mytown","_tname","_tradius","_mydir","_mydist","_kmorm","_ret","_targets", "_pos", "_dist"];
	_pos = _this select 0;
	//takes a position and returns the nearest town/target to it
	_targets = (_pos nearEntities ["Logic", 4000]) select {((_x getVariable ["targetstatus", -1]) > -1)  };
	_sortedtargets = [_targets, [] , {_pos distance2D _x}, "ASCEND"] call BIS_fnc_sortBy;
	_mytown = _sortedtargets select 0;
	_tname = _mytown getVariable ["targetname", "Springfield"];
	_tradius = _mytown getVariable ["targetradius", 75];
	_mydir = [(_mytown getDir _pos)] call tky_fnc_cardinaldirection;
	_dist = floor (_pos distance2D _mytown);
	if (_dist < 1000) then
		{
		_mydist = [_dist, 100] call tky_fnc_estimateddistance;
		_kmorm = "m";
		}
		else
		{
		_mydist = _dist /1000;
		_mydist  = ([_mydist, 1] call BIS_fnc_cutDecimals);
		_kmorm = "km";
		};
	//diag_log format ["dist %1,mydist %2, _tname %3, _tradius %4, _kmorm %5, _mydir %6,",_dist, _mydist, _tname, _tradius, _kmorm, _mydir ];
	if (_dist < 75) then {_ret = "in the middle of " + _tname ;};
	if ( (_dist >= 75) and (_dist < _tradius ) )then {_ret = " in the "+ _mydir + "ern quarter of " + _tname;};// <<< get the town radius & the cardinal direction so we can say "in the northern quarter of"
	if (_dist >= _tradius) then {_ret = (str _mydist) + _kmorm + " " + _mydir + " of " + _tname};
	_ret
};