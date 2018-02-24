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
indicavecs = ["I_Truck_02_transport_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F", "I_APC_Wheeled_03_cannon_F" ];
opfor_reinf_truck_soldier = "O_Soldier_GL_F";
opfor_reinf_truck =  "O_Truck_03_transport_F";
islandhop = false; publicVariable "islandhop";
recoveryinuse = false; publicVariable "recoveryinuse";
missionactive = false; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
handle_spt_finished = false;
handle_ai_pcqb_finished = false;
handle_mb_finished = false;
handle_smm_finished = false;
handle_cnp_finished = false;
handle_bf_finished = false;
run_replacequads = true;
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
			opforstaticlandvehicles =["O_APC_Tracked_02_AA_F", "O_APC_Tracked_02_cannon_F"];
			opfortanks = ["O_MBT_02_cannon_F"];
			opforhqtypes = ["O_Truck_03_covered_F", "Land_Cargo_House_V4_F"];
			opforcavecs = ["O_Truck_02_transport_F", "O_APC_Wheeled_02_rcws_F", "O_LSV_02_armed_F"];
			opforcahelis = ["O_Heli_Light_02_F", "O_Heli_Transport_04_bench_F"];
			};
		case "tanoa" :
			{
			forwardpointvehicleclassname = "B_T_LSV_01_armed_F";
			fobvehicleclassname = "B_MRAP_01_F";
			opforpatrollandvehicles = ["O_T_APC_Tracked_02_cannon_ghex_F", "O_T_APC_Wheeled_02_rcws_ghex_F", "O_T_MRAP_02_gmg_ghex_F", "O_T_MRAP_02_hmg_ghex_F", "O_T_LSV_02_armed_F"];
			opforstaticlandvehicles =["O_T_APC_Tracked_02_AA_ghex_F", "O_T_APC_Tracked_02_cannon_ghex_F"];
			opfortanks = ["O_T_MBT_02_cannon_ghex_F"];
			opforhqtypes = ["O_T_Truck_03_covered_ghex_F", "Land_Cargo_House_V4_F"];
			opforcavecs = ["O_Truck_02_transport_F","O_T_LSV_02_armed_F", "O_T_APC_Wheeled_02_rcws_ghex_F"];
			opforcahelis = ["O_Heli_Light_02_F", "O_Heli_Transport_04_bench_F"];
			};
		case "panthera3" :
			{
			forwardpointvehicleclassname = "B_LSV_01_armed_F";
			fobvehicleclassname = "B_MRAP_01_F";
			opforpatrollandvehicles = ["O_APC_Tracked_02_cannon_F", "O_APC_Wheeled_02_rcws_F", "O_MRAP_02_gmg_F", "O_MRAP_02_hmg_F", "O_LSV_02_armed_F"];
			opforstaticlandvehicles =["O_APC_Tracked_02_AA_F", "O_APC_Tracked_02_cannon_F"];
			opfortanks = ["O_MBT_02_cannon_F"];
			opforhqtypes = ["O_Truck_03_covered_F", "Land_Cargo_House_V4_F"];
			opforcavecs = ["O_Truck_02_transport_F", "O_APC_Wheeled_02_rcws_F", "O_LSV_02_armed_F"];
			opforcahelis = ["O_Heli_Light_02_F", "O_Heli_Transport_04_bench_F"];
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
opfor_CQB_soldier = ["O_soldierU_exp_F","O_SoldierU_GL_F","O_soldierU_M_F","O_soldierU_TL_F","O_SoldierU_GL_F","O_SoldierU_GL_F","O_soldierU_exp_F"];
opfor_CQB_Outskirt = ["O_recon_M_F","O_ghillie_sard_F","O_Soldier_GL_F","O_spotter_F","O_recon_TL_F"];
opfor_CQB_Pattio = ["O_Soldier_GL_F","O_HeavyGunner_F","O_Soldier_AR_F"];
opfor_heli_cargomen =["O_T_Recon_TL_F","O_V_Soldier_LAT_ghex_F","O_T_Recon_LAT_F", "O_V_Soldier_ghex_F", "O_T_Sniper_F", "O_T_Sniper_F","O_V_Soldier_ghex_F","O_V_Soldier_ghex_F"];

// Cleanup array of CQB
CQBCleanupArr = [];
boatspawnobjs = ["pierconcrete_01_steps_f.p3d","pierconcrete_01_4m_ladders_f.p3d", "pierwooden_02_ladder_f.p3d", "pierwooden_01_dock_f.p3d", "pierwooden_01_hut_f.p3d","pierwooden_03_f.p3d","canal_dutch_01_stairs_f.p3d", "pier_small_f.p3d","canal_wall_stairs_f.p3d", "pier_addon_f.p3d"];
// Prizes for Prim Targets
prizes = ["B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_T_APC_Tracked_01_AA_F","B_MBT_01_cannon_F","B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F" ,
"B_Plane_CAS_01_F", "B_Heli_Transport_01_camo_F","B_Heli_Light_01_armed_F","B_Heli_Transport_03_F", "B_Heli_Attack_01_F", "B_T_VTOL_01_armed_F", "B_Plane_Fighter_01_F"];
//prizes = ["B_Plane_CAS_01_F", "B_Heli_Transport_01_camo_F","B_Heli_Light_01_armed_F","B_Heli_Transport_03_F", "B_Heli_Attack_01_F", "B_T_VTOL_01_armed_F"];
allbluvehicles = prizes + [fobvehicleclassname, forwardpointvehicleclassname, "B_Quadbike_01_F", "B_T_APC_Tracked_01_CRV_F", "B_APC_Tracked_01_CRV_F", "B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_black_F", "B_Heli_Transport_03_unarmed_green_F"];
publicVariable "allbluvehicles";
// List of useable landmines
aplandmines = ["APERSBoundingMine", "APERSMine" ]; // <--vanilla from weapons/explosives
seamines =["UnderwaterMine", "UnderwaterMinePDM"];// moored, bottom , surface
civs = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F",
	   "C_man_polo_3_F_afro","C_man_polo_3_F_euro","C_man_polo_3_F_asia","C_man_polo_4_F","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","C_man_polo_5_F_afro","C_man_polo_5_F_euro",
	   "C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F","C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia",
	   "C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro",
	   "C_man_p_shorts_1_F_asia","C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F","C_man_shorts_2_F_afro","C_man_shorts_2_F_euro","C_man_shorts_2_F_asia",
	   "C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro","C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro","C_man_shorts_4_F_euro","C_man_shorts_4_F_asia"];// all the civs apart from named and story related ones
civcars = ["C_Offroad_01_F","C_Hatchback_01_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F","C_SUV_01_F","C_Offroad_02_unarmed_F", "I_C_Offroad_02_unarmed_F"];
vips = ["C_journalist_F","C_scientist_F","C_Man_Messenger_01_F","C_Nikos_aged","C_Man_Paramedic_01_F"];
vipdestinations = ["Land_Hotel_01_F", "Land_Hotel_02_F","Land_GH_Gazebo_F","Land_GH_MainBuilding_middle_F","Land_MilOffices_V1_F", "Land_Dome_Big_F", "Land_Dome_Small_F", "Land_Research_HQ_F", "Land_Stadium_p4_F", "Land_Supermarket_01_F","Land_Supermarket_01_malden_F","Land_Monument_01_F", "Land_Castle_01_tower_F","Land_Kiosk_redburger_F","Land_Offices_01_V1_F","Land_Factory_Main_F"];
opforradartypes = ["Land_Radar_Small_F"];
hintqueue = ["","","","","","", "", "","", ""];
opforairsupporttypes = ["O_Heli_Light_02_F", "O_Heli_Light_02_F", "O_T_VTOL_02_infantry_F", "O_Heli_Attack_02_F", "O_Plane_CAS_02_F", "O_Plane_Fighter_02_F"];
huroncontainertypes =  ["B_Slingload_01_Ammo_F", "B_Slingload_01_Cargo_F", "B_Slingload_01_Fuel_F", "B_Slingload_01_Medevac_F", "B_Slingload_01_Repair_F"];
blufortrucktypes = [["B_Truck_01_box_F","B_Truck_01_covered_F", "B_Truck_01_transport_F"], ["I_C_Van_01_transport_brown_F", "I_C_Van_01_transport_olive_F"], ["C_Van_01_transport_white_F", "C_Van_01_box_red_F", "C_Van_01_transport_red_F", "C_Van_01_box_white_F"], ["C_IDAP_Truck_02_F", "C_IDAP_Van_02_transport_F", "C_IDAP_Van_02_vehicle_F", "C_IDAP_Truck_02_transport_F", "C_IDAP_Truck_02_water_F"]];
repvecs = ['B_APC_Tracked_01_CRV_F', 'B_Truck_01_Repair_F', 'Offroad_01_repair_base_F', 'O_Truck_03_repair_F'];
publicVariable "repvecs";

aaccomposition = [//[11461, 11661]
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
	["Land_LampAirport_F",[285.452,230.627,-0.000343323],0,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[65,151.8,0],122,0,0, [0,0], "blubasepos", "", true, false]
];//[11526.2,11812.8,0]

abderacomposition = [//[9155, 21538.1]
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
	["Land_BagBunker_Large_F",[-151.681,-208.986,0.00858688],322.645,1,0,[-0.835742,0.541573],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[31.3,110.9,0],150,0,0, [0,0], "blubasepos", "", true, false]
];//[9186.27,21649,0]

ferescomposition = [// [20983, 7242.05]
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
	["Land_LampAirport_F",[-203.287,-65.4473,0],0,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[-170,1.85,0],48,0,0, [0,0], "blubasepos", "", true, false]
];//[20813.1,7243.86,0]

moloscomposition = [//[26939, 24743.1]
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
	["Land_ReservoirTank_Airport_F",[-271.477,-143.178,0.00749207],0,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F", [-188.8,-128,0],132,0,0, [0,0], "blubasepos", "", true, false]
];//[26750.2,24615,0]

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
	["Land_Cargo_Tower_V4_F",[-151.01,-309.747,0],0,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[-132,-94,0], 50,0,0, [0,0], "blubasepos", "", true, false]
];//[6920.95,7243.08,0]

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
	["Land_Cargo_Tower_V4_F",[-233.514,0.495605,0],200.742,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F", [136,-48,0],214,0,0, [0,0], "blubasepos", "", true, false]
];// [11740.6,3138.2,0.00143909]

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
	["Land_HistoricalPlaneDebris_04_F",[462.026,-14.8096,-0.883949],0.0998101,1,0,[5.47785,1.34865],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",  [-85.9,-6.5,0], 20,0,0, [0,0], "blubasepos", "", true, false]
];// [11689.1,13117.5,0]

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
	["Land_Cargo_Tower_V4_F",[-157.009,-141.252,0],35.441,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F", [-44,-80,0],341,0,0, [0,0], "blubasepos", "", true, false]
];//[2138.08,3446.05,0]

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
	["Land_Cargo_Tower_V4_F",[208.94,329.509,0],0,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[6,153,0],51,0,0, [0,0], "blubasepos", "", true, false]
];// 2120.12,13330.4

arnold_composition =
/*
Grab data:
Mission: arnoldcompo
World: panthera3
Anchor position: [4459, 7492.05]
Area size: 540
Using orientation of objects: yes
*/

[
	["C_Boat_Civil_01_F",[-72.2388,-14.459,-0.707284],0.373445,1,0,[-1.5373,0.445502],"","",true,false],
	["O_Truck_02_Ammo_F",[56.1006,-101.732,-0.000106812],3.69278e-005,1,0,[-0.4336,0.765812],"","",true,false],
	["O_Truck_02_box_F",[62.4473,-101.718,0.0153303],0.0681467,1,0,[-0.874917,-0.52398],"","",true,false],
	["C_Offroad_01_F",[-144.177,-8.83008,-0.0192842],0.00243931,1,0,[-0.601653,-0.0800364],"","",true,false],
	["C_Van_02_service_F",[-149.496,-8.12598,0.0742445],0.000524341,1,0,[-0.978247,-0.000127249],"","",true,false],
	["Windsock_01_F",[-169,11.7646,0],0,1,0,[0,0],"","",true,false],
	["CUP_sign_danger",[-186.682,-27.3872,0],0,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[-198.553,0.719238,0],0,1,0,[0,0],"blubasepos","",true,false],
	["O_Truck_02_fuel_F",[207.813,-2.69922,0.0575099],359.995,1,0,[-5.38348,0.0484508],"","",true,false],
	["O_Plane_CAS_02_dynamicLoadout_F",[-230.769,8.77295,-0.125509],359.992,1,0,[1.0286,-0.0022876],"","",true,false],
	["O_Truck_02_Ammo_F",[-253.465,-57.7339,0.0267549],270.312,1,0,[0.658242,0.785731],"","",true,false],
	["O_Plane_CAS_02_dynamicLoadout_F",[-260.701,7.89941,-0.125708],359.992,1,0,[1.02308,-0.00155907],"","",true,false],
	["O_Heli_Attack_02_dynamicLoadout_F",[-259.826,53.626,0.0256777],179.143,1,0,[0.597087,-0.0515772],"","",true,false],
	["C_Plane_Civil_01_racing_F",[291.418,3.97412,-0.0490379],360,1,0,[0.0181713,-0.00490167],"","",true,false],
	["C_Plane_Civil_01_racing_F",[308.453,3.54199,-0.0491052],360,1,0,[0.0194511,-0.00225161],"","",true,false],
	["O_Plane_Fighter_02_F",[-317.939,10.8179,-0.146942],360,1,0,[0.00117242,-0.0117012],"","",true,false],
	["O_Truck_02_fuel_F",[-342.359,-0.151855,-0.00576115],360,1,0,[0.0174939,0.0272071],"","",true,false],
	["O_Truck_02_fuel_F",[-348.035,0.0688477,-0.00579071],180.846,1,0,[0.0162377,0.0275233],"","",true,false],
	["C_Heli_Light_01_civil_F",[-374.802,-48.6372,0.00466514],359.999,1,0,[0.0889863,0.000371583],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-405.86,-25.937,-0.0520353],0.00424527,1,0,[0.199289,-7.10501e-005],"","",true,false],
	["BMP2Wreck",[371.605,201.417,0.00354242],0,1,0,[-0.457995,0],"","",true,false],
	["O_Heli_Transport_04_F",[-422.982,12.3008,-0.331748],93.9408,1,0,[0.246834,-2.13929e-005],"","",true,false],
	["Rabbit_F",[435.244,65.8711,0.00223756],194.594,1,0,[0,0],"","",true,false],
	["O_Truck_02_box_F",[-484.79,-10.9165,9.82285e-005],84.6662,1,0,[-0.389669,0.604631],"","",true,false],
	["O_Truck_02_box_F",[-484.8,-17.188,-0.00011158],84.6647,1,0,[-0.444202,0.843158],"","",true,false],
	["O_Heli_Transport_04_F",[-488.042,92.2856,-0.753341],359.83,1,0,[1.58399,23.3007],"","",true,false],
	["Sign_tape_redwhite",[492.384,128.235,0],0,1,0,[0,0],"","",true,false],
	["Windsock_01_F",[495.435,164.413,0],0,1,0,[0,0],"","",true,false],
	["C_IDAP_Truck_02_water_F",[-527.521,31.9287,-0.0058279],88.3326,1,0,[0.0147228,0.0283601],"","",true,false]
];

lesce_composition =/*
Grab data:
Mission: lesce_compo
World: panthera3
Anchor position: [8666, 4619.05]
Area size: 540
Using orientation of objects: yes
*/

[
	["C_IDAP_Heli_Transport_02_F",[37.6689,34.5469,-0.0520344],47.8364,1,0,[0.199289,9.02004e-005],"","",true,false],
	["C_Heli_Light_01_civil_F",[20.9033,49.5547,0.00467491],50.5305,1,0,[0.0881807,0.000294889],"","",true,false],
	["C_Heli_Light_01_civil_F",[8.21387,60.2446,0.00467682],48.9256,1,0,[0.0881788,0.000392186],"","",true,false],
	["C_Plane_Civil_01_F",[-10.1172,80.6304,-0.0494375],50.0853,1,0,[0.0179832,-0.002558],"","",true,false],
	["C_Plane_Civil_01_F",[-18.8027,90.979,-0.0490875],46.4557,1,0,[0.0191464,0.00299407],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[94.7861,69.0269,0],231.147,1,0,[0,0],"blubasepos","",true,false],
	["O_Heli_Light_02_dynamicLoadout_F",[34.7441,115.851,-0.12558],231.226,1,0,[3.03568,0.000162338],"","",true,false],
	["O_Truck_02_covered_F",[131.326,4.46533,-0.0150328],319.86,1,0,[-0.966902,0.0525303],"","",true,false],
	["O_Heli_Light_02_dynamicLoadout_F",[22.334,130.259,-0.12558],225.373,1,0,[3.03571,-6.83979e-005],"","",true,false],
	["O_Plane_CAS_02_dynamicLoadout_F",[131.886,27.0703,-0.132052],322.583,1,0,[0.849808,0.0185328],"","",true,false],
	["O_Plane_CAS_02_dynamicLoadout_F",[148.256,40.7002,-0.128244],322.58,1,0,[0.958118,1.73981e-005],"","",true,false],
	["O_Truck_02_fuel_F",[-17.4824,157.267,-0.00582123],227.293,1,0,[0.0143183,0.027758],"","",true,false],
	["Land_Turret_01_ruins_F",[84.7852,171.528,0],0,1,0,[0,0],"","",true,false],
	["O_Heli_Attack_02_dynamicLoadout_F",[-14.7969,205.514,0.0256767],230.719,1,0,[0.597062,-0.0516496],"","",true,false],
	["O_Heli_Attack_02_dynamicLoadout_F",[-32.7158,218.109,0.0256767],230.737,1,0,[0.597067,-0.0516482],"","",true,false],
	["O_Truck_02_box_F",[84.1621,204.174,-0.000103951],269.55,1,0,[-0.445675,0.859118],"","",true,false],
	["O_Truck_02_Ammo_F",[82.6699,218.718,-0.000115395],270.882,1,0,[-0.436421,0.782487],"","",true,false],
	["C_Van_02_transport_F",[-85.6904,243.388,-0.0704155],45.055,1,0,[0.0876247,-0.00196494],"","",true,false],
	["C_Offroad_01_repair_F",[-103.225,243.726,-0.0271749],141.572,1,0,[-0.592809,-0.0660276],"","",true,false]
];
boriana_composition =/*
Grab data:
Mission: boriana_comp
World: panthera3
Anchor position: [2210.4, 3453.95]
Area size: 540
Using orientation of objects: yes
*/

[
	["Land_Mil_hangar_ruins_EP1",[-9.12598,-45.7349,0],0,1,0,[0,0],"","",true,false],
	["C_Van_01_fuel_F",[-50.1516,-77.7197,-0.0318108],327.049,1,0,[-0.193318,0.163771],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[-216.303,-64.7935,0],0,1,0,[0,0],"blubasepos","",true,false],
	["O_Plane_Fighter_02_Stealth_F",[212.285,-90.083,-0.139135],343.607,1,0,[-1.09902,0.42382],"","",true,false],
	["I_Plane_Fighter_04_F",[-260.114,58.8862,0.0441651],0.00395813,1,0,[1.0921,0.338244],"","",true,false],
	["C_Plane_Civil_01_F",[-251.145,95.5293,-0.0490637],180.575,1,0,[0.0133606,-0.000589245],"","",true,false],
	["C_Van_02_medevac_F",[221.567,-169.465,-0.0740471],342.332,1,0,[-2.19726,2.72577],"","",true,false],
	["C_Plane_Civil_01_F",[-267.261,95.7976,-0.0491319],178.155,1,0,[0.0199649,0.000966661],"","",true,false],
	["C_IDAP_Offroad_02_unarmed_F",[-213.202,192.361,0.30673],0.238384,1,0,[14.3766,-8.12027],"","",true,false],
	["I_Plane_Fighter_04_F",[-283.409,59.6453,0.0027895],359.993,1,0,[1.7255,0.0958626],"","",true,false],
	["O_Plane_Fighter_02_Stealth_F",[308.915,-58.6418,-0.174496],336.638,1,0,[0.0323835,0.101907],"","",true,false],
	["I_Truck_02_fuel_F",[-280.693,148.784,-0.00589132],182.529,1,0,[0.0137747,0.0280767],"","",true,false],
	["C_Truck_02_box_F",[-289.074,148.735,-9.63211e-005],180.001,1,0,[-0.415075,0.683952],"","",true,false],
	["C_Truck_02_fuel_F",[-295.465,149.737,-0.0057373],180,1,0,[0.01474,0.0277878],"","",true,false],
	["C_Heli_Light_01_civil_F",[-317.713,124.029,0.00467968],180.757,1,0,[0.0882052,0.000843795],"","",true,false],
	["O_Heli_Light_02_dynamicLoadout_F",[343.59,-32.7021,-0.116968],359.808,1,0,[3.56709,-0.00215692],"","",true,false],
	["I_Heli_light_03_unarmed_F",[-312.447,148.206,-0.150549],187.592,1,0,[-0.00106065,-0.00101324],"","",true,false],
	["C_Van_02_service_F",[348.198,-53.8101,0.0641522],0.0255568,1,0,[1.78102,1.74931],"","",true,false],
	["C_Heli_Light_01_civil_F",[-329.809,124.708,0.00467157],177.193,1,0,[0.0883735,0.00106823],"","",true,false],
	["C_IDAP_Truck_02_F",[-330.227,149.866,-0.0148478],179.214,1,0,[-0.959781,0.0505256],"","",true,false],
	["C_IDAP_Truck_02_transport_F",[-336.151,149.481,-0.0149236],179.333,1,0,[-0.983905,0.0344987],"","",true,false],
	["O_Heli_Light_02_dynamicLoadout_F",[367.214,-32.5635,-0.117823],359.948,1,0,[3.58704,-0.00044046],"","",true,false],
	["C_IDAP_Offroad_02_unarmed_F",[-344.807,149.363,-0.0018115],177.048,1,0,[0.573661,-0.036604],"","",true,false],
	["BMP2Wreck",[211.906,-312.376,-0.00246429],0,1,0,[-1.56536,1.95648],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-360.209,116.6,-0.0520477],90.1325,1,0,[0.199294,6.14397e-005],"","",true,false],
	["Land_Wreck_Slammer_hull_F",[226.485,-309.378,-0.00354385],339.936,1,0,[-0.383879,0.161253],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-362.495,141.325,-0.0533791],85.5727,1,0,[0.208703,-0.00841502],"","",true,false],
	["Land_Wreck_Slammer_F",[240.163,-304.962,0.00751305],340.426,1,0,[-0.686657,0.769081],"","",true,false],
	["O_Heli_Light_02_dynamicLoadout_F",[388.825,-32.2925,-0.0764208],359.823,1,0,[6.57162,-0.011871],"","",true,false],
	["O_Truck_02_Ammo_F",[401.956,-52.5867,0.00230217],359.991,1,0,[0.295483,0.250807],"","",true,false],
	["O_Heli_Attack_02_dynamicLoadout_F",[454.875,-38.5693,0.0256772],0.021692,1,0,[0.597065,-0.0516539],"","",true,false],
	["C_Van_02_transport_F",[451.729,-73.6067,-0.0800195],0.0682021,1,0,[2.78605,-0.752563],"","",true,false],
	["C_Van_02_transport_F",[468.151,-71.9587,-0.0689979],360,1,0,[0.0811407,-0.00291333],"","",true,false],
	["O_Heli_Attack_02_dynamicLoadout_F",[477.315,-37.9146,0.0256691],0.0174261,1,0,[0.597222,-0.0506069],"","",true,false],
	["O_Boat_Armed_01_hmg_F",[470.746,-103.541,-0.932066],273.933,1,0,[0.587524,0.161095],"","",true,false],
	["O_Truck_02_fuel_F",[491.643,-27.6941,-0.0062747],266.892,1,0,[-0.0208237,0.0412566],"","",true,false],
	["T72WreckTurret",[533.486,-36.7009,0],0,1,0,[0,0],"","",true,false]
];
maleficio_composition = /*
Grab data:
Mission: maleficio_comp
World: panthera3
Anchor position: [2695, 8118.05]
Area size: 540
Using orientation of objects: yes
*/

[
	["Sign_Arrow_Direction_Blue_F",[28.4817,-22.3213,0.000793457],85.0553,1,0,[-1.48349,0.128373],"blubasepos","",true,false],
	["C_Offroad_01_repair_F",[31.6396,26.9619,-0.0239735],89.444,1,0,[-0.718217,-0.0513804],"","",true,false],
	["Snake_random_F",[46.7043,-17.3477,0.00838852],241.564,1,0,[0,0],"","",true,false],
	["Snake_random_F",[-19.188,46.4902,0.00835228],250.516,1,0,[0,0],"","",true,false],
	["C_Van_02_transport_F",[46.26,47.9863,-0.0689964],95.1169,1,0,[0.0811614,-0.00286495],"","",true,false],
	["C_Van_02_transport_F",[46.7053,53.1919,-0.0702438],94.4954,1,0,[0.0864855,-0.00208168],"","",true,false],
	["Land_fuel_tank_small",[31.1177,97.1338,1.90735e-006],89.1791,1,0,[0,0],"","",true,false],
	["Land_Fuel_tank_stairs",[29.0615,106.982,-0.0023365],268.357,1,0,[-3.31806,0.0952749],"","",true,false],
	["C_Truck_02_fuel_F",[38.2524,101.497,-0.00610542],87.9636,1,0,[-0.00336118,0.0340288],"","",true,false],
	["C_Truck_02_box_F",[37.8857,106.654,-0.000118256],87.4856,1,0,[-0.446107,0.864529],"","",true,false],
	["C_Heli_Light_01_civil_F",[122.447,34.7461,0.00468063],263.818,1,0,[0.0885325,-0.000232444],"","",true,false],
	["C_Heli_Light_01_civil_F",[122.826,48.4434,0.00466537],268.979,1,0,[0.0888304,6.20608e-005],"","",true,false],
	["C_Plane_Civil_01_racing_F",[44.0208,144.453,-0.0493088],87.2242,1,0,[0.0200408,-7.91608e-005],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[45.1921,166.548,-0.0537453],97.9172,1,0,[0.199296,6.20274e-005],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[46.9626,197.563,0.0860367],98.9772,1,0,[-2.09227,3.94688],"","",true,false]
];
vatra_composition = /*
Grab data:
Mission: vatra_composition
World: panthera3
Anchor position: [805, 9396.05]
Area size: 540
Using orientation of objects: yes
*/

[
	["C_Van_02_transport_F",[1.48132,22.21,-0.0689898],2.28613,1,0,[0.0805189,-0.0028951],"","",true,false],
	["C_Van_02_transport_F",[6.70166,21.9648,-0.0690002],2.90761,1,0,[0.0811617,-0.00286139],"","",true,false],
	["C_Van_02_service_F",[4.8327,48.2197,0.0846128],15.221,1,0,[-0.849978,-2.28543e-005],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[-69.4011,29.6113,0],273.436,1,0,[0,0],"blubasepos","",true,false],
	["C_Truck_02_box_F",[-36.1534,82.583,-0.000100136],275.603,1,0,[-0.430792,0.750635],"","",true,false],
	["C_Truck_02_fuel_F",[-35.7863,87.7412,-0.00611591],276.081,1,0,[-0.00588554,0.0344988],"","",true,false],
	["C_Heli_Light_01_civil_F",[-94.8584,-15.2725,0.00466251],270.911,1,0,[0.088867,-0.000253101],"","",true,false],
	["C_Heli_Light_01_civil_F",[-94.4089,-29.2139,0.00467777],270.91,1,0,[0.0882811,-0.000784205],"","",true,false],
	["O_Truck_02_box_F",[17.3499,101.414,2.76566e-005],0.000396136,1,0,[-0.402408,0.641957],"","",true,false],
	["C_Heli_Light_01_civil_F",[-95.121,-44.0771,0.00466251],270.909,1,0,[0.0888641,0.000253118],"","",true,false],
	["C_Heli_Light_01_civil_F",[-95.2006,-56.6641,0.00467777],270.908,1,0,[0.0880152,5.64153e-005],"","",true,false],
	["C_Van_01_transport_F",[-91.7853,-70.1406,0.00193501],0.00484485,1,0,[-1.44324,0.0466111],"","",true,false],
	["C_Van_01_fuel_F",[-99.7103,-69.4219,-0.03263],359.999,1,0,[-0.187854,-0.0308477],"","",true,false],
	["C_Plane_Civil_01_racing_F",[-138.006,90.5918,-0.0488701],87.2253,1,0,[0.0149753,-0.00494222],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-139.453,106.938,-0.0520363],97.9195,1,0,[0.199291,8.50077e-005],"","",true,false],
	["O_Heli_Transport_04_F",[-65.6989,164.073,-0.324085],268.267,1,0,[0.247984,-0.000103969],"","",true,false],
	["O_Heli_Transport_04_F",[-92.3791,161.339,-0.331387],264.572,1,0,[0.330075,-1.83764e-005],"","",true,false],
	["C_IDAP_Heli_Transport_02_F",[-140.5,141.134,-0.0558624],99.5109,1,0,[0.199316,2.79946e-005],"","",true,false],
	["O_Plane_Fighter_02_Stealth_F",[-63.2689,255.625,-0.141336],269.844,1,0,[0.00719876,0.0200399],"","",true,false],
	["O_Truck_03_fuel_F",[-54.2109,276.234,-0.0832396],269.231,1,0,[0.277664,-0.389213],"","",true,false],
	["O_Truck_03_medical_F",[82.6871,273.521,-0.000658989],0.000585622,1,0,[-0.395165,0.0145768],"","",true,false],
	["O_Plane_CAS_02_dynamicLoadout_F",[-65.6649,290.539,-0.0577621],178.083,1,0,[0.300317,0.0720651],"","",true,false],
	["O_Truck_03_repair_F",[-98.3295,289.505,-0.0105295],181.972,1,0,[-0.164433,0.0170943],"","",true,false],
	["O_Truck_03_ammo_F",[-103.897,289.204,-0.0522013],182.758,1,0,[-0.444395,0.0193606],"","",true,false]
];
fortieste_composition =
/*
Grab data:
Mission: fortieste_comp
World: panthera3
Anchor position: [2437, 587.05]
Area size: 500
Using orientation of objects: yes
*/

[
	["C_IDAP_Heli_Transport_02_F",[-9.49756,22.1304,-0.0520363],0.00239111,1,0,[0.199317,-2.32608e-005],"","",true,false],
	["C_Truck_02_box_F",[33.0159,7.02063,-8.01086e-005],359.999,1,0,[-0.448048,0.89654],"","",true,false],
	["C_Truck_02_transport_F",[49.0354,6.21173,-0.0156345],0.00187621,1,0,[-1.02008,0.0405848],"","",true,false],
	["O_Plane_CAS_02_dynamicLoadout_F",[-49.0862,11.3811,-0.0612736],138.478,1,0,[0.500295,-1.27753],"","",true,false],
	["O_Truck_02_Ammo_F",[-61.9421,10.8865,-2.95639e-005],179.489,1,0,[-0.426031,0.781048],"","",true,false],
	["O_Truck_02_fuel_F",[-66.4697,10.9069,-0.00611973],177.707,1,0,[-0.00680818,0.0388648],"","",true,false],
	["Windsock_01_F",[70.7122,8.89136,0],0,1,0,[0,0],"","",true,false],
	["C_Offroad_02_unarmed_F",[13.2847,78.0967,-0.0018177],273.238,1,0,[0.56358,-0.0349753],"","",true,false],
	["O_Plane_CAS_02_dynamicLoadout_F",[-81.7935,10.5059,-0.0560417],138.468,1,0,[0.176748,0.131856],"","",true,false],
	["C_Offroad_01_repair_F",[84.9622,36.4246,-0.0297203],0.00247012,1,0,[-0.581171,-0.0831248],"","",true,false],
	["C_Van_01_fuel_F",[-51.3638,-80.0967,-0.032321],46.9965,1,0,[-0.179521,-0.115701],"","",true,false],
	["Land_Turret_01_ruins_F",[-80.8792,-62.8741,0],0,1,0,[0,0],"","",true,false],
	["Sign_Arrow_Direction_Blue_F",[92.1189,-62.0046,0],0,1,0,[0,0],"blubasepos","",true,false],
	["O_Heli_Light_02_dynamicLoadout_F",[117.156,3.39233,-0.12571],177.304,1,0,[3.02999,-0.0195455],"","",true,false],
	["O_Heli_Light_02_dynamicLoadout_F",[140.485,3.76752,-0.12558],176.965,1,0,[3.03568,-0.000207077],"","",true,false]
];

enemyskillsarray =

	[
		[0.08,0.08,0.50,0.30,0.58,0.35,0.38,0.45,1,0.30],
		[0.10,0.10,0.55,0.35,0.60,0.38,0.40,0.50,1,0.40],
		[0.12,0.17,0.60,0.40,0.63,0.40,0.40,0.50,1,0.50],
		[0.15,0.20,0.65,0.45,0.65,0.42,0.45,0.55,1,0.55],
		[0.17,0.25,0.70,0.50,0.70,0.50,0.50,0.60,1,0.60]
	];

/*
Grab data:
Mission: blubasecomposition1
World: VR
Anchor position: [4100.87, 4141.57]
Area size: 100
Using orientation of objects: yes
*/
blubasecomposition =
[
	["Land_Sink_F",[0.486816,-1.14307,-1.43051e-006],360,1,0,[5.49883e-006,-1.07821e-006],"blubasesink","",true,false],
	["Land_New_WiredFence_5m_F",[-5.18945,1.52783,1.43051e-006],308.436,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-5.22852,-3.43457,1.43051e-006],270,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-2.09473,5.38965,1.43051e-006],0,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[2.86865,5.35889,1.43051e-006],43.94,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[-1.27051,-6.36133,1.43051e-006],215.785,1,0,[0,0],"","",true,false],
	["Land_BackAlley_01_l_1m_F",[-0.759766,-6.35791,0],0,1,0,[0,0],"","",true,false],
	["Land_BackAlley_01_l_gate_F",[1.34863,-6.37451,0],0,1,0,[0,0],"","",true,false],
	["FirePlace_burning_F",[-0.715332,6.78809,-9.53674e-007],0,1,0,[0,0],"","",true,false],
	["Land_New_WiredFence_5m_F",[6.49316,2.01172,1.43051e-006],91.343,1,0,[0,-0],"","",true,false],
	["Land_FireExtinguisher_F",[1.01953,6.8623,3.76701e-005],0.00164641,1,0,[-0.0223549,0.0110362],"","",true,false],
	["Land_MapBoard_F",[-6.39673,2.67969,-0.00223589],40.1669,1,0,[-0.327591,0.000336499],"blubasewhiteboard","",true,false],
	["Land_New_WiredFence_5m_F",[6.37744,-2.94043,1.43051e-006],135,1,0,[0,-0],"","",true,false],
	["Flag_UK_F",[-6.10522,-1.33643,0],0,1,0,[0,0],"baseflag","",true,false],
	["Land_Axe_fire_F",[1.0542,7.23242,-0.00336075],360,1,0,[-1.10131e-006,1.65981e-007],"","",true,false],
	["Land_Sign_WarningUnexplodedAmmo_F",[0.146484,7.61963,0],180,1,0,[0,0],"","",true,false],
	["Land_FieldToilet_F",[-0.76123,7.57422,2.38419e-006],180,1,0,[-0.000103487,-8.28959e-005],"","",true,false],
	["Land_Bollard_01_F",[-1.14404,-8.646,0],0,1,0,[0,0],"","",true,false],
	["Land_Bollard_01_F",[3.11328,-8.97852,0],0,1,0,[0,0],"","",true,false],
	["RoadCone_F",[-13.6731,-1.48682,4.29153e-006],359.996,1,0.00497283,[-0.00215818,-0.000724394],"ammoboxcone","",true,false],
	["Land_TripodScreen_01_large_F",[-9.68408,4.18994,5.8651e-005],180.009,1,0,[-0.00108395,-0.00255102],"blubasescreen","",true,false],
	["Land_Portable_generator_F",[-9.48071,5.25781,-0.000815868],0.00621269,1,0,[-0.00042304,0.226157],"","",true,false],
	["Land_Camping_Light_F",[-8.79224,-6.45703,-0.0132513],359.968,1,0,[-0.00215204,0.0667757],"","",true,false],
	["Land_PicnicTable_01_F",[-8.90088,-6.47314,0],0,1,0,[0,0],"","",true,false],
	["RoadCone_F",[-6.95508,9.58008,-3.8147e-006],0.00404258,1,0.00494835,[0.00190143,0.00267016],"terminalcone","",true,false],
	["Land_PortableLight_double_F",[9.56787,-6.34619,3],127.023,1,0,[0,-0],"","",true,false],
	["Land_Cargo_Patrol_V4_F",[11.605,2.07422,0],180,1,0,[0,0],"","",true,false],
	["Land_Medevac_house_V1_F",[11.6699,-6.43164,0],180,1,0,[0,0],"blubasemash","",true,false],
	["Land_PortableLight_double_F",[10.0347,7.68262,3],45.925,1,0,[0,0],"","",true,false],
	["Land_Cargo_House_V4_F",[11.6802,7.91064,0],0,1,0,[0,0],"","",true,false],
	["Land_LampHalogen_F",[-14.8652,-2.90723,-8],180,1,0,[0,0],"","",true,false],
	["PortableHelipadLight_01_white_F",[0.100098,19.4873,0],359.996,1,0,[-0.000763383,-0.00083898],"gg2","",true,false],
	["Land_JumpTarget_F",[0.0429688,25.0684,0],0,1,0,[0,0],"blubasehelipad","",true,false],
	["PortableHelipadLight_01_white_F",[-5.54614,25.0562,0],359.996,1,0,[-0.000763405,-0.000839073],"gg3","",true,false],
	["PortableHelipadLight_01_white_F",[5.60107,25.1157,0],359.996,1,0,[-0.000763405,-0.000839073],"gg1","",true,false],
	["PortableHelipadLight_01_white_F",[0.0537109,30.4941,0],359.994,1,0,[-0.00227563,0.00118212],"gg4","",true,false]
];
