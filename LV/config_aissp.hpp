class config_aissp
{
	class settings
	{
		//TODO: something fancy
	};
	class classPresets
	{
		
		///CUSTOM CLASSES - You can copy-paste more customClasses and fill them as you will
		class customClass1
		{
			side = 1; //0 = CIV, 1 = BLU, 2 = OPF, 3 = IND
			men[] = {""};
			men2[] = {""};
			men3[] = {""};
			menSF[] = {""};
			divers[] = {""};
			cars[] = {""};
			tanks[] = {""};
			helicopters[] = {""};
			planes[] = {""};
			ships[] = {""};
		};
		
		//DEFAULT TEMPLATES. Modify only if you know what you do.
		class CIV
		{
			side = 0;
			cars[] = {"C_Offroad_01_F","C_Offroad_01_repair_F","C_Offroad_01_red_F","C_Offroad_01_sand_F","C_Offroad_01_white_F","C_Offroad_01_blue_F","C_Offroad_01_darkred_F","C_Offroad_01_bluecustom_F","C_Offroad_luxe_F","C_Offroad_default_F","C_Offroad_stripped_F","C_Quadbike_01_F","C_Quadbike_01_black_F","C_Quadbike_01_blue_F","C_Quadbike_01_red_F","C_Quadbike_01_white_F","C_Truck_02_covered_F","C_Truck_02_transport_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Hatchback_01_grey_F","C_Hatchback_01_green_F","C_Hatchback_01_blue_F","C_Hatchback_01_bluecustom_F","C_Hatchback_01_beigecustom_F","C_Hatchback_01_yellow_F","C_Hatchback_01_white_F","C_Hatchback_01_black_F","C_Hatchback_01_dark_F","C_Hatchback_01_sport_red_F","C_Hatchback_01_sport_blue_F","C_Hatchback_01_sport_orange_F","C_Hatchback_01_sport_white_F","C_Hatchback_01_sport_grey_F","C_Hatchback_01_sport_green_F","C_SUV_01_F","SUV_01_base_red_F","SUV_01_base_black_F","SUV_01_base_grey_F","SUV_01_base_orange_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_01_fuel_F","C_Van_01_transport_white_F","C_Van_01_transport_red_F","C_Van_01_box_white_F","C_Van_01_box_red_F","C_Van_01_fuel_white_F","C_Van_01_fuel_red_F","C_Van_01_fuel_white_v2_F","C_Van_01_fuel_red_v2_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_black_F","C_Offroad_02_unarmed_blue_F","C_Offroad_02_unarmed_green_F","C_Offroad_02_unarmed_orange_F","C_Offroad_02_unarmed_red_F","C_Offroad_02_unarmed_white_F"};
			helicopters[] = {"C_Heli_Light_01_civil_F","C_Heli_light_01_blue_F","C_Heli_light_01_red_F","C_Heli_light_01_ion_F","C_Heli_light_01_blueLine_F","C_Heli_light_01_digital_F","C_Heli_light_01_elliptical_F","C_Heli_light_01_furious_F","C_Heli_light_01_graywatcher_F","C_Heli_light_01_jeans_F","C_Heli_light_01_light_F","C_Heli_light_01_shadow_F","C_Heli_light_01_sheriff_F","C_Heli_light_01_speedy_F","C_Heli_light_01_sunset_F","C_Heli_light_01_vrana_F","C_Heli_light_01_wasp_F","C_Heli_light_01_wave_F","C_Heli_light_01_stripped_F","C_Heli_light_01_luxe_F"};
			planes[] = {"C_Plane_Civil_01_F","C_Plane_Civil_01_racing_F"};
			ships[] = {"C_Rubberboat","C_Boat_Civil_01_F","C_Boat_Civil_01_rescue_F","C_Boat_Civil_01_police_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F"};
			men[] = {"Civilian_F","C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F","C_man_polo_3_F_afro","C_man_polo_3_F_euro","C_man_polo_3_F_asia","C_man_polo_4_F","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","C_man_polo_5_F_afro","C_man_polo_5_F_euro","C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F","C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia","C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_w_worker_F","C_scientist_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro","C_man_p_shorts_1_F_asia","C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F","C_man_shorts_2_F_afro","C_man_shorts_2_F_euro","C_man_shorts_2_F_asia","C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro","C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro","C_man_shorts_4_F_euro","C_man_shorts_4_F_asia","C_man_pilot_F","C_journalist_F","C_Orestes","C_Nikos","C_Nikos_aged","C_Marshal_F","C_man_sport_1_F","C_man_sport_1_F_afro","C_man_sport_1_F_euro","C_man_sport_1_F_asia","C_man_sport_1_F_tanoan","C_man_sport_2_F","C_man_sport_2_F_afro","C_man_sport_2_F_euro","C_man_sport_2_F_asia","C_man_sport_2_F_tanoan","C_man_sport_3_F","C_man_sport_3_F_afro","C_man_sport_3_F_euro","C_man_sport_3_F_asia","C_man_sport_3_F_tanoan","C_Man_casual_1_F","C_Man_casual_1_F_afro","C_Man_casual_1_F_euro","C_Man_casual_1_F_asia","C_Man_casual_1_F_tanoan","C_Man_casual_2_F","C_Man_casual_2_F_afro","C_Man_casual_2_F_euro","C_Man_casual_2_F_asia","C_Man_casual_2_F_tanoan","C_Man_casual_3_F","C_Man_casual_3_F_afro","C_Man_casual_3_F_euro","C_Man_casual_3_F_asia","C_Man_casual_3_F_tanoan","C_Man_casual_4_F","C_Man_casual_4_F_afro","C_Man_casual_4_F_euro","C_Man_casual_4_F_asia","C_Man_casual_4_F_tanoan","C_Man_casual_5_F","C_Man_casual_5_F_afro","C_Man_casual_5_F_euro","C_Man_casual_5_F_asia","C_Man_casual_5_F_tanoan","C_Man_casual_6_F","C_Man_casual_6_F_afro","C_Man_casual_6_F_euro","C_Man_casual_6_F_asia","C_Man_casual_6_F_tanoan","C_Man_French_universal_F"};
		};
		class BLU_CTRG
		{
			side = 1;
			cars[] = {"B_CTRG_LSV_01_light_F"};
			helicopters[] = {"B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F"};
			men[] = {"B_CTRG_Soldier_F","B_CTRG_Soldier_2_F","B_CTRG_Soldier_3_F","B_CTRG_Soldier_TL_tna_F","B_CTRG_Soldier_Exp_tna_F","B_CTRG_Soldier_Medic_tna_F","B_CTRG_Soldier_M_tna_F","B_CTRG_Soldier_tna_F","B_CTRG_Soldier_LAT_tna_F","B_CTRG_Soldier_AR_tna_F","B_CTRG_Soldier_JTAC_tna_F","B_CTRG_Miller_F","B_CTRG_Soldier_urb_1_F","B_CTRG_Soldier_urb_2_F","B_CTRG_Soldier_urb_3_F"};
		};
		class BLU_F
		{
			side = 1;
			men[] = {"B_Soldier_02_f", "B_Soldier_03_f", "B_Soldier_04_f", "B_Soldier_05_f", "B_Soldier_F", "B_Soldier_lite_F", "B_Soldier_GL_F", "B_soldier_AR_F", "B_Soldier_SL_F", "B_Soldier_TL_F", "B_soldier_M_F", "B_soldier_LAT_F", "B_medic_F", "B_soldier_repair_F", "B_soldier_exp_F", "B_Helipilot_F", "B_Soldier_A_F", "B_soldier_AT_F", "B_soldier_AA_F", "B_engineer_F", "B_crew_F", "B_officer_F", "B_Pilot_F", "B_helicrew_F", "B_soldier_PG_F", "B_soldier_UAV_F", "B_soldier_AAR_F", "B_soldier_AAT_F", "B_soldier_AAA_F", "B_support_MG_F", "B_support_GMG_F", "B_support_Mort_F", "B_support_AMG_F", "B_support_AMort_F", "B_Sharpshooter_F", "B_HeavyGunner_F"};
			menSF[] = {"B_ghillie_lsh_F", "B_ghillie_sard_F", "B_ghillie_ard_F", "B_recon_F", "B_recon_LAT_F", "B_recon_exp_F", "B_recon_medic_F", "B_recon_TL_F", "B_recon_M_F", "B_recon_JTAC_F", "B_spotter_F", "B_sniper_F", "B_CTRG_soldier_M_medic_F", "B_CTRG_soldier_AR_A_F", "B_CTRG_soldier_GL_LAT_F", "B_CTRG_soldier_engineer_exp_F", "B_CTRG_Sharphooter_F", "B_Story_SF_Captain_F", "B_Story_Protagonist_F", "B_Story_Engineer_F", "B_Story_Colonel_F", "B_Story_Pilot_F", "B_Story_Tank_Commander_F", "B_Recon_Sharpshooter_F"};
			divers[] = {"B_diver_F", "B_diver_TL_F", "B_diver_exp_F"};
			cars[] = {"B_MRAP_01_F", "B_MRAP_01_gmg_F", "B_MRAP_01_hmg_F", "B_Quadbike_01_F", "B_Truck_01_transport_F", "B_Truck_01_covered_F", "B_Truck_01_mover_F", "B_Truck_01_box_F", "B_Truck_01_Repair_F", "B_Truck_01_ammo_F", "B_Truck_01_fuel_F", "B_Truck_01_medical_F", "B_APC_Wheeled_01_cannon_F", "B_UGV_01_F", "B_UGV_01_rcws_F", "B_LSV_01_armed_F", "B_LSV_01_unarmed_F", "B_LSV_01_armed_black_F", "B_LSV_01_armed_olive_F", "B_LSV_01_armed_sand_F", "B_LSV_01_unarmed_black_F", "B_LSV_01_unarmed_olive_F", "B_LSV_01_unarmed_sand_F"};
			tanks[] = {"B_APC_Tracked_01_rcws_F", "B_APC_Tracked_01_CRV_F", "B_APC_Tracked_01_AA_F", "B_MBT_01_cannon_F", "B_MBT_01_arty_F", "B_MBT_01_mlrs_F", "B_MBT_01_TUSK_F"};
			helicopters[] = {"B_Heli_Light_01_F", "B_Heli_Light_01_armed_F", "B_Heli_Light_01_stripped_F", "ParachuteWest", "Parachute", "NonSteerable_Parachute_F", "Paraglide", "Steerable_Parachute_F", "B_Heli_Attack_01_F", "B_Heli_Transport_01_F", "B_Heli_Transport_01_camo_F", "B_Parachute_02_F", "B_Heli_Transport_03_F", "B_Heli_Transport_03_unarmed_F", "B_Heli_Transport_03_black_F", "B_Heli_Transport_03_unarmed_green_F", "B_UAV_01_F"};
			planes[] = {"B_Plane_CAS_01_F", "B_UAV_02_F", "B_UAV_02_CAS_F"};
			ships[] = {"B_Boat_Armed_01_minigun_F", "B_Boat_Transport_01_F", "B_Lifeboat", "B_SDV_01_F"};
		};
		class BLU_G_F
		{
			side = 1;
			cars[] = {"B_G_Offroad_01_repair_F","B_G_Offroad_01_F","B_G_Offroad_01_armed_F","B_G_Quadbike_01_F","B_G_Van_01_transport_F","B_G_Van_01_fuel_F"};
			ships[] = {"B_G_Boat_Transport_01_F","B_G_Boat_Transport_02_F"};
			men[] = {"B_G_Soldier_F","B_G_Soldier_lite_F","B_G_Soldier_SL_F","B_G_Soldier_TL_F","B_G_Soldier_AR_F","B_G_medic_F","B_G_engineer_F","B_G_Soldier_exp_F","B_G_Soldier_GL_F","B_G_Soldier_M_F","B_G_Soldier_LAT_F","B_G_Soldier_A_F","B_G_officer_F","I_G_Story_Protagonist_F","I_G_Story_SF_Captain_F","I_G_resistanceLeader_F","I_G_resistanceCommander_F","B_G_Sharpshooter_F"};
		};
		class BLU_GEN_F
		{
			side = 1;
			cars[] = {"B_GEN_Offroad_01_gen_F"};
			men[] = {"B_GEN_Soldier_F","B_GEN_Commander_F"};
		};
		class BLU_T_F
		{
			side = 1;
			cars[] = {"B_T_APC_Wheeled_01_cannon_F","B_T_Truck_01_mover_F","B_T_Truck_01_ammo_F","B_T_Truck_01_box_F","B_T_Truck_01_fuel_F","B_T_Truck_01_medical_F","B_T_Truck_01_Repair_F","B_T_Truck_01_transport_F","B_T_Truck_01_covered_F","B_T_MRAP_01_F","B_T_MRAP_01_gmg_F","B_T_MRAP_01_hmg_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_CTRG_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_CTRG_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_olive_F","B_T_LSV_01_armed_sand_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_olive_F","B_T_LSV_01_unarmed_sand_F","B_T_Quadbike_01_F"};
			tanks[] = {"B_T_APC_Tracked_01_AA_F","B_T_APC_Tracked_01_CRV_F","B_T_APC_Tracked_01_rcws_F","B_T_MBT_01_arty_F","B_T_MBT_01_mlrs_F","B_T_MBT_01_cannon_F","B_T_MBT_01_TUSK_F"};
			helicopters[] = {"B_T_UAV_03_F"};
			planes[] = {"B_T_VTOL_01_infantry_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_armed_F","B_T_VTOL_01_infantry_blue_F","B_T_VTOL_01_infantry_olive_F","B_T_VTOL_01_vehicle_blue_F","B_T_VTOL_01_vehicle_olive_F","B_T_VTOL_01_armed_blue_F","B_T_VTOL_01_armed_olive_F"};
			ships[] = {"B_T_Boat_Transport_01_F","B_T_Lifeboat","B_T_Boat_Armed_01_minigun_F"};
			men[] = {"B_T_Soldier_A_F","B_T_Soldier_AAR_F","B_T_Support_AMG_F","B_T_Support_AMort_F","B_T_Soldier_AAA_F","B_T_Soldier_AAT_F","B_T_Soldier_AR_F","B_T_Medic_F","B_T_Crew_F","B_T_Engineer_F","B_T_Soldier_Exp_F","B_T_Soldier_GL_F","B_T_Support_GMG_F","B_T_Support_MG_F","B_T_Support_Mort_F","B_T_Helicrew_F","B_T_Helipilot_F","B_T_soldier_M_F","B_T_Soldier_AA_F","B_T_Soldier_AT_F","B_T_Officer_F","B_T_Soldier_PG_F","B_T_Pilot_F","B_T_Soldier_Repair_F","B_T_Soldier_F","B_T_Soldier_LAT_F","B_T_Soldier_SL_F","B_T_Soldier_TL_F","B_T_Soldier_UAV_F"};
			menSF[] = {"B_T_Recon_Exp_F","B_T_Recon_JTAC_F","B_T_Recon_M_F","B_T_Recon_Medic_F","B_T_Recon_F","B_T_Recon_LAT_F","B_T_Recon_TL_F","B_T_Sniper_F","B_T_Spotter_F","B_T_ghillie_tna_F"};
			divers[] = {"B_T_Diver_F","B_T_Diver_Exp_F","B_T_Diver_TL_F"};
		};
		class IND_C_F
		{
			side = 3;
			cars[] = {"I_C_Offroad_02_unarmed_F","I_C_Offroad_02_unarmed_brown_F","I_C_Offroad_02_unarmed_olive_F","I_C_Van_01_transport_F","I_C_Van_01_transport_brown_F","I_C_Van_01_transport_olive_F"};
			helicopters[] = {"I_C_Heli_Light_01_civil_F"};
			planes[] = {"I_C_Plane_Civil_01_F"};
			ships[] = {"I_C_Boat_Transport_01_F","I_C_Boat_Transport_02_F"};
			men2[] = {"I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_8_F","I_C_Pilot_F"};
			men3[] = {"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F","I_C_Soldier_Camo_F","I_C_Helipilot_F"};
		};
		class IND_F
		{
			side = 3;
			cars[] = {"I_Quadbike_01_F","I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Truck_02_covered_F","I_Truck_02_transport_F","I_Truck_02_ammo_F","I_Truck_02_box_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_APC_Wheeled_03_cannon_F","I_UGV_01_F","I_UGV_01_rcws_F"};
			tanks[] = {"I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F"};
			helicopters[] = {"ParachuteG","I_Heli_Transport_02_F","I_Parachute_02_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","I_UAV_01_F"};
			planes[] = {"I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_03_AA_F","I_UAV_02_F","I_UAV_02_CAS_F"};
			ships[] = {"I_Boat_Armed_01_minigun_F","I_Boat_Transport_01_F","I_SDV_01_F"};
			men[] = {"I_Soldier_02_F","I_Soldier_03_F","I_Soldier_04_F","I_soldier_F","I_Soldier_lite_F","I_Soldier_A_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_M_F","I_Soldier_LAT_F","I_Soldier_AT_F","I_Soldier_AA_F","I_medic_F","I_Soldier_repair_F","I_Soldier_exp_F","I_engineer_F","I_crew_F","I_helipilot_F","I_pilot_F","I_helicrew_F","I_officer_F","I_Story_Colonel_F","I_soldier_UAV_F","I_Spotter_F","I_Sniper_F","I_Soldier_AAR_F","I_Soldier_AAT_F","I_Soldier_AAA_F","I_support_MG_F","I_support_GMG_F","I_support_Mort_F","I_support_AMG_F","I_support_AMort_F","I_ghillie_lsh_F","I_ghillie_sard_F","I_ghillie_ard_F"};
			divers[] = {"I_diver_F","I_diver_exp_F","I_diver_TL_F"};
		};
		class IND_G_F
		{
			side = 3;
			cars[] = {"I_G_Offroad_01_repair_F","I_G_Offroad_01_F","I_G_Offroad_01_armed_F","I_G_Quadbike_01_F","I_G_Van_01_transport_F","I_G_Van_01_fuel_F"};
			ships[] = {"I_G_Boat_Transport_01_F","I_G_Boat_Transport_02_F"};
			men[] = {"I_G_Soldier_F","I_G_Soldier_lite_F","I_G_Soldier_SL_F","I_G_Soldier_TL_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_M_F","I_G_Soldier_LAT_F","I_G_Soldier_A_F","I_G_officer_F","I_G_Sharpshooter_F"};
		};
		class OPF_F
		{
			side = 2;
			cars[] = {"O_MRAP_02_F","O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_Quadbike_01_F","O_Truck_02_covered_F","O_Truck_02_transport_F","O_Truck_02_box_F","O_Truck_02_medical_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_APC_Wheeled_02_rcws_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Truck_03_transport_F","O_Truck_03_covered_F","O_Truck_03_repair_F","O_Truck_03_ammo_F","O_Truck_03_fuel_F","O_Truck_03_medical_F","O_Truck_03_device_F","O_LSV_02_armed_F","O_LSV_02_armed_viper_F","O_LSV_02_unarmed_F","O_LSV_02_unarmed_viper_F","O_LSV_02_armed_black_F","O_LSV_02_armed_ghex_F","O_LSV_02_armed_arid_F","O_LSV_02_unarmed_black_F","O_LSV_02_unarmed_ghex_F","O_LSV_02_unarmed_arid_F"};
			tanks[] = {"O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_MBT_02_arty_F"};
			helicopters[] = {"O_Heli_Light_02_F","O_Heli_Light_02_unarmed_F","O_Heli_Light_02_v2_F","ParachuteEast","O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_Parachute_02_F","O_Heli_Transport_04_F","O_Heli_Transport_04_ammo_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_box_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_fuel_F","O_Heli_Transport_04_medevac_F","O_Heli_Transport_04_repair_F","O_Heli_Transport_04_black_F","O_Heli_Transport_04_ammo_black_F","O_Heli_Transport_04_bench_black_F","O_Heli_Transport_04_box_black_F","O_Heli_Transport_04_covered_black_F","O_Heli_Transport_04_fuel_black_F","O_Heli_Transport_04_medevac_black_F","O_Heli_Transport_04_repair_black_F","O_UAV_01_F"};
			planes[] = {"O_Plane_CAS_02_F","O_UAV_02_F","O_UAV_02_CAS_F"};
			ships[] = {"O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F","O_Lifeboat","O_SDV_01_F"};
			men[] = {"O_Soldier_02_F","O_Soldier_F","O_officer_F","O_Soldier_lite_F","O_Soldier_GL_F","O_Soldier_AR_F","O_Soldier_SL_F","O_Soldier_TL_F","O_soldier_M_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_helipilot_F","O_Soldier_A_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_crew_F","O_Pilot_F","O_helicrew_F","O_soldier_PG_F","O_soldier_UAV_F","O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AAA_F","O_support_MG_F","O_support_GMG_F","O_support_Mort_F","O_support_AMG_F","O_support_AMort_F","O_Sharpshooter_F","O_HeavyGunner_F"};
			men2[] = {"O_Urban_Sharpshooter_F","O_Urban_HeavyGunner_F","O_soldierU_F","O_soldierU_AR_F","O_soldierU_AAR_F","O_soldierU_LAT_F","O_soldierU_AT_F","O_soldierU_AAT_F","O_soldierU_AA_F","O_soldierU_AAA_F","O_soldierU_TL_F","O_SoldierU_SL_F","O_soldierU_medic_F","O_soldierU_repair_F","O_soldierU_exp_F","O_engineer_U_F","O_soldierU_M_F","O_soldierU_A_F","O_SoldierU_GL_F"};
			menSF[] = {"O_recon_F","O_recon_M_F","O_recon_LAT_F","O_recon_medic_F","O_recon_exp_F","O_recon_JTAC_F","O_recon_TL_F","O_spotter_F","O_sniper_F","O_Story_Colonel_F","O_Story_CEO_F","O_Pathfinder_F","O_ghillie_lsh_F","O_ghillie_sard_F","O_ghillie_ard_F"};
			men3[] = {"O_V_Soldier_hex_F","O_V_Soldier_TL_hex_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_Medic_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_LAT_hex_F","O_V_Soldier_JTAC_hex_F"};
			divers[] = {"O_diver_F","O_diver_TL_F","O_diver_exp_F"};
		};
		class OPF_G_F
		{
			side = 2;
			cars[] = {"O_G_Offroad_01_repair_F","O_G_Offroad_01_F","O_G_Offroad_01_armed_F","O_G_Quadbike_01_F","O_G_Van_01_transport_F","O_G_Van_01_fuel_F"};
			ships[] = {"O_G_Boat_Transport_01_F","O_G_Boat_Transport_02_F"};
			men[] = {"O_G_Soldier_F","O_G_Soldier_lite_F","O_G_Soldier_SL_F","O_G_Soldier_TL_F","O_G_Soldier_AR_F","O_G_medic_F","O_G_engineer_F","O_G_Soldier_exp_F","O_G_Soldier_GL_F","O_G_Soldier_M_F","O_G_Soldier_LAT_F","O_G_Soldier_A_F","O_G_officer_F","O_G_Sharpshooter_F"};
		};
		class OPF_T_F
		{
			side = 2;
			cars[] = {"O_T_APC_Wheeled_02_rcws_ghex_F","O_T_LSV_02_armed_F","O_T_LSV_02_armed_viper_F","O_T_LSV_02_unarmed_F","O_T_LSV_02_unarmed_viper_F","O_T_LSV_02_armed_black_F","O_T_LSV_02_armed_ghex_F","O_T_LSV_02_armed_arid_F","O_T_LSV_02_unarmed_black_F","O_T_LSV_02_unarmed_ghex_F","O_T_LSV_02_unarmed_arid_F","O_T_MRAP_02_ghex_F","O_T_MRAP_02_hmg_ghex_F","O_T_MRAP_02_gmg_ghex_F","O_T_Quadbike_01_ghex_F","O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F","O_T_Truck_03_repair_ghex_F","O_T_Truck_03_ammo_ghex_F","O_T_Truck_03_fuel_ghex_F","O_T_Truck_03_medical_ghex_F","O_T_Truck_03_device_ghex_F","O_T_UGV_01_ghex_F","O_T_UGV_01_rcws_ghex_F"};
			tanks[] = {"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Tracked_02_AA_ghex_F","O_T_MBT_02_cannon_ghex_F","O_T_MBT_02_arty_ghex_F"};
			planes[] = {"O_T_UAV_04_CAS_F","O_T_VTOL_02_infantry_F","O_T_VTOL_02_vehicle_F","O_T_VTOL_02_infantry_hex_F","O_T_VTOL_02_infantry_ghex_F","O_T_VTOL_02_infantry_grey_F","O_T_VTOL_02_vehicle_hex_F","O_T_VTOL_02_vehicle_ghex_F","O_T_VTOL_02_vehicle_grey_F"};
			ships[] = {"O_T_Lifeboat","O_T_Boat_Armed_01_hmg_F","O_T_Boat_Transport_01_F"};
			men[] = {"O_T_Soldier_A_F","O_T_Soldier_AAR_F","O_T_Support_AMG_F","O_T_Support_AMort_F","O_T_Soldier_AAA_F","O_T_Soldier_AAT_F","O_T_Soldier_AR_F","O_T_Medic_F","O_T_Crew_F","O_T_Engineer_F","O_T_Soldier_Exp_F","O_T_Soldier_GL_F","O_T_Support_GMG_F","O_T_Support_MG_F","O_T_Support_Mort_F","O_T_Helicrew_F","O_T_Helipilot_F","O_T_Soldier_M_F","O_T_Soldier_AA_F","O_T_Soldier_AT_F","O_T_Officer_F","O_T_Soldier_PG_F","O_T_Pilot_F","O_T_Soldier_Repair_F","O_T_Soldier_F","O_T_Soldier_LAT_F","O_T_Soldier_SL_F","O_T_Soldier_TL_F","O_T_Soldier_UAV_F"};
			menSF[] = {"O_T_Recon_Exp_F","O_T_Recon_JTAC_F","O_T_Recon_M_F","O_T_Recon_Medic_F","O_T_Recon_F","O_T_Recon_LAT_F","O_T_Recon_TL_F","O_T_Sniper_F","O_T_Spotter_F","O_T_ghillie_tna_F"};
			men2[] = {"O_V_Soldier_ghex_F","O_V_Soldier_TL_ghex_F","O_V_Soldier_Exp_ghex_F","O_V_Soldier_Medic_ghex_F","O_V_Soldier_M_ghex_F","O_V_Soldier_LAT_ghex_F","O_V_Soldier_JTAC_ghex_F"};
			divers[] = {"O_T_Diver_F","O_T_Diver_Exp_F","O_T_Diver_TL_F"};
		};

	};
};