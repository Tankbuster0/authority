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
	_wvecs = vehicles select {(([_x, true] call BIS_fnc_objectSide) isEqualTo west) and {(alive _x) and (canMove _x)}};
	_whelivtols = _wvecs select	{( ((typeof _x) isKindof  "Helicopter_Base_F") or ((typeof _x) isKindof  "VTOL_Base_F") )	};
	_whelivtols
	};
//  _mfdist = [((cpt_position distance2D _mfpos) + 24 - cpt_radius), 50] call BIS_fnc_roundNum;

tky_fnc_inHouse = // by killzonekid, modified by tankbuster (to accept pos input), returns true if indoors
	{
	//if sending pos, it must be asl
	params ["_indata"];
	private ["_pos"];
	diag_log format ["*** tfi gets %1", _indata];
	if ((typename _indata) isEqualTo "OBJECT") then
		{_pos = getPosWorld _indata}
		else
		{_pos = _indata;
		_pos set [2, (0.2 + (_pos select 2))]// raise it a tiny bit to avoid ground collision
		};
	lineIntersectsSurfaces [
		_pos,
		_pos vectorAdd [0, 0, 50],
		objNull, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	_house
	};
KKK_fnc_inHouse = {
	lineIntersectsSurfaces [
		getPosWorld _this,
		getPosWorld _this vectorAdd [0, 0, 50],
		_this, objNull, true, 1, "GEOM", "NONE"
	] select 0 params ["","","","_house"];
	if (_house isKindOf "House") exitWith {true};
	false
};

