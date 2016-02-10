// by tankbuster
_myscript = "buildfob.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];

		_objectsArray = [(getpos alpha_1), (getdir alpha_1),

/*
Grab data:
Mission: fobtemplate
World: VR
Anchor position: [3645.98, 2361.83]
Area size: 30
Using orientation of objects: yes
*/

[
	["Land_FieldToilet_F",[0,0,0.00612307],180.007,1,0,[0.000460236,0.00172247],"bog","",true,false],
	["FirePlace_burning_F",[-0.00219727,-0.201416,-3.62396e-005],0,1,0,[0,0],"","",true,false],
	["rhsusf_mags_crate",[2.21924,3.38794,0],360,1,0.0153259,[0.000156239,-0.000600406],"","",true,false],
	/*["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy",[-3.88306,4.67017,-0.00918341],359.998,1,0,[-0.333659,0.550831],"","",true,false], */
	["Land_TTowerSmall_1_F",[-8.31201,0.553955,0],0,1,0,[0,0],"","",true,false],
	["Land_DieselGroundPowerUnit_01_F",[7.30054,4.28809,-0.00129604],359.995,1,0.030634,[-0.063513,0.00394806],"","",true,false],
	["Land_HelipadCircle_F",[6.26416,-5.74634,0],0,1,0,[0,0],"","",true,false],
	["Land_WaterTank_F",[-8.20972,-2.25562,-6.19888e-006],359.998,1,0,[0.000378014,0.000205475],"","",true,false],
	["Land_Sink_F",[-8.13354,-3.63403,-9.53674e-007],177.487,1,0,[-2.46548e-005,4.74659e-006],"","",true,false],
	["Land_ChairPlastic_F",[-8.05786,4.23193,1.7643e-005],267.098,1,0,[0.00275859,-0.00270494],"","",true,false],
	["Land_CampingTable_F",[-8.35815,5.60864,4.76837e-007],359.999,1,0,[-0.000469498,-3.45043e-005],"","",true,false],
	["Land_ChairPlastic_F",[-9.12988,4.33691,1.7643e-005],275.051,1,0,[0.00274875,-0.00267899],"","",true,false],
	["B_Slingload_01_Medevac_F",[-0.246582,10.6687,-2.86102e-006],270.915,1,0,[-9.1134e-005,0.000612301],"","",true,false],
	["B_Slingload_01_Repair_F",[-8.53418,-7.35498,0],132.925,1,0.0205086,[-1.95552e-006,1.91148e-005],"","",true,false],
	["RHS_Stinger_AA_pod_D",[7.40039,9.79297,-0.0780897],0.00330776,1,0,[-0.000452873,3.09457e-005],"","",true,false],
	["RHS_M2StaticMG_D",[-8.16479,9.40601,-0.0654726],359.99,1,0,[0.000477153,0.0069877],"","",true,false],
	["Land_HBarrier_Big_F",[11.8269,5.3374,0],269.869,1,0,[0,0],"","",true,false],
	["Land_HBarrier_Big_F",[-11.9976,5.68262,0],91.0961,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-2.43726,14.4045,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-6.22925,13.4766,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[3.44312,14.4951,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[6.52441,13.6885,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[11.04,10.9294,-0.000999928],237.503,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-9.2417,12.8245,-0.000999928],334.895,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-11.4836,10.9443,-0.000999928],124.35,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[9.38623,12.8301,-0.000999928],36.6133,1,0,[0,0],"","",true,false]
],0.0] call bis_fnc_ObjectsMapper;


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

/*
Grab data:
Mission: fobtemplate
World: VR
Anchor position: [3650.85, 2357.35]
Area size: 30
Using orientation of objects: yes
*/

