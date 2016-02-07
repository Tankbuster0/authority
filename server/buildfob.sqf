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
	["Land_TTowerSmall_1_F",[0.166016,2.45923,0],0,1,0,[0,0],"","",true,false],
	/*["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy",[0.716553,-2.60254,-0.0105386],359.998,1,0,[-0.335832,0.552534],"","",true,false], */
	["Land_ChairPlastic_F",[-3.1875,-0.254639,1.7643e-005],267.093,1,0,[0.0027207,-0.00271977],"","",true,false],
	["Land_CampingTable_F",[-3.48779,1.12207,-4.29153e-006],359.999,1,0,[0.000967766,-6.3181e-006],"","",true,false],
	["Land_ChairPlastic_F",[-4.25952,-0.149658,1.81198e-005],275.045,1,0,[0.00278547,-0.00270908],"","",true,false],
	["B_Slingload_01_Medevac_F",[0.681885,5.3418,-1.43051e-006],270.915,1,0,[-0.000105824,0.000195244],"","",true,false],
	["rhsusf_mags_crate",[4.35034,-3.75684,2.86102e-006],360,1,0.00514512,[0.00109107,-0.000788948],"","",true,false],
	["Land_DieselGroundPowerUnit_01_F",[6.56372,-3.07373,-0.00125837],359.991,1,0.00992958,[-0.0607849,-0.00364446],"","",true,false],
	["Land_WaterTank_F",[-3.33936,-6.74219,-6.67572e-006],359.999,1,0,[0.000397663,0.00019294],"","",true,false],
	["Land_Sink_F",[-3.26318,-8.12061,4.76837e-006],177.487,1,0,[0.000921314,5.87735e-005],"","",true,false],
	["Land_HBarrier_Big_F",[-9.29004,-2.6853,0],274.683,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-0.581299,9.77393,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[2.34375,9.7063,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-9.03442,5.37573,-0.000999928],268.158,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[-4.68848,9.80933,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_HBarrier_Big_F",[10.7817,-3.65649,0],269.869,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[6.6687,9.56445,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[10.7666,4.87817,-0.000999928],93.6094,1,0,[0,-0],"","",true,false],
	["Land_BagFence_Long_F",[-7.65869,9.86523,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_BagFence_Long_F",[9.65039,9.65015,-0.000999928],0,1,0,[0,0],"","",true,false],
	["Land_HelipadCircle_F",[6.02588,-17.1443,0],0,1,0,[0,0],"","",true,false],
	["B_Slingload_01_Repair_F",[-5.98926,-17.564,0],360,1,0.00682937,[-6.70432e-007,2.00754e-005],"","",true,false]
],0.0] call bis_fnc_ObjectsMapper;


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];