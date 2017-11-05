// global_variable.includes
//by tankbuster.
islandcentre = getarray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
publicVariable "islandcentre";
mission_root = str missionConfigFile;
mission_root = [mission_root, 0, -15] call BIS_fnc_trimString;
publicVariable "mission_root";
debugendmission = false;
testservernames = ["Tanky-Test", "Tanky test"];
opfor_planes = ["O_Plane_CAS_02_F", "I_Plane_Fighter_04_F","O_Plane_Fighter_02_Stealth_F", "I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_04_F","C_Plane_Civil_01_racing_F" ]; //doesnt include "O_T_VTOL_02_infantry_F"
opfor_helis = ["O_Heli_Light_02_F", "O_Heli_Light_02_v2_F","O_Heli_Attack_02_F", "O_Heli_Attack_02_black_F", "O_Heli_Transport_04_covered_F", "I_Heli_Transport_02_F", "I_Heli_light_03_F"];
opfor_reinf_truck_soldier = "O_Soldier_GL_F";
opfor_reinf_truck =  "O_Truck_03_transport_F";
islandhop = false; publicVariable "islandhop";
recoveryinuse = false; publicVariable "recoveryinuse";
missionactive = false; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
opfor_reinf_helos = ["O_Heli_Light_02_F","O_Heli_Transport_04_covered_F"];
smmissionstring = "There is currently no Secondary Mission"; publicVariable "smmissionstring";
typeselected = "none"; publicVariable "typeselected";
startrlbaction = false; publicVariable "startrlbaction";
airdropcounter = 0;
prizecounter = 0;
switch (tolower worldName) do
	{
		case "altis" :
			{
			forwardpointvehicleclassname = "B_LSV_01_armed_F";
			fobvehicleclassname = "B_MRAP_01_F";
			opforpatrollandvehicles = ["O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F", "O_LSV_02_armed_F"];
			opforstaticlandvehicles =["O_APC_Tracked_02_AA_ghex_F", "O_APC_Tracked_02_cannon_ghex_F"];
			opfortanks = ["O_MBT_02_cannon_F"];
			opforhqtypes = ["O_Truck_03_covered_F", "Land_Cargo_House_V4_F"];
			};
		case "tanoa" :
			{
			forwardpointvehicleclassname = "B_T_LSV_01_armed_F";
			fobvehicleclassname = "B_MRAP_01_F";
			opforpatrollandvehicles = ["O_T_APC_Tracked_02_cannon_ghex_F", "O_T_APC_Wheeled_02_rcws_ghex_F", "O_T_MRAP_02_gmg_ghex_F", "O_T_MRAP_02_hmg_ghex_F", "O_T_LSV_02_armed_F"];
			opforstaticlandvehicles =["O_T_APC_Tracked_02_AA_ghex_F", "O_T_APC_Tracked_02_cannon_ghex_F"];
			opfortanks = ["O_T_MBT_02_cannon_ghex_F"];
			opforhqtypes = ["O_T_Truck_03_covered_ghex_F", "Land_Cargo_House_V4_F"];
			};
	};
cpt_name = "None";
publicVariable "fobvehicleclassname";
publicVariable "forwardpointvehicleclassname";
blufordropaircraft = "B_T_VTOL_01_vehicle_F"; publicVariable "blufordropaircraft";
cardinaldirs = ["north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest", "north"]; publicVariable "cardinaldirs";
fobvehrespawncounter = 0;
// Variables for HeartandMind SideMission calc
heartandmindscore = 0;
civkillcount = 0;
reinforcementcounter = 0;
captivekillcounter = 0;
blueflags = [];
pt_hq_alive = true;
pt_radar_alive = true;
deadgatecount = 0;
roadblockgates = [];
roadblockscleared = false;

// CQB Arrs
// CQB Center Troops
opfor_CQB_soldier = ["O_Soldier_TL_F","O_soldierU_exp_F","O_SoldierU_GL_F","O_soldierU_M_F","O_soldierU_TL_F","O_SoldierU_GL_F","O_SoldierU_GL_F","O_soldierU_exp_F"];
opfor_CQB_Outskirt = ["O_recon_M_F","O_ghillie_sard_F","O_Soldier_GL_F","O_spotter_F","O_recon_TL_F"];
opfor_CQB_Pattio = ["O_Soldier_GL_F","O_HeavyGunner_F","O_Soldier_AR_F"];
opfor_heli_cargomen =["O_T_Recon_TL_F","O_V_Soldier_LAT_ghex_F","O_T_Recon_LAT_F", "O_V_Soldier_ghex_F", "O_T_Sniper_F", "O_T_Sniper_F","O_V_Soldier_ghex_F","O_V_Soldier_ghex_F"];

// Cleanup array of CQB
CQBCleanupArr = [];
boatspawnobjs = ["pierconcrete_01_steps_f.p3d","pierconcrete_01_4m_ladders_f.p3d", "pierwooden_02_ladder_f.p3d", "pierwooden_01_dock_f.p3d", "pierwooden_01_hut_f.p3d","pierwooden_03_f.p3d","canal_dutch_01_stairs_f.p3d" "pier_small_f.p3d","canal_wall_stairs_f.p3d", "pier_addon_f.p3d"];
// Prizes for Prim Targets
prizes = ["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_T_APC_Tracked_01_AA_F","B_MBT_01_cannon_F","B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F" ,
"B_Plane_CAS_01_F", "B_Heli_Transport_01_camo_F","B_Heli_Light_01_armed_F","B_Heli_Transport_03_F", "B_Heli_Attack_01_F", "B_T_VTOL_01_armed_F", "B_Plane_Fighter_01_F"];
//prizes = ["B_Plane_CAS_01_F", "B_Heli_Transport_01_camo_F","B_Heli_Light_01_armed_F","B_Heli_Transport_03_F", "B_Heli_Attack_01_F", "B_T_VTOL_01_armed_F"];
allbluvehicles = prizes + [fobvehicleclassname, forwardpointvehicleclassname, "B_Quadbike_01_F", "B_T_APC_Tracked_01_CRV_F", "B_APC_Tracked_01_CRV_F", "B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_black_F", "B_Heli_Transport_03_unarmed_green_F"];
publicVariable "allbluvehicles";
// List of useable landmines
aplandmines = ["APERSBoundingMine", "APERSMine" ]; // <--vanilla from weapons/explosives
seamines =["UnderwaterMine", "UnderwaterMineAB", "UnderwaterMinePDM"];// moored, bottom , surface
civs = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F",
	   "C_man_polo_3_F_afro","C_man_polo_3_F_euro","C_man_polo_3_F_asia","C_man_polo_4_F","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","C_man_polo_5_F_afro","C_man_polo_5_F_euro",
	   "C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F","C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia",
	   "C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro",
	   "C_man_p_shorts_1_F_asia","C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F","C_man_shorts_2_F_afro","C_man_shorts_2_F_euro","C_man_shorts_2_F_asia",
	   "C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro","C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro","C_man_shorts_4_F_euro","C_man_shorts_4_F_asia"];// all the civs apart from named and story related ones

civcars = ["C_Offroad_01_F", "C_Offroad_02_unarmed_F","C_Quadbike_01_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_SUV_01_F", "C_Truck_02_transport_F", "C_Truck_02_covered_F", "C_Van_02_transport_F", "C_Van_02_vehicle_F"];
civsmallcars = ["C_Offroad_01_F", "C_Offroad_02_unarmed_F","C_Quadbike_01_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F","C_SUV_01_F"];
opforradartypes = ["Land_Radar_Small_F"];
hintqueue = ["","","","","","", "", "","", ""];
opforairsupporttypes = ["O_Heli_Light_02_F", "O_Heli_Light_02_F", "O_T_VTOL_02_infantry_F", "O_Heli_Attack_02_F", "O_Plane_CAS_02_F", "O_Plane_Fighter_02_F"];
huroncontainertypes =  ["B_Slingload_01_Ammo_F", "B_Slingload_01_Cargo_F", "B_Slingload_01_Fuel_F", "B_Slingload_01_Medevac_F", "B_Slingload_01_Repair_F"];
blufortrucktypes = [["B_Truck_01_box_F","B_Truck_01_covered_F", "B_Truck_01_transport_F"], ["I_C_Van_01_transport_brown_F", "I_C_Van_01_transport_olive_F"], ["C_Van_01_transport_white_F", "C_Van_01_box_red_F", "C_Van_01_transport_red_F", "C_Van_01_box_white_F"], ["C_IDAP_Truck_02_F", "C_IDAP_Van_02_transport_F", "C_IDAP_Van_02_vehicle_F", "C_IDAP_Truck_02_transport_F", "C_IDAP_Truck_02_water_F"]];

aaccomposition = [
	["Land_HelipadCircle_F",[106.138,18.7334,0],0,1,0,[0.763851,7.67037],"","",true,false],
	["Land_BagBunker_Large_F",[26.9893,-115.696,-0.0723171],322.314,1,0,[8.16878,-1.09966],"","",true,false],
	["Land_HelipadCircle_F",[123.296,48.0117,0.000209808],0,1,0,[1.06935,3.66254],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[123.25,48.251,-0.0628223],294.47,1,0,[3.90467,-0.826065],"","",true,false],
	["Land_HelipadCircle_F",[139.813,70.2412,0],0,1,0,[6.6921,1.61488],"","",true,false],
	["O_Heli_Light_02_F",[141.061,67.874,-0.317122],322.108,1,0,[8.64723,1.95406],"","",true,false],
	["Land_i_Barracks_V1_F",[-12.8525,190.463,0],305.446,1,0,[0,0],"","",true,false],
	["Land_HelipadCircle_F",[163.164,107.263,1.90735e-006],0,1,0,[2.44312,0.535335],"","",true,false],
	["O_Heli_Attack_02_F",[164.203,106.499,-0.381065],316.619,1,0,[6.15434,-0.181899],"","",true,false],
	["Windsock_01_F",[138.371,193.98,0.000293732],0,1,0,[0,0],"","",true,false],
	["ContainmentArea_01_sand_F",[132.301,212.78,-0.0484409],211.289,1,0,[1.03278,0.359714],"","",true,false],
	["StorageBladder_01_fuel_forest_F",[132.202,212.896,-0.000579834],30.3412,1,0,[-1.03858,-0.342582],"","",true,false],
	["O_Truck_02_fuel_F",[136.939,220.049,0.043047],121.643,1,0,[0.178268,0.0607311],"","",true,false],
	["O_Truck_02_fuel_F",[141.04,225.385,0.0524292],125.246,1,0,[0.0729474,-0.765886],"","",true,false],
	["O_T_VTOL_02_vehicle_F",[114.397,248.326,-0.182419],325.145,1,0,[3.99541,-0.239035],"","",true,false],
	["Land_HelipadCircle_F",[97.0176,271.803,0],0,1,0,[-0.228997,0.151949],"","",true,false],
	["Land_Wreck_BMP2_F",[20.4365,294.771,0.0716591],0,1,0,[1.52752,3.6632],"","",true,false],
	["O_Truck_02_fuel_F",[226.103,199.555,0.044363],173.577,1,0,[-0.103712,0.067147],"","",true,false],
	["O_Plane_CAS_02_F",[142.465,283.059,-0.286406],116.393,1,0,[0.0331826,-0.239177],"","",true,false],
	["O_Plane_CAS_02_F",[258.51,186.508,-0.286814],233.191,1,0,[-0.198542,-0.137437],"","",true,false],
	["Land_HelipadCircle_F",[242.721,210.141,0],0,1,0,[0.151948,-0.076617],"","",true,false],
	["O_Plane_CAS_02_F",[275.501,212.478,-0.287788],218.727,1,0,[-0.429017,0.0471642],"","",true,false],
	["O_Truck_02_transport_F",[124.614,325.696,0.0161381],116.627,1,0,[0.0329077,-0.204903],"","",true,false],
	["Land_BagBunker_Small_F",[257.51,236.387,-0.00294876],0,1,0,[0.30519,-0.0766178],"","",true,false],
	["Land_Cargo_Tower_V1_No1_F",[179.239,307.16,0],326.702,1,0,[0,0],"","",true,false],
	["O_Truck_02_fuel_F",[130.758,330.347,0.0448475],122.056,1,0,[-0.0594779,-0.13136],"","",true,false],
	["Land_LampAirport_F",[285.452,230.627,-0.000343323],0,1,0,[0,0],"","",true,false]
];
abderacomposition = [
	["O_Truck_02_transport_F",[39.8223,22.0195,0.0717316],327.707,1,0,[-0.360478,-0.833786],"","",true,false],
	["O_Truck_02_fuel_F",[48.4814,24.5586,0.0364666],325.219,1,0,[-0.381948,-0.277372],"","",true,false],
	["O_Truck_02_fuel_F",[-32.8154,59.457,0.0510788],144.283,1,0,[0.812499,-0.141882],"","",true,false],
	["O_Truck_02_fuel_F",[-39.0146,56.6602,0.044445],146.312,1,0,[1.33324,-0.344837],"","",true,false],
	["O_Heli_Light_02_F",[55.7266,41.7188,-0.3253],294.545,1,0,[0.0825811,0.631407],"","",true,false],
	["Land_HelipadCircle_F",[56.0938,42.0195,0],0,1,0,[-0.305187,0],"","",true,false],
	["StorageBladder_01_fuel_forest_F",[-47.9453,51.2773,0.000495911],240.594,1,0,[0.412574,0.731992],"","",true,false],
	["ContainmentArea_01_forest_F",[-48.2422,51.1309,-0.0491343],238.773,1,0,[0.43562,0.718517],"","",true,false],
	["Windsock_01_F",[-20.6621,67.5801,0.000440598],0,1,0,[0,0],"","",true,false],
	["O_Plane_CAS_02_F",[-65.3691,39.8008,-0.282625],141.847,1,0,[1.02054,0.557782],"","",true,false],
	["Land_LampAirport_F",[-42.7041,64.2871,0],0,1,0,[0,0],"","",true,false],
	["O_Plane_CAS_02_F",[-83.3984,24.2637,-0.285616],139.661,1,0,[-0.584145,-0.806769],"","",true,false],
	["O_Truck_02_transport_F",[-96.5635,-4.12891,0.0850849],90.0997,1,0,[-1.66803,-1.41215],"","",true,false],
	["O_Truck_02_transport_F",[-96.5342,-11.5723,0.0758171],90.6319,1,0,[-1.81114,-1.28078],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.428,-6.58203,0.0327854],359.982,1,0,[-1.22221,2.82387],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.514,-8.49023,0.032795],359.982,1,0,[-1.22224,2.82385],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.655,-10.4648,0.0328808],359.985,1,0,[-1.22313,2.82399],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.613,-12.7559,0.034935],359.993,1,0.0041993,[-0.282007,1.60623],"","",true,false],
	["Box_IND_AmmoVeh_F",[-105.73,-4.45898,0.0335197],359.969,1,0,[-2.06159,2.82377],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.131,-6.64648,0.0328617],359.982,1,0,[-1.22224,2.82382],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.218,-8.55469,0.0328941],359.994,1,0.00418754,[-1.22174,2.82485],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.357,-10.5293,0.0311947],0.00817988,1,0,[-0.00011252,1.60445],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.315,-12.8203,0.0355129],0.0118727,1,0.00607929,[-0.321389,1.60765],"","",true,false],
	["Land_Airport_01_controlTower_F",[-32.0117,106.676,0],326.272,1,0,[1.0179,1.52448],"","",true,false],
	["Land_BagBunker_Small_F",[100.525,75.6563,0.027071],0,1,0,[-2.67181,0.917626],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-134.124,-34.9824,-0.510679],324.69,1,0,[4.57287,0.0875166],"","",true,false],
	["Land_HelipadCircle_F",[-135.376,-32.6211,4.3869e-005],0,1,0,[0.382043,0.228998],"","",true,false],
	["O_Truck_02_covered_F",[-137.464,-52.541,0.0700035],130.245,1,0,[0.106754,0.100125],"","",true,false],
	["O_Truck_02_covered_F",[-141.824,-56.8438,0.0699711],128.243,1,0,[0.121105,-0.0232019],"","",true,false],
	["Land_Cargo20_light_green_F",[-149.799,-44.1582,0.00126457],223.275,1,0,[-1.37086,1.12245],"","",true,false],
	["O_MRAP_02_F",[-145.977,-63.2715,0.0184822],124.905,1,0,[0.0694854,-1.61784],"","",true,false],
	["Land_Cargo20_cyan_F",[-153.53,-48.957,-0.0094986],216.906,1,0,[1.48116,1.21881],"","",true,false],
	["Land_Cargo40_yellow_F",[-155.625,-59.041,-0.0202179],221.727,1,0,[-1.46924,1.31171],"","",true,false],
	["Land_Cargo_Tower_V1_No1_F",[85.0098,146.002,0],326.702,1,0,[0,0],"","",true,false],
	["Land_Wreck_BMP2_F",[127.075,129.035,-0.00849247],0,1,0,[-1.29845,0],"","",true,false],
	["Land_Wreck_BRDM2_F",[230.077,10.8496,-0.0233746],0,1,0,[-1.37473,-1.98601],"","",true,false],
	["Land_BagBunker_Large_F",[-151.681,-208.986,0.00858688],322.645,1,0,[-0.835742,0.541573],"","",true,false]
];
almyracomposition = [
	["Windsock_01_F",[43.8164,-4.88672,3.29018e-005],0,1,0,[0,0],"","",true,false],
	["Land_Airport_01_controlTower_F",[57.6855,-22.6836,0],92.1185,1,0,[0,-0],"","",true,false],
	["Land_LampAirport_F",[61.4395,5.03906,-5.91278e-005],0,1,0,[0,0],"","",true,false],
	["O_Truck_02_fuel_F",[-72.8574,50.1758,0.043644],268.894,1,0,[-0.0356887,-0.0219181],"","",true,false],
	["O_Plane_CAS_02_F",[-92.7676,8.27344,-0.286222],90.287,1,0,[0,-0],"","",true,false],
	["O_Plane_CAS_02_F",[-94.9629,-40.7695,-0.286222],90.287,1,0,[0,-0],"","",true,false],
	["Land_LampAirport_F",[-107.488,-17.1816,0],0,1,0,[0,0],"","",true,false],
	["Land_TentHangar_V1_F",[-116.482,7.45313,0],90.548,1,0,[0,-0],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-114.531,39.6563,0.00472045],87.0878,1,0,[0.0887142,0.00402614],"","",true,false],
	["O_Heli_Light_02_F",[74.7773,95.918,-0.323184],129.293,1,0,[0.394459,0.354683],"","",true,false],
	["Land_TentHangar_V1_F",[-116.482,-39.0684,0],90.548,1,0,[0,-0],"","",true,false],
	["O_Plane_CAS_02_F",[-39.8398,119.707,-0.284737],90,1,0,[0,-0],"","",true,false],
	["C_Heli_light_01_red_F",[-112.414,70.7637,-0.788926],89.7,1,0,[0,0],"","",true,false],
	["Land_Wreck_BRDM2_F",[122.553,68.6348,0.020782],0,1,0,[0,0],"","",true,false],
	["O_Truck_02_fuel_F",[-74.6895,134.588,0.0432806],270.25,1,0,[-0.0357209,-0.0222364],"","",true,false],
	["O_Heli_Light_02_F",[74.6133,135.619,-0.514169],155.999,1,0,[4.16036,0.0524877],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-116.365,114.494,-0.788923],92.9401,1,0,[0,-0],"","",true,false],
	["O_Plane_CAS_02_F",[-38.9785,170.313,-0.28541],90,1,0,[0,-0],"","",true,false],
	["O_Heli_Light_02_F",[78.998,175.607,-0.514153],155.945,1,0,[4.16024,0.054269],"","",true,false],
	["O_Truck_02_transport_F",[-82.7129,199.211,0.0694757],157.746,1,0,[-0.00598753,0.0188389],"","",true,false],
	["O_Truck_02_transport_F",[91.0195,212.795,0.0690374],90.5964,1,0,[-0.00598597,0.0196373],"","",true,false],
	["Box_IND_AmmoVeh_F",[85.084,231.057,0.030544],359.998,1,0.00547732,[0.000715956,-0.000721139],"","",true,false],
	["Box_IND_AmmoVeh_F",[87.7871,231.121,0.030544],359.998,1,0.00545131,[0.00068342,-0.000700463],"","",true,false],
	["Box_IND_AmmoVeh_F",[85.043,233.352,0.0305355],359.996,1,0,[0.000312119,-0.00103775],"","",true,false],
	["Box_IND_AmmoVeh_F",[87.7461,233.416,0.0305417],359.998,1,0.00518068,[0.000973182,-0.000958587],"","",true,false],
	["Box_IND_AmmoVeh_F",[85.1836,235.326,0.0305402],359.997,1,0.00498653,[0.000731137,-0.00129819],"","",true,false],
	["Box_IND_AmmoVeh_F",[87.8867,235.391,0.0305355],359.996,1,0,[0.000315855,-0.00103339],"","",true,false],
	["Land_Wreck_BMP2_F",[-123.684,218.467,0.020782],0,1,0,[0,0],"","",true,false],
	["Box_IND_AmmoVeh_F",[85.2695,237.234,0.0305393],359.998,1,0.00392548,[0.000142302,-0.000549269],"","",true,false],
	["Box_IND_AmmoVeh_F",[87.9727,237.299,0.0305355],359.996,1,0,[0.000311867,-0.00102806],"","",true,false],
	["Box_IND_AmmoVeh_F",[85.6699,239.422,0.0305393],359.998,1,0.00380404,[-4.82833e-005,-0.000511167],"","",true,false],
	["O_Truck_02_transport_F",[94.8438,239.754,0.0690432],90.0567,1,0,[-0.0059803,0.0195684],"","",true,false],
	["O_MRAP_02_F",[98.4141,280.283,0.0173485],124.898,1,0,[0.0930779,-0.0674636],"","",true,false],
	["O_Truck_02_covered_F",[102.566,286.705,0.0695701],128.245,1,0,[-0.00594467,0.0190825],"","",true,false],
	["Land_Cargo20_cyan_F",[90.8613,294.586,3.33786e-006],216.882,1,0,[-0.000155806,-1.05413e-005],"","",true,false],
	["O_Truck_02_covered_F",[106.924,291.012,0.0695701],130.244,1,0,[-0.00592909,0.0188387],"","",true,false]
];
ferescomposition = [
	["O_Heli_Attack_02_F",[-21.7285,-61.2485,-0.499146],36.0262,1,0,[2.39412,1.11083],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-58.1602,-31.4751,-0.299498],37.5082,0.999999,0,[2.62054,1.04248],"","",true,false],
	["O_Truck_02_fuel_F",[-87.3926,3.77637,0.0693855],30.1272,1,0,[-3.90584,-0.244858],"","",true,false],
	["O_Truck_02_transport_F",[-49.4453,76.1406,0.0799313],130.266,1,0,[-2.22786,-1.50135],"","",true,false],
	["O_Truck_02_fuel_F",[-92.5801,6.80762,0.112064],30.1365,1,0,[-4.347,-0.375413],"","",true,false],
	["O_Plane_CAS_02_F",[-41.3125,90.0674,-0.287237],299.998,1,0,[-0.372177,0.49066],"","",true,false],
	["O_Plane_CAS_02_F",[-23.6523,105.147,-0.282288],299.993,1,0,[1.1381,-0.13741],"","",true,false],
	["O_Truck_02_covered_F",[-108.094,16.7349,0.0752487],51.4093,1,0,[-4.67033,-0.120333],"","",true,false],
	["O_Plane_CAS_02_F",[-2.3125,121.465,-0.276093],300.074,1,0,[2.10827,2.45531],"","",true,false],
	["Box_IND_AmmoVeh_F",[-118.693,26.6958,0.0489502],359.975,1,0.00716227,[-5.3373,2.16986],"","",true,false],
	["Box_IND_AmmoVeh_F",[-118.553,28.6558,0.0364342],359.996,1,0.00408736,[-4.42514,2.13922],"","",true,false],
	["Box_IND_AmmoVeh_F",[-118.469,30.564,0.0364933],359.997,1,0.00407237,[-4.42389,2.13941],"","",true,false],
	["Box_IND_AmmoVeh_F",[-121.273,28.5933,0.0565357],0.0315076,1,0.00837919,[-5.78278,2.34601],"","",true,false],
	["Box_IND_AmmoVeh_F",[-121.17,30.4995,0.0363655],359.996,1,0,[-4.42243,2.13754],"","",true,false],
	["Box_IND_AmmoVeh_F",[-120.77,32.6787,0.0445271],0.0139801,1,0.00673903,[-3.81103,2.13661],"","",true,false],
	["Windsock_01_F",[-138.24,7.39893,0.00202179],0,1,0,[0,0],"","",true,false],
	["O_Truck_02_transport_F",[-132.537,69.2817,0.123629],128.214,1,0,[2.27743,-2.81632],"","",true,false],
	["Windsock_01_F",[-145.68,54.8486,0.00440025],0,1,0,[0,0],"","",true,false],
	["Land_Wreck_BRDM2_F",[-117.813,105.424,-0.0580921],0,1,0,[-2.4432,-2.90313],"","",true,false],
	["Land_Wreck_BMP2_F",[-76.9316,148.053,0.0259361],0,1,0,[-0.764127,-4.65024],"","",true,false],
	["Land_LampAirport_F",[-158.838,58.9468,0],171.175,1,0,[0,-0],"","",true,false],
	["Land_LampAirport_F",[-203.287,-65.4473,0],0,1,0,[0,0],"","",true,false]
];

moloscomposition = [
	["O_Plane_CAS_02_F",[-80.6563,-50.9492,-0.274382],155.125,1,0,[2.85657,-0.735189],"","",true,false],
	["Land_Wreck_BMP2_F",[-112.895,-17.2773,-0.224667],0,1,0,[-6.01298,-3.37601],"","",true,false],
	["O_Plane_CAS_02_F",[-99.1836,-59.3027,-0.277388],155.149,1,0,[2.96131,1.49123],"","",true,false],
	["O_Plane_CAS_02_F",[-120.143,-68.5273,-0.27459],155.149,1,0,[2.96131,1.49123],"","",true,false],
	["Land_Wreck_BRDM2_F",[-152.969,-3.88477,0.406794],0,1,0,[14.6457,9.62061],"","",true,false],
	["O_Heli_Light_02_F",[-104.354,-118.078,-0.312763],307.185,1,0,[-0.942659,1.3417],"","",true,false],
	["Land_HelipadCircle_F",[-105.119,-117.908,0],0,1,0,[-1.8328,-0.152029],"","",true,false],
	["O_Truck_02_transport_F",[-145.656,-80.4805,0.0760002],90.0635,1,0,[-0.156356,-2.38258],"","",true,false],
	["O_Truck_02_covered_F",[-156,-60.9277,0.0812302],130.203,1,0,[2.33035,-1.01581],"","",true,false],
	["Land_LampAirport_F",[-163.246,-45.5156,0.0169506],0,1,0,[0,0],"","",true,false],
	["O_Truck_02_transport_F",[-145.629,-87.9219,0.0634518],90.5988,1,0,[0.499783,-0.911793],"","",true,false],
	["O_Truck_02_covered_F",[-160.359,-65.2324,0.0739212],128.215,1,0,[2.02486,-0.639372],"","",true,false],
	["Box_IND_AmmoVeh_F",[-152.527,-82.9453,0.0193329],359.966,1,0.00556745,[-1.91247,-0.22846],"","",true,false],
	["Box_IND_AmmoVeh_F",[-152.613,-84.8418,0.0306549],359.997,1,0,[-0.687391,-0.23039],"","",true,false],
	["Box_IND_AmmoVeh_F",[-152.758,-86.8164,0.0346222],0.00224861,1,0.00563479,[-0.983677,-0.224185],"","",true,false],
	["Box_IND_AmmoVeh_F",[-155.229,-83.0117,0.0201378],0.0334162,1,0.00528144,[-1.82545,-0.069883],"","",true,false],
	["Box_IND_AmmoVeh_F",[-155.316,-84.9063,0.0329514],0.0377362,1,0.00495755,[-0.873537,0.0289168],"","",true,false],
	["Box_IND_AmmoVeh_F",[-155.457,-86.8809,0.0307674],359.997,1,0,[-0.993076,0.0753543],"","",true,false],
	["Land_Cargo20_cyan_F",[-172.078,-57.3574,0.0272083],216.884,1,0,[1.01682,0.242413],"","",true,false],
	["Land_Cargo40_yellow_F",[-177.115,-62.3379,-0.00559044],221.789,1,0,[3.27852,-0.628624],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-131.668,-149.215,-0.32061],307.219,1,0,[-1.20547,1.21661],"","",true,false],
	["Land_HelipadCircle_F",[-131.365,-151.135,0],0,1,0,[-1.75658,-0.687888],"","",true,false],
	["Windsock_01_F",[-172.641,-117.252,0.00419426],0,1,0,[0,0],"","",true,false],
	["O_Truck_02_fuel_F",[-180.295,-172.031,0.0718479],39.8011,1,0,[0.633993,-2.82812],"","",true,false],
	["O_Truck_02_fuel_F",[-162.969,-192.512,0.0498848],39.8504,1,0,[0.996838,-2.50578],"","",true,false],
	["Land_LampAirport_F",[-235.518,-164.662,0],0,1,0,[0,0],"","",true,false],
	["Land_u_Shed_Ind_F",[-209.4,-200.521,0.0594063],130,1,0,[0,-0],"","",true,false],
	["Land_Shed_Big_F",[-192.328,-206.357,0.0636578],220,1,0,[0,0],"","",true,false],
	["Land_i_Shed_Ind_F",[-230.998,-183.521,0.0666714],130,1,0,[0,-0],"","",true,false],
	["Land_ReservoirTank_Airport_F",[-271.477,-143.178,0.00749207],0,1,0,[0,0],"","",true,false]
];
/*
Grab data:
Mission: AAC_blubase
World: Altis
Anchor position: [11461, 11661]
Area size: 400
Using orientation of objects: yes
*/
AAC_blubase =
[
	["Land_Cargo_House_V1_F",[53.7969,141.576,-0.00670052],303.636,1,0,[1.92637,-1.65363],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[65.1221,139.681,2.47955e-005],303.679,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[44.9307,148.286,0.00561523],122.812,1,0,[-0.556485,1.00445],"","",true,false],
	["Land_New_WiredFence_10m_F",[54.6689,149.652,0.618752],30.5823,1,0,[0,0],"","",true,false],
	["Land_HelipadSquare_F",[82.7822,138.895,0],294.756,1,0,[1.01865,-0.203069],"blubasehelipad","",true,false],
	["Land_Net_Fence_Gate_F",[59.0225,156.357,-0.111502],303.679,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[68.6475,153.051,-0.083807],122.836,1,0,[0,-0],"","",true,false],
	["Land_Medevac_house_V1_F",[50.9297,158.099,0],303.324,1,0,[0,0],"blubasehospital","",true,false],
	["Land_New_WiredFence_5m_F",[57.8135,154.777,0.142902],303.679,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[60.5723,158.812,0.440071],34.4126,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[73.9795,152.846,2.28882e-005],303.679,1,0,[0,0],"","",true,false],
	["RoadCone_F",[78.2822,151.451,4.3869e-005],0.00635934,1,0.00995299,[0.494112,0.387547],"terminalcone","",true,false],
	["MapBoard_altis_F",[68.1553,159.072,0.000909805],154.055,1,0,[-2.00812,-0.838235],"blubasewhiteboard","",true,false],
	["RoadCone_L_F",[67.3535,162.865,0.00304604],359.987,1,0,[1.3823,1.60862],"ammoboxcone","",true,false],
	["Land_BagBunker_Small_F",[57.3037,167.815,0.0397186],122.847,1,0,[-3.83322,-1.65957],"","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[74.0137,161.285,-0.000236511],0,1,0,[0.611019,2.367],"","",true,false],
	["Land_FieldToilet_F",[72.8496,161.883,-0.459442],303.704,1,0,[2.30675,0.806765],"","",true,false],
	["FirePlace_burning_F",[72.5264,162.088,0.481651],303.679,1,0,[0,0],"","",true,false],
	["Flag_UK_F",[65.1064,166.451,0],303.679,1,0,[0,0],"baseflag","",true,false],
	["Land_Axe_fire_F",[74.3154,162.859,-0.00200653],303.699,1,0,[1.10169,-0.27411],"","",true,false],
	["Land_FireExtinguisher_F",[73.875,163.252,0.000865936],303.659,1,0,[2.28374,0.928609],"","",true,false]
];

/*
Grab data:
Mission: Abdera_blubase
World: Altis
Anchor position: [9155, 21538.1]
Area size: 400
Using orientation of objects: yes
*/
Abdera_blubase =
[
	["Land_HelipadSquare_F",[37.8906,93.5898,0],320.396,1,0,[-1.06554,-0.208678],"blubasehelipad","",true,false],
	["Land_Cargo_Patrol_V1_F",[22.3086,101.938,0],329.316,1,0,[0,0],"","",true,false],
	["Land_Cargo_House_V1_F",[12.9033,108.477,0.872322],329.316,1,0,[-0.342804,0.469694],"","",true,false],
	["RoadCone_F",[38.5371,104.525,7.34329e-005],0.000641433,1,0.0099011,[-0.532995,-0.913832],"terminalcone","",true,false],
	["Land_New_WiredFence_10m_F",[31.3086,112.436,0.0491238],148.473,1,0,[0,-0],"","",true,false],
	["Land_New_WiredFence_10m_F",[17.2334,115.426,-0.0785303],56.2194,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[35.9902,109.975,0],329.316,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[7.81836,118.416,0],148.453,1,0,[0,-0],"","",true,false],
	["Land_Net_Fence_Gate_F",[24.0869,119.561,0.00233364],329.316,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[26.5186,121.129,-0.097065],60.0497,1,0,[0,0],"","",true,false],
	["MapBoard_altis_F",[33.2949,116.822,-0.00185394],190.122,1,0,[-0.207931,1.10818],"blubasewhiteboard","",true,false],
	["Land_New_WiredFence_5m_F",[22.3262,118.656,0.00462532],329.316,1,0,[0,0],"","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[39.1035,117.818,0],0,1,0,[-0.381549,-0.992903],"","",true,false],
	["Land_FieldToilet_F",[38.8887,118.664,-0.313959],329.32,1,0,[-0.837414,-0.658458],"","",true,false],
	["Land_Axe_fire_F",[40.2783,118.377,-0.00327206],329.31,1,0,[-0.766412,-0.543906],"","",true,false],
	["FirePlace_burning_F",[38.6797,118.936,0.33239],329.316,1,0,[0,0],"","",true,false],
	["Land_Medevac_house_V1_F",[17.4834,124.684,0],328.961,1,0,[0,0],"blubasehospital","",true,false],
	["RoadCone_F",[34.0674,120.641,9.44138e-005],329.319,1,0.00991888,[-0.833899,-0.656417],"ammoboxcone","",true,false],
	["Land_FireExtinguisher_F",[40.1143,119.434,0.00025177],329.348,1,0,[-0.831074,-0.442359],"","",true,false],
	["Flag_UK_F",[33.877,126.08,0],329.316,1,0,[0,0],"baseflag","",true,false],
	["Land_BagBunker_Small_F",[27.4922,130.643,-0.00164509],148.453,1,0,[0.16958,-0.0142072],"","",true,false]
];

/*
Grab data:
Mission: almyra_blubase
World: Altis
Anchor position: [23145, 18443.1]
Area size: 400
Using orientation of objects: yes
*/
almyra_blubase =
[
	["Land_HelipadSquare_F",[69.0215,14.4746,0],81.256,1,0,[0,0],"blubasehelipad","",true,false],
	["RoadCone_F",[80.9961,7.99805,8.82149e-006],360,1,0.00993533,[0.00215815,0.00383759],"terminalcone","",true,false],
	["Land_Cargo_Patrol_V1_F",[84.0645,7.69922,0],90.1734,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[84.1816,23.5664,0],90.1734,1,0,[0,-0],"","",true,false],
	["Land_Axe_fire_F",[89.0762,-0.289063,-0.00336051],90.1734,1,0,[-1.562e-005,-5.16511e-006],"","",true,false],
	["Danger",[89.334,1.26953,0],0,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[88.5918,10.4668,-2.38419e-006],269.33,1,0,[0,0],"","",true,false],
	["Land_FieldToilet_F",[90.0215,0.820313,-0.332881],90.1729,1,0,[0.00166375,-0.000845285],"","",true,false],
	["Land_FireExtinguisher_F",[90.0684,-0.689453,0.000122786],90.242,1,0,[-0.0433049,0.0852259],"","",true,false],
	["FirePlace_burning_F",[90.377,0.796875,0.323533],90.2292,1,0,[-2.42919,-1.32048],"","",true,false],
	["MapBoard_altis_F",[91.709,6.24414,-0.00216866],310.121,1,0,[-0.318534,0.00377382],"blubasewhiteboard","",true,false],
	["Land_New_WiredFence_10m_F",[98.502,10.1152,-2.38419e-006],180.907,1,0,[0,0],"","",true,false],
	["RoadCone_F",[94.2031,3.875,9.05991e-006],90.176,1,0.00993604,[0.00216143,0.00412263],"ammoboxcone","",true,false],
	["Land_New_WiredFence_10m_F",[98.3711,21.0078,-2.38419e-006],177.077,1,0,[0,-0],"","",true,false],
	["Land_Cargo_House_V1_F",[94.627,28.2773,0.120339],90.1734,1,0,[0,-0],"","",true,false],
	["Flag_UK_F",[98.9707,1.25391,0],90.173,1,0,[0,-0],"baseflag","",true,false],
	["Land_New_WiredFence_5m_F",[98.5254,14.9766,1.43051e-006],90.1734,1,0,[0,-0],"","",true,false],
	["Land_Net_Fence_Gate_F",[98.3984,13.0039,0],90.1734,1,0,[0,-0],"","",true,false],
	["Land_BagBunker_Small_F",[106.168,4.39453,0],269.311,1,0,[0,0],"","",true,false],
	["Land_Medevac_house_V1_F",[106.184,16.0449,0],89.818,1,0,[0,0],"blubasehospital","",true,false],
	["Land_BagBunker_Small_F",[105.76,27.5547,0],269.311,1,0,[0,0],"","",true,false]
];

/*
Grab data:
Mission: Feres_blubase_Comp
World: Altis
Anchor position: [20983, 7242.05]
Area size: 400
Using orientation of objects: yes
*/
feres_blubase =
[
	["Land_HelipadSquare_F",[-158.943,21.623,0],227.403,1,0,[0.108804,0.00456093],"blubasehelipad","",true,false],
	["Land_Cargo_Patrol_V1_F",[-166.469,5.62646,0],236.321,1,0,[0,0],"","",true,false],
	["RoadCone_F",[-170.5,19.105,4.57764e-005],359.962,1,0.010012,[0.0265697,-0.259675],"terminalcone","",true,false],
	["Land_Cargo_House_V1_F",[-172.521,-4.11035,0.324123],236.321,1,0,[0.23298,0.211489],"","",true,false],
	["Land_New_WiredFence_10m_F",[-177.432,14.0396,-0.257574],55.4774,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-179.699,-0.183105,0.375683],323.224,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[-175.209,18.8696,0],236.321,1,0,[0,0],"","",true,false],
	["Land_Net_Fence_Gate_F",[-184.164,6.47412,-0.0110779],236.321,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[-182.215,-9.74951,0.0405464],55.5487,1,0,[-3.94612,-0.623685],"","",true,false],
	["Land_New_WiredFence_10m_F",[-185.854,8.75732,0.437016],327.054,1,0,[0,0],"","",true,false],
	["MapBoard_altis_F",[-182.621,16.5688,0.000967026],91.3644,1,0,[-0.487031,-3.28584],"blubasewhiteboard","",true,false],
	["Danger",[-183.268,21.7891,0],0,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-183.172,4.7373,0.171946],236.321,1,0,[0,0],"","",true,false],
	["Land_Axe_fire_F",[-183.822,22.7139,-0.00334358],236.324,1,0,[0.57214,0.444936],"","",true,false],
	["Land_FieldToilet_F",[-184.057,21.3643,-0.787428],236.326,1,0,[0.573604,0.44376],"","",true,false],
	["FirePlace_burning_F",[-184.297,21.0869,0.819992],236.321,1,0,[0,0],"","",true,false],
	["Land_FireExtinguisher_F",[-184.855,22.5181,0.000207901],236.365,1,0,[0.529646,0.533943],"","",true,false],
	["RoadCone_F",[-185.748,16.4028,0.000837326],236.385,1,0.00981157,[2.24388,2.27323],"ammoboxcone","",true,false],
	["Land_Medevac_house_V1_F",[-188.93,-0.381348,1.90735e-006],235.966,1,0,[0,0],"blubasehospital","",true,false],
	["Flag_UK_F",[-191.182,15.918,0],236.321,1,0,[0,0],"baseflag","",true,false],
	["Land_BagBunker_Small_F",[-195.406,9.25146,0.0176544],55.4938,1,0,[-1.68732,-2.45371],"","",true,false]
];

/*
Grab data:
Mission: molos_blubasee
World: Altis
Anchor position: [26939, 24743.1]
Area size: 400
Using orientation of objects: yes
*/
molos_blubase =
[
	["Land_FireExtinguisher_F",[-189.207,-112.908,0.000244141],310.653,1,0,[0.197725,-0.562359],"","",true,false],
	["Land_Axe_fire_F",[-188.707,-113.861,-0.00332832],310.508,1,0,[-0.62086,0.373256],"","",true,false],
	["Danger",[-189.285,-114.596,0],0,1,0,[0,0],"","",true,false],
	["Land_FieldToilet_F",[-190.063,-114.135,0.00123024],310.503,1,0,[-0.609743,0.267025],"","",true,false],
	["FirePlace_burning_F",[-190.4,-113.848,-0.0308781],311.302,1,0,[17.4538,10.2115],"","",true,false],
	["Flag_UK_F",[-198.252,-106.506,0],310.511,1,0,[0,0],"baseflag","",true,false],
	["RoadCone_F",[-187.271,-125.627,0.000404358],0.000520637,1,0.00977272,[-1.52682,-1.6022],"terminalcone","",true,false],
	["RoadCone_F",[-195.311,-113.715,-7.62939e-006],310.511,1,0.00973808,[0.39049,-0.568678],"ammoboxcone","",true,false],
	["MapBoard_altis_F",[-194.457,-116.723,-0.0019722],157.876,1,0,[-0.943268,0.35224],"blubasewhiteboard","",true,false],
	["Land_Cargo_Patrol_V1_F",[-190.059,-123.197,0.0025177],310.511,1,0,[0,0],"","",true,false],
	["Land_HelipadSquare_F",[-182.986,-138.088,0],301.613,1,0,[-5.28587,-1.73779],"blubasehelipad","",true,false],
	["Land_BagBunker_Small_F",[-204.672,-106.348,-0.0295944],129.841,1,0,[3.54412,4.44456],"","",true,false],
	["Land_New_WiredFence_10m_F",[-202.625,-115.678,0.0222244],41.2451,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-195.297,-122.385,-0.0765495],129.668,1,0,[0,-0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-205.742,-119.369,-0.131025],310.511,1,0,[0,0],"","",true,false],
	["Land_Net_Fence_Gate_F",[-204.414,-117.969,-0.015358],310.511,1,0,[0,0],"","",true,false],
	["Land_Medevac_house_V1_F",[-212.318,-115.24,0.000999451],310.156,1,0,[0,0],"blubasehospital","",true,false],
	["Land_New_WiredFence_10m_F",[-209.57,-124.09,-0.127295],37.4148,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V1_F",[-200.42,-135.215,0],310.511,1,0,[0,0],"","",true,false],
	["Land_Cargo_House_V1_F",[-211.414,-132.053,0.224188],310.509,1,0,[-0.762329,-0.0483798],"","",true,false],
	["Land_BagBunker_Small_F",[-219.406,-124.318,-0.0262489],129.61,1,0,[3.099,0.0880829],"","",true,false]
];
/*
Grab data:
Mission: TanoaAirportComp
World: Tanoa
Anchor position: [7053, 7337]
Area size: 400
Using orientation of objects: yes
*/
aeroporto_de_tanoa_compostion =
[
	["C_Plane_Civil_01_F",[-56.2354,23.416,-0.00491095],0.00123131,1,0,[0.126994,0.000140451],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[29.8599,61.0845,0.064137],0.000152144,1,0,[0.120051,0.184022],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[-3.57275,73.9761,0.0623112],0.000189135,1,0,[0.121283,0.198837],"","",true,false],
	["C_Plane_Civil_01_F",[-64.6318,57.5361,-0.00491953],0.00109495,1,0,[0.126977,0.000136499],"","",true,false],
	["O_Heli_Transport_04_medevac_F",[-16.5723,92.479,-0.465704],359.997,1,0,[4.16034,0.0527104],"","",true,false],
	["Land_HelipadCircle_F",[-15.73,94.1641,0],0,1,0,[0,0],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[29.7944,101.852,-0.128174],0.0738503,1,0,[3.0138,-0.00238025],"","",true,false],
	["Land_HelipadCircle_F",[30.4253,102.066,0],0,1,0,[0,0],"","",true,false],
	["C_Plane_Civil_01_F",[-102.473,37.7617,-0.788925],350.729,1,0,[0,0],"","",true,false],
	["O_Truck_02_fuel_F",[-70.9492,-127.833,0.040462],57.9267,1,0,[-0.0370047,-0.0278839],"","",true,false],
	["O_Truck_02_transport_F",[-155.053,-11.1973,0.0677018],323.094,1,0,[-0.0049817,0.0123454],"","",true,false],
	["O_Truck_02_transport_F",[-159.734,-14.6924,0.0691981],323.094,1,0,[-0.00594543,0.0190554],"","",true,false],
	["C_Plane_Civil_01_racing_F",[-115.742,111.213,-0.788925],0,1,0,[0,0],"","",true,false],
	["O_Plane_CAS_02_F",[-95.1616,-130.744,-0.39053],357.909,1,0,[0,0],"","",true,false],
	["O_Plane_Fighter_02_F",[-194.375,-59.7495,-0.286222],30.5656,1,0,[0,0],"","",true,false],
	["O_Truck_02_fuel_F",[-206.314,-46.4897,0.0404625],0.000115146,1,0,[-0.0370043,-0.0278803],"","",true,false],
	["O_Plane_CAS_02_F",[-214.066,-32.8662,-0.286222],138.611,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-119.782,240.979,0.0136328],0,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V4_F",[245.621,-161.628,0],0,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-318.987,74.8652,0.0338631],0,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-151.01,-309.747,0],0,1,0,[0,0],"","",true,false]
];

aeroporto_de_tanoa_blubase = /*
Grab data:
Mission: blubase_aeroporto_tanoa
World: Tanoa
Anchor position: [7053, 7337.05]
Area size: 800
Using orientation of objects: yes
*/

[
	["Land_HelipadSquare_F",[-111.321,-78.666,0],217.773,1,0,[0,0],"blubasehelipad","",true,false],
	["RoadCone_F",[-135.473,-91.0039,-6.67572e-006],226.692,1,0,[0.000918308,0.00257029],"terminalcone","",true,false],
	["Land_Cargo_Patrol_V4_F",[-125.735,-105.974,0],226.69,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V4_F",[-138.019,-93.4414,0],226.69,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-138.693,-99.3301,-0.0120296],45.8466,1,0,[0,0],"","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[-147.425,-92.7808,-0.000526905],226.7,1,0,[1.04774,1.11181],"","",true,false],
	["Land_New_WiredFence_10m_F",[-138.537,-113.672,-0.07761],313.593,1,0,[0,0],"","",true,false],
	["Land_MapBoard_F",[-144.97,-96.937,-0.00182247],73.6449,1,0,[0.375118,0.746077],"blubasewhiteboard","",true,false],
	["Land_FieldToilet_F",[-147.636,-94.2773,0.000537872],226.691,1,0,[0.398335,1.09338],"","",true,false],
	["Land_Cargo_House_V1_F",[-130.82,-116.407,0],226.69,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-146.078,-105.874,-0.0938554],317.423,1,0,[0,0],"","",true,false],
	["Land_Axe_fire_F",[-149.334,-92.4497,-0.00265265],226.714,1,0,[0.38454,1.03319],"","",true,false],
	["FirePlace_burning_F",[-148.218,-94.6421,0.0178528],226.689,1,0,[0.399979,1.09259],"","",true,false],
	["RoadCone_L_F",[-150.147,-98.2754,0.00519466],226.708,1,0,[-3.70443,0.56487],"ammoboxcone","",true,false],
	["Land_Net_Fence_Gate_F",[-144.1,-107.943,0.0329018],226.69,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-142.815,-109.434,-0.00788522],226.69,1,0,[0,0],"","",true,false],
	["Flag_UK_F",[-156.667,-97.627,0],226.69,1,0,[0,0],"baseflag","",true,false],
	["Land_BagBunker_Small_F",[-139.395,-123.544,0],45.8268,1,0,[0,0],"","",true,false],
	["Land_TentDome_F",[-147.629,-114.93,0.0112734],46.877,1,0,[2.04926,-3.17275],"blubasemash","",true,false],
	["Land_BagBunker_Small_F",[-155.638,-106.978,-0.0122399],45.8403,1,0,[1.37022,2.2885],"","",true,false]
];

st_george_composition = /*
Grab data:
Mission: TanoaAirportComp
World: Tanoa
Anchor position: [11604, 3185]
Area size: 400
Using orientation of objects: yes
*/

[
	["C_Heli_light_01_blueLine_F",[20.1318,-77.1982,0.0105743],35.9938,1,0,[1.94003,0.0496379],"","",true,false],
	["O_Truck_02_fuel_F",[93.4385,-20.0332,0.0483561],200.765,1,0,[-0.30254,-0.765374],"","",true,false],
	["C_Heli_light_01_digital_F",[39.502,-89.9441,-0.00247192],33.6637,1,0,[0.983601,0.00476193],"","",true,false],
	["O_Plane_Fighter_02_F",[105.781,-23.5925,-0.286222],218.805,1,0,[0,0],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[57.8232,-105.312,0.0975361],59.0986,1,0,[1.45163,-0.192083],"","",true,false],
	["O_Plane_CAS_02_F",[137.213,-44.4946,-0.286222],216.109,1,0,[0,0],"","",true,false],
	["O_Truck_02_box_F",[63.8906,-133.566,0.0688534],74.7548,1,0,[0.00609393,0.0183895],"","",true,false],
	["O_Truck_02_fuel_F",[85.0869,-124.56,0.0425072],92.726,1,0,[-0.023978,-0.0112089],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[148.556,-53.5696,0.0185909],200.773,1,0,[-1.5279,-0.0443964],"","",true,false],
	["Land_Cargo_Tower_V4_F",[162.9,-25.063,0],35.441,1,0,[0,0],"","",true,false],
	["O_Heli_Transport_04_medevac_F",[99.3691,-132.025,-0.459139],34.8813,1,0,[4.46096,1.00117],"","",true,false],
	["Land_HelipadCircle_F",[101.581,-131.352,0],34.8011,1,0,[0.529372,1.11208],"","",true,false],
	["O_Plane_CAS_02_F",[167.1,-70.2859,-0.285903],214.66,1,0,[-0.76329,0.0295948],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[140.95,-163.868,-0.131138],36.8542,1,0,[4.73,-0.735943],"","",true,false],
	["Land_HelipadCircle_F",[141.674,-164.424,0],36.9361,1,0,[3.26816,-0.792097],"","",true,false],
	["O_Truck_02_box_F",[143.042,-182.771,0.0676913],40.4315,1,0,[0.00618738,0.0199528],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-233.514,0.495605,0],200.742,1,0,[0,0],"","",true,false]
];
st_george_blubase =
/*
Grab data:
Mission: blubase_stgeorge
World: Tanoa
Anchor position: [11604, 3185.05]
Area size: 800
Using orientation of objects: yes
*/

[
	["Land_Cargo_Patrol_V4_F",[133.541,-35.6646,0],35.7639,1,0,[0,0],"","",true,false],
	["Land_Cargo_House_V1_F",[136.556,-24.4561,0.072571],35.7639,1,0,[0,0],"","",true,false],
	["Land_HelipadSquare_F",[123.826,-63.7542,0],275.681,1,0,[0.380173,0.805451],"blubasehelipad","",true,false],
	["Land_BagBunker_Small_F",[143.621,-15.8235,0.00999737],214.898,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[144.646,-25.6436,-2.86102e-006],122.665,1,0,[0,-0],"","",true,false],
	["Land_New_WiredFence_10m_F",[147.528,-39.7307,-2.86102e-006],214.918,1,0,[0,0],"","",true,false],
	["Land_Net_Fence_Gate_F",[151.171,-30.2771,0.000781059],35.7639,1,0,[0,0],"","",true,false],
	["RoadCone_F",[145.943,-48.5266,3.33786e-006],35.7617,1,0.0197804,[0.000967092,0.00265898],"terminalcone","",true,false],
	["Land_New_WiredFence_5m_F",[149.641,-29.0254,1.43051e-006],35.7639,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[153.583,-31.8745,0.0248203],126.495,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Patrol_V4_F",[147.979,-45.6409,0],35.7639,1,0,[0,0],"","",true,false],
	["Land_TentDome_F",[153.418,-22.7249,0.09123],216.034,1,0,[0,0],"blubasemash","",true,false],
	["Land_MapBoard_F",[154.146,-40.9424,-0.00223207],242.666,1,0,[-0.330114,0.00269133],"blubasewhiteboard","",true,false],
	["Land_FieldToilet_F",[157.271,-43.054,-3.29018e-005],35.7616,1,0,[0.00214665,-0.00121344],"","",true,false],
	["FirePlace_burning_F",[157.767,-42.53,0.40119],35.7639,1,0,[0,0],"","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[157.348,-44.5308,-0.000141621],35.7639,1,0,[0,0],"","",true,false],
	["RoadCone_L_F",[158.967,-38.6213,0.00211954],35.7685,1,0,[0.00524912,0.00469826],"ammoboxcone","",true,false],
	["Land_BagBunker_Small_F",[162.642,-28.9688,-0.00756311],214.86,1,0,[1.74604,-2.50581],"","",true,false],
	["Land_Axe_fire_F",[159.277,-44.4705,-0.00337267],35.7639,1,0,[-3.81993e-005,1.01166e-005],"","",true,false],
	["Flag_UK_F",[165.493,-37.9961,0.0308247],35.7639,1,0,[0,0],"baseflag","",true,false]
];


la_rochelle_composition = /*
Grab data:
Mission: rochellecomp
World: Tanoa
Anchor position: [11775, 13124]
Area size: 600
Using orientation of objects: yes
*/

[
	["O_T_VTOL_02_infantry_F",[13.793,-36,-0.0170879],17.7809,1,0,[-0.669063,-0.0688483],"","",true,false],
	["Windsock_01_F",[-47.8154,-0.297852,-3.8147e-005],0,1,0,[0,0],"","",true,false],
	["O_Plane_CAS_02_F",[62.4941,-51.4297,-0.0915508],16.7238,1,0,[1.89061,6.83391e-006],"","",true,false],
	["O_Plane_CAS_02_F",[89.8037,-61.0244,-0.0916967],19.2756,1,0,[1.8879,0.00149999],"","",true,false],
	["Land_MobileLandingPlatform_01_F",[-118.437,-4.52441,0.0239997],22.4021,1,0,[3.09644e-005,-1.9773e-005],"","",true,false],
	["Land_Cargo_Tower_V1_F",[86.2471,95.7051,0],107.154,1,0,[0,-0],"","",true,false],
	["C_Plane_Civil_01_racing_F",[-135.008,20.3174,-0.0541964],8.90306,1,0,[-0.467435,-0.376981],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[118.701,-69.1074,-0.0059557],18.0745,1,0,[-0.178417,0.483067],"","",true,false],
	["Land_TripodScreen_01_large_F",[122.628,-77.9912,0.0240612],172.41,1,0,[-0.00098792,0.00270619],"","",true,false],
	["Land_GamingSet_01_console_F",[123.407,-79.5654,-0.00200558],0.010568,1,0,[3.82965e-005,-1.30519e-005],"","",true,false],
	["Land_PCSet_01_screen_F",[123.832,-79.0127,-0.135612],354.512,1,0,[-88.9792,-3.1733],"","",true,false],
	["O_T_UAV_04_CAS_F",[128.208,-72.3164,0.0569048],16.0523,1,0,[-2.13086,0.00680966],"","",true,false],
	["Land_CampingTable_F",[123.791,-79.6875,0.0239992],0.00145271,1,0,[-0.000159733,3.05066e-005],"","",true,false],
	["Item_O_UavTerminal",[124.253,-79.6973,-0.0241117],60.8025,1,0,[0,0],"","",true,false],
	["Land_EngineCrane_01_F",[126.929,-76.835,0.0240002],197.049,1,0,[0.000111829,0.00032686],"","",true,false],
	["Land_PlasticCase_01_large_F",[125.834,-79.7227,0.0239987],359.997,1,0,[-0.000258335,0.000390494],"","",true,false],
	["O_T_Boat_Armed_01_hmg_F",[57.5645,140.98,-0.939877],29.1231,1,0,[0.594361,0.117283],"","",true,false],
	["O_SDV_01_F",[-56.1045,141.586,-1.1098],0.302055,1,0,[-0.968253,0.783808],"","",true,false],
	["O_T_Truck_03_transport_ghex_F",[141.505,-61.585,-0.031539],17.5716,1,0,[-0.435554,0.596601],"","",true,false],
	["C_Plane_Civil_01_F",[-155.732,26.4492,-0.0409765],10.3595,1,0,[-0.441221,-0.495984],"","",true,false],
	["O_T_Boat_Armed_01_hmg_F",[116.314,134.397,-0.943754],352.935,1,0,[0.908761,0.132115],"","",true,false],
	["C_Plane_Civil_01_F",[-176.203,31.2754,-0.096838],10.1689,1,0,[-0.00259474,0.000581513],"","",true,false],
	["C_Truck_02_covered_F",[-177.594,-92.8418,0.0491524],332.23,1,0,[-0.358933,0.118072],"","",true,false],
	["O_T_Truck_03_fuel_ghex_F",[-146.19,138.019,-0.0736437],197.125,1,0,[0.256637,0.100542],"","",true,false],
	["C_Heli_light_01_blue_F",[-198.516,39.8867,0.00467443],13.9233,1,0,[0.0882721,4.17499e-005],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[-153.181,140.621,-0.0057478],195.268,1,0,[-0.178447,0.480005],"","",true,false],
	["O_Heli_Attack_02_F",[-163.618,145.424,0.0256729],193.162,1,0,[0.597365,-0.0508426],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-218.604,48.8115,0.00467682],19.2178,1,0,[0.0881539,-0.000234044],"","",true,false],
	["C_Truck_02_fuel_F",[-233.594,47.3154,-0.0192013],16.5454,1,0,[0.716061,0.870825],"","",true,false],
	["Windsock_01_F",[-234.857,48.5713,0],0,1,0,[0,0],"","",true,false],
	["C_Truck_02_covered_F",[-242.776,48.124,0.0446043],8.54223,1,0,[-1.22324,0.0963575],"","",true,false],
	["Land_HistoricalPlaneWreck_02_rear_F",[430.694,13.3428,-1.3368],164.983,1,0,[25.8695,14.076],"","",true,false],
	["Land_HistoricalPlaneDebris_01_F",[432.537,-1.2998,-0.03485],359.559,1,0,[4.89383,1.88795],"","",true,false],
	["Land_HistoricalPlaneDebris_04_F",[446.004,5.66895,0.0332704],0.0722382,1,0,[-8.52093,-8.05986],"","",true,false],
	["Land_HistoricalPlaneDebris_04_F",[446.973,-4.87793,0.0127966],359.994,1,0,[-7.44236,1.40787],"","",true,false],
	["Land_HistoricalPlaneWreck_02_front_F",[455.826,-0.0595703,0.331656],291.143,1,0,[6.70799,-4.81853],"","",true,false],
	["Land_HistoricalPlaneDebris_01_F",[458.488,-13.3779,0.0423096],62.2358,1,0,[-0.799747,-168.066],"","",true,false],
	["Land_HistoricalPlaneDebris_04_F",[462.026,-14.8096,-0.883949],0.0998101,1,0,[5.47785,1.34865],"","",true,false]
];

la_rochelle_blubase =
/*
Grab data:
Mission: blubase_larochelle
World: Tanoa
Anchor position: [11775, 13124]
Area size: 800
Using orientation of objects: yes
*/

[
	["Land_HelipadSquare_F",[-75.5957,15.1289,0],194.175,1,0,[0,0],"blubasehelipad","",true,false],
	["Land_Cargo_Patrol_V4_F",[-80.001,-15.8994,0],203.092,1,0,[0,0],"","",true,false],
	["Land_Cargo_House_V1_F",[-79.6816,-27.2998,0.121078],203.092,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-88.6348,-28.1113,-1.90735e-006],289.996,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-94.5361,-14.999,-1.90735e-006],22.249,1,0,[0,0],"","",true,false],
	["RoadCone_F",[-94.9473,-6.07422,8.58307e-006],203.09,1,0,[0.00202321,0.00392737],"terminalcone","",true,false],
	["Land_Net_Fence_Gate_F",[-96.0186,-25.0225,9.53674e-007],203.092,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V4_F",[-96.2734,-9.33105,0],203.092,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-98.7197,-23.9922,0.00152302],293.826,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-94.251,-25.9072,9.53674e-007],203.092,1,0,[0,0],"","",true,false],
	["Land_TentDome_F",[-96.3389,-31.9844,0.0810776],23.3654,1,0,[0,0],"blubasemash","",true,false],
	["Land_MapBoard_F",[-101.349,-15.3164,-0.00219822],49.9176,1,0,[-0.319585,-0.00123354],"blubasewhiteboard","",true,false],
	["Land_FieldToilet_F",[-104.95,-13.9346,2.67029e-005],203.09,1,0,[-0.00067314,-0.00136902],"","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[-105.255,-12.4814,0.00432396],203.092,1,0,[0,0],"","",true,false],
	["FirePlace_burning_F",[-105.146,-14.5137,3.75686],203.092,1,0,[0,0],"","",true,false],
	["RoadCone_L_F",[-105.468,-18.6387,0.00213146],203.093,1,0,[0.00735513,0.00219502],"ammoboxcone","",true,false],
	["Land_Axe_fire_F",[-107.044,-12.9521,-0.00336075],203.092,1,0,[-1.18031e-005,-7.44843e-006],"","",true,false],
	["Land_BagBunker_Small_F",[-106.926,-28.8418,0],16.968,1,0,[0,0],"","",true,false],
	["Flag_UK_F",[-111.686,-20.6318,2.86102e-006],203.092,1,0,[0,0],"baseflag","",true,false]
];

bala_composition =

/*
Grab data:
Mission: TanoaAirportComp
World: Tanoa
Anchor position: [2182, 3526]
Area size: 400
Using orientation of objects: yes
*/

[
	["O_T_Truck_03_repair_ghex_F",[19.2241,0.905762,0.0623178],187.46,1,0,[0.121346,0.199065],"","",true,false],
	["O_Heli_Light_02_F",[33.1399,1.30054,-0.465708],164.848,1,0,[4.16072,0.0526615],"","",true,false],
	["Land_HelipadCircle_F",[34.3035,-0.0305176,0],164.857,1,0,[0,-0],"","",true,false],
	["O_Heli_Transport_04_medevac_F",[-52.2878,-22.5068,-0.465719],163.142,1,0,[4.16095,0.0540518],"","",true,false],
	["Land_HelipadCircle_F",[-52.7573,-25.481,9.53674e-007],163.15,1,0,[0,-0],"","",true,false],
	["O_Truck_02_fuel_F",[-3.5354,-76.3994,0.0596819],334.191,1,0,[0.229623,-0.21985],"","",true,false],
	["O_Plane_CAS_02_F",[-20.8892,-77.1479,-0.280325],322.872,1,0,[0.243324,-0.184215],"","",true,false],
	["Land_Cargo_Tower_V4_F",[69.7996,-59.749,0],35.441,1,0,[0,0],"","",true,false],
	["O_Plane_Fighter_02_F",[-37.783,-89.9521,-0.276093],331.861,1,0,[1.29681,2.42368],"","",true,false],
	["O_Heli_Light_02_F",[-100.31,-34.8743,-0.128148],165.177,1,0,[3.01388,8.83277e-005],"","",true,false],
	["Land_HelipadCircle_F",[-101.255,-34.9792,0.0246954],165.259,1,0,[0,-0],"","",true,false],
	["O_Truck_02_box_F",[-109.242,-48.2722,0.0681133],168.78,1,0,[0.00608557,0.0189167],"","",true,false],
	["O_Truck_02_transport_F",[-53.8696,-129.512,0.0678825],318.478,1,0,[0.416354,-1.50662],"","",true,false],
	["C_Plane_Civil_01_racing_F",[-112.161,-84.6033,-0.0061388],359.997,1,0,[0.0944448,-0.00792302],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-145.429,-63.5361,0.00470829],359.999,1,0,[0.0879746,0.00131402],"","",true,false],
	["O_Truck_02_transport_F",[-29.219,-162.698,0.0701656],52.0332,1,0,[-0.220402,-0.00929786],"","",true,false],
	["C_Plane_Civil_01_F",[-138.874,-90.7583,-0.00674534],359.997,1,0,[-0.00223486,-0.153807],"","",true,false],
	["O_Truck_02_transport_F",[-47.8552,-169.034,0.0776606],264.048,1,0,[-0.888803,-0.804631],"","",true,false],
	["C_Heli_light_01_ion_F",[-186.03,-77.2561,0.00469017],0.00166547,1,0,[0.0908428,0.00314917],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-157.009,-141.252,0],35.441,1,0,[0,0],"","",true,false]
];


bala_blubase =
/*
Grab data:
Mission: blubase_bala
World: Tanoa
Anchor position: [2182, 3526.05]
Area size: 800
Using orientation of objects: yes
*/

[
	["Land_HelipadSquare_F",[-54.1174,-49.9053,0],153.387,1,0,[0,-0],"blubasehelipad","",true,false],
	["Land_Cargo_Patrol_V4_F",[-35.7249,-74.708,0],162.304,1,0,[0,-0],"","",true,false],
	["Land_Cargo_House_V1_F",[-28.5107,-83.7747,0.13077],162.3,1,0,[-1.11764,0.517588],"","",true,false],
	["Land_New_WiredFence_10m_F",[-47.3186,-83.5232,0.0119896],341.461,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-34.2854,-89.5483,-0.330708],249.207,1,0,[0,0],"","",true,false],
	["RoadCone_F",[-53.46,-77.0339,6.67572e-006],162.314,1,0.0792187,[0.00208862,0.0039553],"terminalcone","",true,false],
	["Land_Cargo_Patrol_V4_F",[-52.3359,-80.3667,0],162.304,1,0,[0,-0],"","",true,false],
	["Land_BagBunker_Small_F",[-25.7859,-94.6184,-0.0014019],341.441,1,0,[0.144046,-0.0483623],"","",true,false],
	["Land_Net_Fence_Gate_F",[-41.938,-92.0781,0.229599],162.304,1,0,[0,-0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-44.6116,-93.0645,0.00152302],253.038,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-39.9763,-91.5862,-0.018549],162.304,1,0,[0,-0],"","",true,false],
	["Land_MapBoard_F",[-52.2693,-88.2134,-0.00218868],9.24914,1,0,[-0.31977,-0.00309329],"blubasewhiteboard","",true,false],
	["Land_TentDome_F",[-37.1824,-98.3887,0.2115],342.58,1,0,[-0.0167437,0.96595],"blubasemash","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[-57.0789,-88.6194,0.00432396],162.304,1,0,[0,-0],"","",true,false],
	["Land_FieldToilet_F",[-55.8984,-89.5203,6.67572e-006],162.318,1,0,[0.00159434,-0.00119032],"","",true,false],
	["FirePlace_burning_F",[-55.6687,-90.0876,0.768212],162.304,1,0,[0,-0],"","",true,false],
	["Land_Axe_fire_F",[-58.1257,-90.1438,-0.0033617],162.304,1,0,[1.33482e-005,-2.53113e-006],"","",true,false],
	["RoadCone_L_F",[-53.2175,-93.4202,0.00213242],162.134,1,0,[-0.140877,0.0513603],"ammoboxcone","",true,false],
	["Land_BagBunker_Small_F",[-47.7007,-102.116,0.00047493],341.441,1,0,[-0.048363,-0.144049],"","",true,false],
	["Flag_UK_F",[-56.623,-98.9912,0],162.304,1,0,[0,-0],"baseflag","",true,false]
];

tuvanaka_composition = /*
Grab data:
Mission: TanoaAirportComp
World: Tanoa
Anchor position: [2119, 13168]
Area size: 400
Using orientation of objects: yes
*/

[
	["Land_Cargo_Tower_V4_F",[34.0979,-47.3906,0],0,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-128.897,73.4268,0],0,1,0,[0,0],"","",true,false],
	["C_Plane_Civil_01_racing_F",[12.8315,180.687,-0.789021],135.338,1,0,[0,-0],"","",true,false],
	["O_Truck_02_fuel_F",[186.652,-2.27441,0.0442371],57.9333,1,0,[-1.73723,0.544994],"","",true,false],
	["C_Plane_Civil_01_F",[45.1812,198.832,-0.788925],134.949,1,0,[0,-0],"","",true,false],
	["O_Truck_02_fuel_F",[70.6719,208.188,0.0404615],0.000115093,1,0,[-0.0369895,-0.027904],"","",true,false],
	["O_Truck_02_transport_F",[225.619,-32.4277,0.0698624],323.093,1,0,[0.0249772,-0.0284067],"","",true,false],
	["O_Plane_Fighter_02_F",[74.9924,218.313,-0.390531],141.659,1,0,[0,-0],"","",true,false],
	["O_Truck_02_transport_F",[232.188,-28.8867,0.0702734],323.093,1,0,[0.0410473,-0.00482697],"","",true,false],
	["O_Truck_02_transport_F",[238.743,-24.8125,0.0720444],323.094,1,0,[0.0755377,0.191567],"","",true,false],
	["O_Truck_02_box_F",[92.4939,236.356,0.0680151],234.013,1,0,[0.00613665,0.0191425],"","",true,false],
	["O_Plane_CAS_02_F",[113.594,247.55,-0.286222],138.611,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Tower_V4_F",[280.506,112.186,1.90735e-006],0,1,0,[0,0],"","",true,false],
	["O_Heli_Attack_02_F",[261.768,160.071,-0.515877],0.0591937,1,0,[4.13664,0.475212],"","",true,false],
	["Land_HelipadCircle_F",[261.62,162.705,0],0,1,0,[0,0.151948],"","",true,false],
	["Land_Cargo_Tower_V4_F",[-213.244,-230.734,0],0,1,0,[0,0],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[277.792,166.993,0.0571966],0.0215534,1,0,[3.43104,2.98171],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[300.599,168.808,-0.439928],0.0625853,1,0,[7.08193,0.93259],"","",true,false],
	["O_T_Truck_03_repair_ghex_F",[320.321,159.248,0.0682106],359.987,1,0,[0.857157,-0.78778],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[322.063,208.063,-0.127471],359.945,1,0,[3.03358,0.0860202],"","",true,false],
	["Land_HelipadCircle_F",[322.691,208.271,0],0,1,0,[0,0],"","",true,false],
	["Land_Cargo_Tower_V4_F",[208.94,329.509,0],0,1,0,[0,0],"","",true,false]
];

tuvanaka_blubase = /*
Grab data:
Mission: blubase_tuvanaka
World: Tanoa
Anchor position: [2119, 13168]
Area size: 800
Using orientation of objects: yes
*/

[
	["Land_BagBunker_Small_F",[-3.22974,138.388,0.000469208],350.956,1,0,[0,0],"","",true,false],
	["Land_Cargo_House_V1_F",[6.11597,144.893,0],230.745,1,0,[0,0],"","",true,false],
	["Land_TentDome_F",[-10.8135,148.475,0],51.0184,1,0,[0,0],"blubasemash","",true,false],
	["Land_Net_Fence_Gate_F",[-7.29761,154.493,0.000471115],230.745,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-2.19189,148.329,0.000468254],317.649,1,0,[0,0],"","",true,false],
	["Land_Cargo_Patrol_V4_F",[11.1248,155.14,0.000469208],230.745,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-6.14209,152.889,0.000470161],230.745,1,0,[0,0],"","",true,false],
	["Land_BagBunker_Small_F",[-18.8638,156.757,0.000470161],110.079,1,0,[0,-0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-1.3335,162.683,0.000468254],49.902,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_10m_F",[-9.21265,156.659,0.00199318],321.479,1,0,[0,0],"","",true,false],
	["RoadCone_L_F",[-12.7051,164.532,0.0021286],230.744,1,0,[0.00776869,0.00189537],"ammoboxcone","",true,false],
	["Land_MapBoard_F",[-7.51489,165.564,-0.00220585],77.773,1,0,[-0.31939,0.000975451],"blubasewhiteboard","",true,false],
	["Flag_UK_F",[-19.1382,165.652,0.000473022],230.745,1,0,[0,0],"baseflag","",true,false],
	["Land_Cargo_Patrol_V4_F",[-0.240723,168.51,0.000469208],230.745,1,0,[0,0],"","",true,false],
	["FirePlace_burning_F",[-10.5061,168.037,1.79629],230.745,1,0,[0,0],"","",true,false],
	["Land_FieldToilet_F",[-10.0635,168.459,3.8147e-005],230.747,1,0,[-0.00193614,0.000674775],"","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[-9.65918,169.888,0.00479412],230.745,1,0,[0,0],"","",true,false],
	["Land_Axe_fire_F",[-11.4619,170.301,-0.00336361],230.749,1,0,[-0.000320164,7.18269e-005],"","",true,false],
	["RoadCone_F",[2.44556,170.779,4.76837e-006],230.748,1,0,[0.00193905,0.00391166],"terminalcone","",true,false],
	["Land_HelipadSquare_F",[27.4346,181.359,0],221.828,1,0,[0,0],"blubasehelipad","",true,false]
];

enemyskillsarray =

	[
		[0.10,0.08,0.50,0.30,0.58,0.35,0.38,0.45,1,0.30],
		[0.12,0.10,0.55,0.35,0.60,0.38,0.40,0.50,1,0.40],
		[0.15,0.17,0.60,0.40,0.63,0.40,0.40,0.50,1,0.50],
		[0.17,0.20,0.65,0.45,0.65,0.42,0.45,0.55,1,0.55],
		[0.20,0.25,0.70,0.50,0.70,0.50,0.50,0.60,1,0.60]
	];