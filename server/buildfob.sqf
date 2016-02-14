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
Anchor position: [3645.98, 2361.83]
Area size: 30
Using orientation of objects: yes
*/

 [
	["Land_GamingSet_01_controller_F",[-3.13501,-0.803223,0],359.999,1,0,[-0.00159125,-0.00062277],"","",true,false],
	["Land_ToiletBox_F",[-2.15796,2.41895,7.62939e-006],0.000161926,1,0,[0.000360799,0.00068173],"","",true,false],
	["Land_CampingTable_F",[-3.53638,-0.766357,1.90735e-006],359.997,1,0,[-0.000264704,2.90498e-005],"","",true,false],
	["Land_ChairPlastic_F",[-3.19263,-2.23267,1.7643e-005],267.093,1,0,[0.0027207,-0.00271977],"","",true,false],
	["Land_Laptop_unfolded_F",[-3.98779,-0.477783,-0.139849],2.19473,1,0,[-42.8161,-180],"","",true,false],
	["Land_ChairPlastic_F",[-4.26465,-2.12769,1.81198e-005],275.045,1,0,[0.00278547,-0.00270908],"","",true,false],
	["rhsusf_mags_crate",[4.97974,-1.27979,1.90735e-006],360,1,0.00506644,[0.00121719,-0.000883828],"","clearMagazineCargoGlobal this;clearWeaponCargoGlobal this;clearItemCargoGlobal this;clearBackpackCargoGlobal this;this allowDamage false; this enableSimulation false;this addaction [""==Virtual Arsenal=="", ""server\b_virtual_arsenal.sqf""];",true,false],
	["B_Slingload_01_Medevac_F",[0.333496,7.52148,-4.76837e-007],270.914,1,0,[-1.58613e-005,8.20316e-005],"","",true,false],
	["Land_TTowerSmall_1_F",[-7.73193,-2.59326,0],0,1,0,[0,0],"","",true,false],
	["Land_FireExtinguisher_F",[5.88135,6.40796,0.000141144],359.974,1,0,[-0.0680144,0.0777159],"","",true,false],
	["Land_DieselGroundPowerUnit_01_F",[8.87354,0.391602,-0.00126696],359.99,1,0.00941018,[-0.0619115,-0.0059094],"","",true,false],
	["Land_WaterTank_F",[-7.62964,-5.40283,-6.67572e-006],359.999,1,0,[0.000397675,0.000192938],"","",true,false],
	["RHS_M2StaticMG_D",[-7.58472,6.25879,-0.0654731],359.997,1,0,[0.000488883,0.00699644],"","",true,false],
	["FirePlace_burning_F",[7.04614,6.88354,0.0307465],0,1,0,[0,0],"","",true,false],
	["Land_Sink_F",[-7.55347,-6.78125,7.62939e-006],177.489,1,0,[0.0014277,-8.62899e-005],"","",true,false],
	["Land_BagFence_Long_F",[-1.85718,11.2573,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_HBarrier_Big_F",[-11.302,-2.17871,0],91.0961,1,0,[0,-0],"","",true,false],
	["Land_HBarrier_Big_F",[11.3508,-2.66919,0],269.869,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-5.64917,10.3293,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[4.02319,11.3479,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[7.10449,10.5413,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-8.66162,9.67725,-0.000999928],334.895,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-10.9036,7.79712,-0.000999928],124.35,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[9.96631,9.68286,-0.000999928],36.6133,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[11.6201,7.78223,-0.000999928],237.503,1,0,[0,0],"","",true,false],
	["RHS_Stinger_AA_pod_D",[6.10547,-12.9614,-0.0780692],0.00432919,1,0,[-0.000822887,0.00262605],"","",true,false],
	["B_Slingload_01_Repair_F",[-5.29126,-13.6973,0],132.925,1,0.00682588,[-1.09181e-006,1.28108e-005],"","",true,false]
],0.0] call bis_fnc_ObjectsMapper;

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

