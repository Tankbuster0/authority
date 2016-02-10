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
	/*["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy",[0.716553,-2.60254,-0.0105391],359.998,1,0,[-0.335836,0.553365],"","",true,false], */
	["Land_CampingTable_F",[-3.75854,-1.66406,3.33786e-006],360,1,0,[0.000485924,-5.34585e-005],"","",true,false],
	["Land_ChairPlastic_F",[-3.45825,-3.04077,1.7643e-005],267.093,1,0,[0.00272068,-0.00271976],"","",true,false],
	["Land_ChairPlastic_F",[-4.53027,-2.93579,1.81198e-005],275.045,1,0,[0.00278545,-0.00270909],"","",true,false],
	["B_Slingload_01_Medevac_F",[4.35303,3.396,4.29153e-006],270.915,1,0,[0.000120489,1.66765e-005],"","",true,false],
	["Land_BagFence_Long_F",[2.16235,7.13184,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_HBarrier_Big_F",[-7.39795,-1.59009,0],91.0961,1,0,[0,-0],"","",true,false],
	["Land_TTowerSmall_1_F",[-3.7124,-6.71875,0],0,1,0,[0,0],"","",true,false],
	["rhsusf_mags_crate",[6.81885,-3.88477,0],360,1,0.00511263,[0.000147735,-0.000592262],"","",true,false],
	["Land_BagFence_Long_F",[-4.01538,7.22656,-0.000999928],0,1,0,[0,0],"","",true,false],
	["RHS_M2StaticMG_D",[-6.54761,5.32275,-0.0654731],359.997,1,0,[0.000488891,0.00699643],"","",true,false],
	["Land_BagFence_Long_F",[-6.79736,7.24268,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-8.354,5.53662,-0.000999928],270.952,1,0,[0,0],"","",true,false],
	["Land_WaterTank_F",[-3.61011,-9.52832,-6.67572e-006],359.999,1,0,[0.000397663,0.00019294],"","",true,false],
	["Land_BagFence_Long_F",[8.04272,7.22241,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_Sink_F",[-3.53394,-10.9067,3.8147e-006],177.488,1,0,[0.000719557,-0.00025625],"","",true,false],
	["Land_DieselGroundPowerUnit_01_F",[11.8999,-2.98462,-0.00129652],359.991,1,0.00957273,[-0.0635775,0.000338156],"","",true,false],
	["Land_BagFence_Long_F",[13.0891,7.33228,-0.000999928],0,1,0,[0,0],"","",true,false],
	["RHS_Stinger_AA_pod_D",[14.9456,6.15723,-0.128972],0.078657,1,0,[-5.25395,-2.39377],"","",true,false],
	["B_Slingload_01_Repair_F",[-5.25635,-15.3809,0],360,1,0.00679068,[-2.25848e-006,1.88333e-005],"","",true,false],
	["Land_HBarrier_Big_F",[16.4265,-1.9353,0],269.869,1,0,[0,0],"","",true,false],
	["Land_HelipadCircle_F",[10.8638,-13.019,0],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[16.0708,7.37793,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[17.489,5.69092,-0.000999928],90.2207,1,0,[0,-0],"","",true,false]
],0.0] call bis_fnc_ObjectsMapper;


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

