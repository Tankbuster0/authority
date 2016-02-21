// by tankbuster
_myscript = "buildfob.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
private ["_pos","_dir","_mypos","_testradius","_droppos","_hpad"];
params [
["_pos", ""],
["_dir", ""]];

fobjects = [_pos, _dir,
/*
Grab data:
Mission: fobtemplate
World: VR
Anchor position: [3650.27, 2360.49]
Area size: 15
Using orientation of objects: yes
*/

[
	["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy",[0.716553,-2.60254,-0.00947857],359.997,1,0,[-0.333704,0.565123],"","",true,false],
	["Flag_White_F",[0.554932,3.36157,0],0,1,0,[0,0],"","",true,false],
	["FirePlace_burning_F",[-2.91846,-3.90112,-0.030755],0,1,0,[0,0],"","",true,false],
	["Land_ToiletBox_F",[-2.83862,-4.35596,-2.00272e-005],0.0831968,1,0,[0.002059,-0.00126319],"","",true,false],
	["Land_FireExtinguisher_F",[-4.0647,-4.20898,0.000143051],359.829,1,0,[-0.0561211,0.0889441],"","",true,false],
	["rhsusf_weapons_crate",[5.74341,-4.37012,1.43051e-006],359.973,1,0.953522,[0.000670926,-0.000637796],"","",true,false],
	["Land_TTowerSmall_2_F",[0.859375,-12.6907,0],0,1,0,[0,0],"","",true,false]
] call bis_fnc_ObjectsMapper;

// find a good place nearby for helipad

_mypos = [0,0,0]; _testradius = 20;
while {_mypos in [[0,0,0], islandcentre]} do // findsafepos not found a good place yet. we use a small radius to start with because it's important to get the droppos close to reauested pos
	{
		_mypos = [_pos, 15,_testradius, 10, 0,10,0] call bis_fnc_findSafePos;
		diag_log format ["*** buildfob looking for helipad suggests %1 using radius %2 which is blacklisted %3", _mypos, _testradius, (_mypos in [[0,0,0], islandcentre])];
		_testradius = _testradius + 4;
	};
_mypos set [2,0];
_hpad = createVehicle ["Land_HelipadCircle_F", _mypos,[],0,"NONE"];
fobjects pushback _hpad;
fobdeployed = true;
publicVariable "fobdeployed";

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

