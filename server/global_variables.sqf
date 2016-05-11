// global_variable.includes
//by tankbuster
islandcentre = getarray (configFile >> "CfgWorlds" >> "Altis" >> "centerPosition");

opfor_reinf_truck_soldier = "CUP_O_RU_Soldier_GL_EMR";
opfor_CQB_soldier = ["CUP_O_RUS_Soldier_TL_Autumn","CUP_O_RUS_SpecOps_Autumn","CUP_O_RUS_SpecOps_SD_Autumn","CUP_O_RUS_SpecOps_Night_Autumn","CUP_O_RUS_Saboteur_Autumn","CUP_O_RUS_Soldier_GL_Autumn","CUP_O_RUS_Soldier_Marksman_Autumn","CUP_O_RUS_Commander_Autumn","CUP_O_RUS_SpecOps_Scout_Night_Autumn","CUP_O_RUS_SpecOps_Scout_Night_Autumn","CUP_O_RUS_SpecOps_Scout_Autumn"];
opfor_reinf_truck =  "CUP_O_Ural_Open_RU";

opfor_reinf_helos = ["CUP_O_Mi8_SLA_1","CUP_O_Mi8_SLA_2","CUP_O_MI6T_RU","CUP_O_Mi8_medevac_RU"];

forwardpointvehicleclassname = "CUP_B_BAF_Coyote_L2A1_W";
fobvehicleclassname = "CUP_B_Mastiff_HMG_GB_W";
publicVariable "fobvehicleclassname";
blufordropaircraft = "CUP_B_C130J_GB";
cardinaldirs = ["north of ", "northeast of ", "east of ", "southeast of ", "south of ", "southwest of ", "west of ", "northwest of ", "north of "];

heartandmindscore = 0;
civkillcount = 0;
reinforcementcounter = 0;
captivekillcounter = 0;

prizes = ["CUP_B_Ridgback_GMG_GB_W","CUP_B_MCV80_GB_W_SLAT","CUP_B_MCV80_GB_W","CUP_B_Mastiff_GMG_GB_W","CUP_B_FV510_GB_W","CUP_B_FV510_GB_W_SLAT","CUP_B_FV432_Bulldog_GB_W_RWS","B_MBT_01_TUSK_F","B_MBT_01_cannon_F","CUP_B_FV432_Bulldog_GB_W"];
//aplandmines = ["ModuleMine_APERSBoundingMine_F"];
//aplandmines = ["ACE_Explosives_Place_APERSBoundingMine", "ACE_Explosives_Place_APERSMine"]; //APERSBoundingMine APERSMine ace from things/other << spawn at 000
aplandmines = ["APERSBoundingMine", "APERSMine" ]; // <--vanilla from weapons/explosives << spawn and explode but no defuse
civs = ["CUP_C_C_Worker_01","CUP_C_C_Worker_02","CUP_C_C_Worker_03","CUP_C_C_Worker_04","CUP_C_C_Rocker_02","CUP_C_C_Woodlander_04","CUP_C_C_Worker_05","CUP_C_C_Woodlander_01","CUP_C_C_Woodlander_02","CUP_C_C_Woodlander_03",
	   "CUP_C_C_Villager_01","CUP_C_C_Villager_02","CUP_C_C_Villager_03","CUP_C_C_Villager_04","CUP_C_C_Rocker_01","CUP_C_C_Profiteer_04","CUP_C_C_Citizen_01","CUP_C_C_Profiteer_03","CUP_C_C_Profiteer_02","CUP_C_C_Profiteer_01",
	   "CUP_C_C_Rocker_04","CUP_C_C_Rocker_03","CUP_C_C_Citizen_02","CUP_C_C_Citizen_03","CUP_C_C_Citizen_04","CUP_C_C_Mechanic_01","CUP_C_C_Woodlander_02","CUP_C_C_Mechanic_02","CUP_C_C_Mechanic_03","C_man_1","C_man_1_1_F",
	   "C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F",
	   "C_man_polo_3_F_afro","C_man_polo_3_F_euro","C_man_polo_3_F_asia","C_man_polo_4_F","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","C_man_polo_5_F_afro","C_man_polo_5_F_euro",
	   "C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F","C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia",
	   "C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro",
	   "C_man_p_shorts_1_F_asia","C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F","C_man_shorts_2_F_afro","C_man_shorts_2_F_euro","C_man_shorts_2_F_asia",
	   "C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro","C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro","C_man_shorts_4_F_euro","C_man_shorts_4_F_asia"];// all the civs apart from named and stpry related ones

civcars =["C_Offroad_01_F","C_Offroad_luxe_F", "C_Offroad_01_sand_F", "C_Offroad_stripped_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Van_01_fuel_F",
		 "CUP_C_Datsun_Covered","CUP_C_Ural_Civ_03","CUP_C_Ural_Civ_02","CUP_C_Ural_Open_Civ_02","CUP_C_SUV_CIV","CUP_C_Ural_Open_Civ_01","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_Golf4_white_Civ",
		 "CUP_C_Golf4_yellow_Civ","CUP_C_Golf4_random_Civ","CUP_C_Octavia_CIV","CUP_C_Ural_Civ_01","CUP_C_Datsun_4seat","CUP_C_Datsun","CUP_C_Skoda_White_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_Green_CIV",
		 "CUP_C_Skoda_Blue_CIV","CUP_C_Golf4_red_Civ","CUP_C_Golf4_green_Civ","CUP_C_Golf4_blue_Civ","CUP_C_Golf4_black_Civ"];

opforpatrollandvehicles = ["CUP_O_BMP2_RU", "CUP_O_BMP3_RU", "CUP_O_BTR90_RU", "CUP_O_GAZ_Vodnik_AGS_RU", "CUP_O_GAZ_Vodnik_BPPU_RU", "CUP_O_Ural_ZU23_RU", "CUP_O_UAZ_MG_RU", "CUP_O_UAZ_METIS_RU", "CUP_O_BRDM2_SLA"];
opforstaticlandvehicles =["CUP_O_Ural_ZU23_RU", "CUP_O_BM21_RU", "CUP_O_2S6M_RU"];
opforradartypes = ["CUP_A2_76n6_clamshell_lower", "CUP_A2_76n6_clamshell_ep1"];
opfortanks = ["CUP_O_T55_TK", "CUP_O_T72_RU"];

aaccomposition = [
	["Land_HelipadCircle_F",[106.138,18.7334,0],0,1,0,[0.763851,7.67037],"","",true,false],
	["Land_BagBunker_Large_F",[26.9893,-115.696,-0.0723171],322.314,1,0,[8.16878,-1.09966],"","",true,false],
	["Land_HelipadCircle_F",[123.296,48.0117,0.000209808],0,1,0,[1.06935,3.66254],"","",true,false],
	["CUP_O_Ka50_RU",[123.25,48.251,-0.0628223],294.47,1,0,[3.90467,-0.826065],"","",true,false],
	["Land_HelipadCircle_F",[139.813,70.2412,0],0,1,0,[6.6921,1.61488],"","",true,false],
	["CUP_O_Mi8_RU",[141.061,67.874,-0.317122],322.108,1,0,[8.64723,1.95406],"","",true,false],
	["Land_i_Barracks_V1_F",[-12.8525,190.463,0],305.446,1,0,[0,0],"","",true,false],
	["Land_HelipadCircle_F",[163.164,107.263,1.90735e-006],0,1,0,[2.44312,0.535335],"","",true,false],
	["CUP_O_Mi24_P_RU",[164.203,106.499,-0.381065],316.619,1,0,[6.15434,-0.181899],"","",true,false],
	["Windsock_01_F",[138.371,193.98,0.000293732],0,1,0,[0,0],"","",true,false],
	["ContainmentArea_01_sand_F",[132.301,212.78,-0.0484409],211.289,1,0,[1.03278,0.359714],"","",true,false],
	["StorageBladder_01_fuel_forest_F",[132.202,212.896,-0.000579834],30.3412,1,0,[-1.03858,-0.342582],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[136.939,220.049,0.043047],121.643,1,0,[0.178268,0.0607311],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[141.04,225.385,0.0524292],125.246,1,0,[0.0729474,-0.765886],"","",true,false],
	["CUP_O_MI6T_RU",[114.397,248.326,-0.182419],325.145,1,0,[3.99541,-0.239035],"","",true,false],
	["Land_ClutterCutter_large_F",[96.9092,271.65,0],0,1,0,[-0.228997,0.151949],"","",true,false],
	["Land_HelipadCircle_F",[97.0176,271.803,0],0,1,0,[-0.228997,0.151949],"","",true,false],
	["Land_Wreck_BMP2_F",[20.4365,294.771,0.0716591],0,1,0,[1.52752,3.6632],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[226.103,199.555,0.044363],173.577,1,0,[-0.103712,0.067147],"","",true,false],
	["CUP_O_Su25_RU_1",[142.465,283.059,-0.286406],116.393,1,0,[0.0331826,-0.239177],"","",true,false],
	["CUP_O_Su25_RU_1",[258.51,186.508,-0.286814],233.191,1,0,[-0.198542,-0.137437],"","",true,false],
	["Land_HelipadCircle_F",[242.721,210.141,0],0,1,0,[0.151948,-0.076617],"","",true,false],
	["CUP_O_Su25_RU_1",[275.501,212.478,-0.287788],218.727,1,0,[-0.429017,0.0471642],"","",true,false],
	["CUP_O_UAZ_Open_RU",[124.614,325.696,0.0161381],116.627,1,0,[0.0329077,-0.204903],"","",true,false],
	["Land_BagBunker_Small_F",[257.51,236.387,-0.00294876],0,1,0,[0.30519,-0.0766178],"","",true,false],
	["Land_Cargo_Tower_V1_No1_F",[179.239,307.16,0],326.702,1,0,[0,0],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[130.758,330.347,0.0448475],122.056,1,0,[-0.0594779,-0.13136],"","",true,false],
	["Land_LampAirport_F",[285.452,230.627,-0.000343323],0,1,0,[0,0],"","",true,false]
];
abderacomposition = [
	["CUP_O_Ural_Open_RU",[39.8223,22.0195,0.0717316],327.707,1,0,[-0.360478,-0.833786],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[48.4814,24.5586,0.0364666],325.219,1,0,[-0.381948,-0.277372],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-32.8154,59.457,0.0510788],144.283,1,0,[0.812499,-0.141882],"","",true,false],
	["Land_ClutterCutter_large_F",[55.1709,39.7734,0],0,1,0,[-0.305187,0],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-39.0146,56.6602,0.044445],146.312,1,0,[1.33324,-0.344837],"","",true,false],
	["CUP_O_Ka52_RU",[55.7266,41.7188,-0.3253],294.545,1,0,[0.0825811,0.631407],"","",true,false],
	["Land_HelipadCircle_F",[56.0938,42.0195,0],0,1,0,[-0.305187,0],"","",true,false],
	["StorageBladder_01_fuel_forest_F",[-47.9453,51.2773,0.000495911],240.594,1,0,[0.412574,0.731992],"","",true,false],
	["ContainmentArea_01_forest_F",[-48.2422,51.1309,-0.0491343],238.773,1,0,[0.43562,0.718517],"","",true,false],
	["Windsock_01_F",[-20.6621,67.5801,0.000440598],0,1,0,[0,0],"","",true,false],
	["CUP_O_Su25_RU_3",[-65.3691,39.8008,-0.282625],141.847,1,0,[1.02054,0.557782],"","",true,false],
	["Land_LampAirport_F",[-42.7041,64.2871,0],0,1,0,[0,0],"","",true,false],
	["CUP_O_Su25_RU_3",[-83.3984,24.2637,-0.285616],139.661,1,0,[-0.584145,-0.806769],"","",true,false],
	["CUP_O_Ural_Open_RU",[-96.5635,-4.12891,0.0850849],90.0997,1,0,[-1.66803,-1.41215],"","",true,false],
	["CUP_O_Ural_Open_RU",[-96.5342,-11.5723,0.0758171],90.6319,1,0,[-1.81114,-1.28078],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.428,-6.58203,0.0327854],359.982,1,0,[-1.22221,2.82387],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.514,-8.49023,0.032795],359.982,1,0,[-1.22224,2.82385],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.655,-10.4648,0.0328808],359.985,1,0,[-1.22313,2.82399],"","",true,false],
	["Box_IND_AmmoVeh_F",[-103.613,-12.7559,0.034935],359.993,1,0.0041993,[-0.282007,1.60623],"","",true,false],
	["Box_IND_AmmoVeh_F",[-105.73,-4.45898,0.0335197],359.969,1,0,[-2.06159,2.82377],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.131,-6.64648,0.0328617],359.982,1,0,[-1.22224,2.82382],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.218,-8.55469,0.0328941],359.994,1,0.00418754,[-1.22174,2.82485],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.357,-10.5293,0.0311947],0.00817988,1,0,[-0.00011252,1.60445],"","",true,false],
	["Box_IND_AmmoVeh_F",[-106.315,-12.8203,0.0355129],0.0118727,1,0.00607929,[-0.321389,1.60765],"","",true,false],
	["CUP_A2_controltower",[-32.0117,106.676,0],326.272,1,0,[1.0179,1.52448],"","",true,false],
	["Land_BagBunker_Small_F",[100.525,75.6563,0.027071],0,1,0,[-2.67181,0.917626],"","",true,false],
	["CUP_O_Mi8_medevac_RU",[-134.124,-34.9824,-0.510679],324.69,1,0,[4.57287,0.0875166],"","",true,false],
	["Land_HelipadCircle_F",[-135.376,-32.6211,4.3869e-005],0,1,0,[0.382043,0.228998],"","",true,false],
	["CUP_O_Ural_RU",[-137.464,-52.541,0.0700035],130.245,1,0,[0.106754,0.100125],"","",true,false],
	["CUP_O_Ural_RU",[-141.824,-56.8438,0.0699711],128.243,1,0,[0.121105,-0.0232019],"","",true,false],
	["Land_Cargo20_light_green_F",[-149.799,-44.1582,0.00126457],223.275,1,0,[-1.37086,1.12245],"","",true,false],
	["CUP_O_UAZ_Unarmed_RU",[-145.977,-63.2715,0.0184822],124.905,1,0,[0.0694854,-1.61784],"","",true,false],
	["Land_Cargo20_cyan_F",[-153.53,-48.957,-0.0094986],216.906,1,0,[1.48116,1.21881],"","",true,false],
	["Land_Cargo40_yellow_F",[-155.625,-59.041,-0.0202179],221.727,1,0,[-1.46924,1.31171],"","",true,false],
	["Land_Cargo_Tower_V1_No1_F",[85.0098,146.002,0],326.702,1,0,[0,0],"","",true,false],
	["Land_Wreck_BMP2_F",[127.075,129.035,-0.00849247],0,1,0,[-1.29845,0],"","",true,false],
	["Land_Wreck_BRDM2_F",[230.077,10.8496,-0.0233746],0,1,0,[-1.37473,-1.98601],"","",true,false],
	["Land_BagBunker_Large_F",[-151.681,-208.986,0.00858688],322.645,1,0,[-0.835742,0.541573],"","",true,false]
];
almyracomposition = [
	["Windsock_01_F",[43.8164,-4.88672,3.29018e-005],0,1,0,[0,0],"","",true,false],
	["CUP_A2_controltower",[57.6855,-22.6836,0],92.1185,1,0,[0,-0],"","",true,false],
	["Land_LampAirport_F",[61.4395,5.03906,-5.91278e-005],0,1,0,[0,0],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-72.8574,50.1758,0.043644],268.894,1,0,[-0.0356887,-0.0219181],"","",true,false],
	["CUP_O_Su25_RU_2",[-92.7676,8.27344,-0.286222],90.287,1,0,[0,-0],"","",true,false],
	["CUP_O_Su25_RU_3",[-94.9629,-40.7695,-0.286222],90.287,1,0,[0,-0],"","",true,false],
	["Land_LampAirport_F",[-107.488,-17.1816,0],0,1,0,[0,0],"","",true,false],
	["Land_TentHangar_V1_F",[-116.482,7.45313,0],90.548,1,0,[0,-0],"","",true,false],
	["C_Heli_Light_01_civil_F",[-114.531,39.6563,0.00472045],87.0878,1,0,[0.0887142,0.00402614],"","",true,false],
	["CUP_O_Ka52_RU",[74.7773,95.918,-0.323184],129.293,1,0,[0.394459,0.354683],"","",true,false],
	["Land_TentHangar_V1_F",[-116.482,-39.0684,0],90.548,1,0,[0,-0],"","",true,false],
	["CUP_O_Su25_RU_2",[-39.8398,119.707,-0.284737],90,1,0,[0,-0],"","",true,false],
	["CUP_C_DC3_CIV",[-112.414,70.7637,-0.788926],89.7,1,0,[0,0],"","",true,false],
	["Land_Wreck_BRDM2_F",[122.553,68.6348,0.020782],0,1,0,[0,0],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-74.6895,134.588,0.0432806],270.25,1,0,[-0.0357209,-0.0222364],"","",true,false],
	["CUP_O_Mi8_RU",[74.6133,135.619,-0.514169],155.999,1,0,[4.16036,0.0524877],"","",true,false],
	["CUP_C_DC3_CIV",[-116.365,114.494,-0.788923],92.9401,1,0,[0,-0],"","",true,false],
	["CUP_O_Su25_RU_2",[-38.9785,170.313,-0.28541],90,1,0,[0,-0],"","",true,false],
	["CUP_O_Mi8_RU",[78.998,175.607,-0.514153],155.945,1,0,[4.16024,0.054269],"","",true,false],
	["CUP_O_Ural_Open_RU",[-82.7129,199.211,0.0694757],157.746,1,0,[-0.00598753,0.0188389],"","",true,false],
	["CUP_O_Ural_Open_RU",[91.0195,212.795,0.0690374],90.5964,1,0,[-0.00598597,0.0196373],"","",true,false],
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
	["CUP_O_Ural_Open_RU",[94.8438,239.754,0.0690432],90.0567,1,0,[-0.0059803,0.0195684],"","",true,false],
	["CUP_O_UAZ_Unarmed_RU",[98.4141,280.283,0.0173485],124.898,1,0,[0.0930779,-0.0674636],"","",true,false],
	["CUP_O_Ural_RU",[102.566,286.705,0.0695701],128.245,1,0,[-0.00594467,0.0190825],"","",true,false],
	["Land_Cargo20_cyan_F",[90.8613,294.586,3.33786e-006],216.882,1,0,[-0.000155806,-1.05413e-005],"","",true,false],
	["CUP_O_Ural_RU",[106.924,291.012,0.0695701],130.244,1,0,[-0.00592909,0.0188387],"","",true,false],
	["Land_Cargo20_light_green_F",[94.5918,299.395,3.8147e-006],223.283,1,0,[-0.000152812,-9.36303e-006],"","",true,false]
];
ferescomposition = ["CUP_O_Mi24_V_RU",[-21.7285,-61.2485,-0.499146],36.0262,1,0,[2.39412,1.11083],"","",true,false],
	["CUP_O_Ka52_RU",[-58.1602,-31.4751,-0.299498],37.5082,0.999999,0,[2.62054,1.04248],"","",true,false],
	["CUP_A1_fuelstation",[-81.3398,-6.37012,-0.0143127],303.32,1,0,[-0.983411,1.91253],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-87.3926,3.77637,0.0693855],30.1272,1,0,[-3.90584,-0.244858],"","",true,false],
	["CUP_O_Ural_Open_RU",[-49.4453,76.1406,0.0799313],130.266,1,0,[-2.22786,-1.50135],"","",true,false],
	["Land_ClutterCutter_large_F",[-32.8906,85.5923,-0.000204086],0,1,0,[-0.840233,0.687618],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-92.5801,6.80762,0.112064],30.1365,1,0,[-4.347,-0.375413],"","",true,false],
	["Land_ClutterCutter_large_F",[-37.998,85.2236,3.8147e-006],0,1,0,[-0.382061,-0.0766184],"","",true,false],
	["Land_ClutterCutter_large_F",[-25.5586,92.8794,0],0,1,0,[-0.305187,0.916642],"","",true,false],
	["CUP_O_Su25_RU_1",[-41.3125,90.0674,-0.287237],299.998,1,0,[-0.372177,0.49066],"","",true,false],
	["Land_ClutterCutter_large_F",[-49.8281,88.7979,0],0,1,0,[-1.98544,1.91031],"","",true,false],
	["Land_ClutterCutter_large_F",[-41.4375,94.1357,8.01086e-005],0,1,0,[-0.534491,0.151955],"","",true,false],
	["Land_ClutterCutter_large_F",[-13.2891,103.817,0],0,1,0,[-1.45118,2.4439],"","",true,false],
	["CUP_O_Su25_RU_1",[-23.6523,105.147,-0.282288],299.993,1,0,[1.1381,-0.13741],"","",true,false],
	["CUP_O_Ural_RU",[-108.094,16.7349,0.0752487],51.4093,1,0,[-4.67033,-0.120333],"","",true,false],
	["Land_ClutterCutter_large_F",[-37.1074,103.849,0],0,1,0,[-0.840233,0.611084],"","",true,false],
	["Land_ClutterCutter_large_F",[-14.3398,110.511,0.00031662],0,1,0,[2.21434,3.81692],"","",true,false],
	["Land_ClutterCutter_large_F",[-45.0645,102.663,0],0,1,0,[-0.151951,0.687546],"","",true,false],
	["Land_ClutterCutter_large_F",[-29.7695,110.613,0],0,1,0,[2.44312,-2.21636],"","",true,false],
	["Land_ClutterCutter_large_F",[-7.56641,117.45,0.00053978],0,1,0,[-1.29845,4.95451],"","",true,false],
	["Land_ClutterCutter_large_F",[-26.9668,115.217,0],0,1,0,[3.58581,-0.229446],"","",true,false],
	["CUP_O_Su25_RU_3",[-2.3125,121.465,-0.276093],300.074,1,0,[2.10827,2.45531],"","",true,false],
	["Land_Cargo20_cyan_F",[-120.939,12.6782,-0.000827789],216.869,1,0,[-0.846965,-1.06004],"","",true,false],
	["Box_IND_AmmoVeh_F",[-118.693,26.6958,0.0489502],359.975,1,0.00716227,[-5.3373,2.16986],"","",true,false],
	["Box_IND_AmmoVeh_F",[-118.553,28.6558,0.0364342],359.996,1,0.00408736,[-4.42514,2.13922],"","",true,false],
	["Box_IND_AmmoVeh_F",[-118.469,30.564,0.0364933],359.997,1,0.00407237,[-4.42389,2.13941],"","",true,false],
	["Box_IND_AmmoVeh_F",[-121.273,28.5933,0.0565357],0.0315076,1,0.00837919,[-5.78278,2.34601],"","",true,false],
	["Box_IND_AmmoVeh_F",[-121.17,30.4995,0.0363655],359.996,1,0,[-4.42243,2.13754],"","",true,false],
	["Box_IND_AmmoVeh_F",[-120.77,32.6787,0.0445271],0.0139801,1,0.00673903,[-3.81103,2.13661],"","",true,false],
	["Land_Cargo40_yellow_F",[-126.107,11.6836,0.0239601],221.751,1,0,[-2.09587,1.08039],"","",true,false],
	["Windsock_01_F",[-138.24,7.39893,0.00202179],0,1,0,[0,0],"","",true,false],
	["Land_ClutterCutter_large_F",[15.3555,138.686,0],0,1,0,[-1.45118,3.35859],"","",true,false],
	["Land_ClutterCutter_large_F",[-1.76367,148.296,0.000352859],0,1,0,[-2.44312,1.6818],"","",true,false],
	["Land_ClutterCutter_large_F",[26.1602,146.176,0],0,1,0,[0.687544,5.18103],"","",true,false],
	["CUP_O_Ural_Open_RU",[-132.537,69.2817,0.123629],128.214,1,0,[2.27743,-2.81632],"","",true,false],
	["Land_ClutterCutter_large_F",[8.44531,150.293,0],0,1,0,[-2.74809,2.59861],"","",true,false],
	["Land_Cargo20_light_green_F",[-139.461,64.4033,0.0780182],223.354,1,0,[0.652736,0.376997],"","",true,false],
	["Windsock_01_F",[-145.68,54.8486,0.00440025],0,1,0,[0,0],"","",true,false],
	["Land_Wreck_BRDM2_F",[-117.813,105.424,-0.0580921],0,1,0,[-2.4432,-2.90313],"","",true,false],
	["Land_ClutterCutter_large_F",[16.7852,158.677,0],0,1,0,[-2.29064,1.75787],"","",true,false],
	["Land_Wreck_BMP2_F",[-76.9316,148.053,0.0259361],0,1,0,[-0.764127,-4.65024],"","",true,false],
	["Land_LampAirport_F",[-158.838,58.9468,0],171.175,1,0,[0,-0],"","",true,false],
	["Land_LampAirport_F",[-203.287,-65.4473,0],0,1,0,[0,0],"","",true,false]
];

moloscomposition = [
	["CUP_O_Su25_RU_3",[-80.6563,-50.9492,-0.274382],155.125,1,0,[2.85657,-0.735189],"","",true,false],
	["Land_Wreck_BMP2_F",[-112.895,-17.2773,-0.224667],0,1,0,[-6.01298,-3.37601],"","",true,false],
	["CUP_O_Su25_RU_3",[-99.1836,-59.3027,-0.277388],155.149,1,0,[2.96131,1.49123],"","",true,false],
	["CUP_O_Su25_RU_3",[-120.143,-68.5273,-0.27459],155.149,1,0,[2.96131,1.49123],"","",true,false],
	["Land_Wreck_BRDM2_F",[-152.969,-3.88477,0.406794],0,1,0,[14.6457,9.62061],"","",true,false],
	["CUP_O_Ka52_RU",[-104.354,-118.078,-0.312763],307.185,1,0,[-0.942659,1.3417],"","",true,false],
	["Land_HelipadCircle_F",[-105.119,-117.908,0],0,1,0,[-1.8328,-0.152029],"","",true,false],
	["CUP_O_Ural_Open_RU",[-145.656,-80.4805,0.0760002],90.0635,1,0,[-0.156356,-2.38258],"","",true,false],
	["CUP_O_Ural_RU",[-156,-60.9277,0.0812302],130.203,1,0,[2.33035,-1.01581],"","",true,false],
	["Land_LampAirport_F",[-163.246,-45.5156,0.0169506],0,1,0,[0,0],"","",true,false],
	["CUP_O_Ural_Open_RU",[-145.629,-87.9219,0.0634518],90.5988,1,0,[0.499783,-0.911793],"","",true,false],
	["CUP_O_Ural_RU",[-160.359,-65.2324,0.0739212],128.215,1,0,[2.02486,-0.639372],"","",true,false],
	["Box_IND_AmmoVeh_F",[-152.527,-82.9453,0.0193329],359.966,1,0.00556745,[-1.91247,-0.22846],"","",true,false],
	["Box_IND_AmmoVeh_F",[-152.613,-84.8418,0.0306549],359.997,1,0,[-0.687391,-0.23039],"","",true,false],
	["Box_IND_AmmoVeh_F",[-152.758,-86.8164,0.0346222],0.00224861,1,0.00563479,[-0.983677,-0.224185],"","",true,false],
	["Box_IND_AmmoVeh_F",[-155.229,-83.0117,0.0201378],0.0334162,1,0.00528144,[-1.82545,-0.069883],"","",true,false],
	["Land_Cargo20_light_green_F",[-168.336,-52.541,0.00222969],223.315,1,0,[1.91699,1.18023],"","",true,false],
	["Box_IND_AmmoVeh_F",[-155.316,-84.9063,0.0329514],0.0377362,1,0.00495755,[-0.873537,0.0289168],"","",true,false],
	["Box_IND_AmmoVeh_F",[-155.457,-86.8809,0.0307674],359.997,1,0,[-0.993076,0.0753543],"","",true,false],
	["CUP_O_UAZ_Unarmed_RU",[-164.506,-71.6504,0.0237827],124.838,1,0,[2.16168,-3.19318],"","",true,false],
	["Land_Cargo20_cyan_F",[-172.078,-57.3574,0.0272083],216.884,1,0,[1.01682,0.242413],"","",true,false],
	["Land_Cargo40_yellow_F",[-177.115,-62.3379,-0.00559044],221.789,1,0,[3.27852,-0.628624],"","",true,false],
	["CUP_O_Ka52_RU",[-131.668,-149.215,-0.32061],307.219,1,0,[-1.20547,1.21661],"","",true,false],
	["Land_HelipadCircle_F",[-131.365,-151.135,0],0,1,0,[-1.75658,-0.687888],"","",true,false],
	["Windsock_01_F",[-172.641,-117.252,0.00419426],0,1,0,[0,0],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-180.295,-172.031,0.0718479],39.8011,1,0,[0.633993,-2.82812],"","",true,false],
	["CUP_O_Ural_Refuel_RU",[-162.969,-192.512,0.0498848],39.8504,1,0,[0.996838,-2.50578],"","",true,false],
	["CUP_A1_fuelstation_army",[-173.096,-187.109,0.00758362],310.434,1,0,[-2.36845,0.188721],"","",true,false],
	["Land_LampAirport_F",[-235.518,-164.662,0],0,1,0,[0,0],"","",true,false],
	["Land_u_Shed_Ind_F",[-209.4,-200.521,0.0594063],130,1,0,[0,-0],"","",true,false],
	["Land_Shed_Big_F",[-192.328,-206.357,0.0636578],220,1,0,[0,0],"","",true,false],
	["Land_i_Shed_Ind_F",[-230.998,-183.521,0.0666714],130,1,0,[0,-0],"","",true,false],
	["Land_ReservoirTank_Airport_F",[-271.477,-143.178,0.00749207],0,1,0,[0,0],"","",true,false]
];