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

fnc_usefirstemptyinhintqueue =
	{
	private ["_i"];
	params ["tky_text"];
	//if (hintqueue select 0) isEqualTo "" then {(hintqueue select 0) = tky_text};
	//can this be done in a loop?
	for "_i" from 0 to 5 do
		{
		if ((hintqueue select _i) isEqualTo "") exitWith {(hintqueue select _i) = tky_text};
		};
	};

/*
example
_veh = createVehicle ["I_UAV_02_F", [24068.07,18587.05,3.19], [], 0, "NONE"];
[_veh, "uavName"] call fnc_setVehicleName;
*/