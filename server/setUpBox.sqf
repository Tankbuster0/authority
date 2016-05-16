// Set Up ammo box

// Clear Crate
clearweaponcargo _this;
clearmagazinecargo _this;
clearitemcargo _this;

// Init VA
["AmmoboxInit",[_this,false,true]] spawn BIS_fnc_arsenal;

BlackListMines = ["CUP_Mine_M","CUP_IED_V1_M","CUP_IED_V2_M","CUP_IED_V3_M","CUP_IED_V4_M","CUP_MineE_M","CUP_PipeBomb_M"];

// Add all relevant stuff

// Find all weapons and magazines
_weaponsList = [];
_namelist = [];
_cfgweapons = configFile >> "cfgWeapons";
for "_i" from 0 to (count _cfgweapons)-1 do {
	_weapon = _cfgweapons select _i;
	if (isClass _weapon) then {
		_wCName = configName(_weapon);
		_wDName = getText(configFile >> "cfgWeapons" >> _wCName >> "displayName");
		_wModel = getText(configFile >> "cfgWeapons" >> _wCName >> "model");
		_wType = getNumber(configFile >> "cfgWeapons" >> _wCName >> "type");
		_wPic =  getText(configFile >> "cfgWeapons" >> _wCName >> "picture");

		if ((_wCName!="") && (_wDName!="") && (_wModel!="") && 
		(_wPic!="") && !(_wCName select [0,13] isEqualTo "CUP_arifle_AK") 
		&& !(_wCName select [0,13] isEqualTo "CUP_arifle_RP")
		&& !(_wCName select [0,10] isEqualTo "arifle_Kat")
		&& !(_wCName isEqualTo "CUP_arifle_AK107_GL")) then {
			if !(_wDName in _namelist) then {
				_weaponsList pushBack _wCName;
				_namelist = _namelist + [_wDName];
			};
		};
	};
};
hint "";
_namelist=nil;

_magazinesList = [];
_namelist = [];
_cfgmagazines = configFile >> "cfgmagazines";
for "_i" from 0 to (count _cfgmagazines)-1 do {
	_magazine = _cfgmagazines select _i;
	if (isClass _magazine) then {
		_mCName = configName(_magazine);
		_mDName = getText(configFile >> "cfgmagazines" >> _mCName >> "displayName");
		_mModel = getText(configFile >> "cfgmagazines" >> _mCName >> "model");	

		if ((_mCName!="") && (_mDName!="") && (_mModel!="")) then {
			if !(_mDName in _namelist) then {
				//_magazinesList = _magazinesList + [[_mCName,_mDName,_mPic,_mDesc]];
				
				if (! (_mCName in BlackListMines)) then {
					_magazinesList pushBack _mCName;
					_namelist = _namelist + [_mDName];
				} else {};
			};
		};
	};
};
hint "";
_namelist=nil;

_backpacklist = [];
_namelist = [];
_cfgBackPacks = configFile >> "CfgVehicles";
for "_i" from 0 to (count _cfgBackPacks)-1 do {
	_magazine = _cfgBackPacks select _i;
	if (isClass _magazine) then {
		_mCName = configName(_magazine);
		_mDName = getText(configFile >> "CfgVehicles" >> _mCName >> "displayName");
		_mModel = getText(configFile >> "CfgVehicles" >> _mCName >> "model");	
		_mVehClass = getText(configFile >> "CfgVehicles" >> _mCName >> "vehicleClass");
		_faction = getText(configFile >> "CfgVehicles" >> _mCName >> "faction");

		if ((_mCName!="") && (_mDName!="") && (_mModel!="")) then {
			if !(_mDName in _namelist) then {
				if (_mVehClass isEqualTo "Backpacks" && ( (_faction isEqualTo "BLU_F")  || (_faction isEqualTo "Default"))) then {
					//_backpacklist = _backpacklist + [[_mCName,_mDName,_mPic,_mDesc]];
					_backpacklist pushBack _mCName;
					_namelist = _namelist + [_mDName];
				} else {};
			};
		};
	};
	if (_i % 10==0) then {
		//diag_log format["Loading backpack List... (%1)",count _backpacklist];
		sleep .0001;
	};
};
hint "";
_namelist=nil;

// Add the stuff
for "_i" from 0 to (count _weaponsList)-1 do {
	_weapon = _weaponsList select _i;
	[_this, _weapon] call BIS_fnc_addVirtualWeaponCargo;
};

for "_i" from 0 to (count _magazinesList)-1 do {
	_magazine = _magazinesList select _i;
	[_this, _magazine] call BIS_fnc_addVirtualMagazineCargo;
};

for "_i" from 0 to (count _backpacklist)-1 do {
	_backPack = _backpacklist select _i;
	[_this, _backPack] call BIS_fnc_addVirtualBackpackCargo;
};

[_this, true] call BIS_fnc_addVirtualItemCargo;

// BlackList stuff
// Assemble able backpacks 
// Titans
[_this,
["B_AA_01_weapon_F",
"B_AT_01_weapon_F"],true] call BIS_fnc_removeVirtualBackpackCargo;
// Vanilla MachineGuns, GMG, Mortar
[_this,
["B_GMG_01_high_weapon_F",
"B_HMG_01_A_high_weapon_F",
"B_GMG_01_A_weapon_F",
"B_GMG_01_weapon_F",
"B_HMG_01_A_weapon_F",
"B_HMG_01_weapon_F",
"B_HMG_01_high_weapon_F",
"B_Mortar_01_weapon_F",
"B_Mortar_01_support_F",
"B_HMG_01_support_high_F",
"B_HMG_01_support_F"],true] call BIS_fnc_removeVirtualBackpackCargo;
// CUP stuff
// This dont work UAV
[_this,["CUP_B_UAVTerminal_Black"],true] call BIS_fnc_removeVirtualBackpackCargo;

// weapons
// AK that slipped thorugh the cracks,/ CUP_arifle_AK107_GL seems to be every present
[_this,["CUP_arifle_AK107_GL",
"CUP_lmg_PKM",
"CUP_lmg_Pecheneg",
"CUP_srifle_SVD",
"CUP_srifle_SVD_des",
"CUP_smg_bizon"],true] call BIS_fnc_removeVirtualWeaponCargo;

// Launchers
[_this,["CUP_launch_Igla",
"launch_RPG32_F",
"CUP_launch_RPG7V",
"CUP_launch_RPG18",
"CUP_launch_9K32Strela"],true] call BIS_fnc_removeVirtualWeaponCargo;

// Explosives remove cups ones
/*[_this,["CUP_Mine_M",
"CUP_IED_V1_M",
"CUP_IED_V2_M",
"CUP_IED_V3_M",
"CUP_IED_V4_M",
"CUP_MineE_M",
"CUP_PipeBomb_M"],true] call BIS_fnc_removeVirtualMagazineCargo;
*/







