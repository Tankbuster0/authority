// global_variable.includes
//by tankbuster
islandcentre = getarray (configFile >> "CfgWorlds" >> "Altis" >> "centerPosition");

opfor_reinf_truck_soldier = (if (RHS) then {"rhs_msv_grenadier"} else {"O_Soldier_GL_F"});
opfor_reinf_truck =  (if (RHS) then {"RHS_Ural_Open_MSV_01"} else {"O_Truck_03_transport_F"});

opfor_reinf_helos = ["RHS_Mi24V_FAB_vdv", "RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_FAB_vvsc", "rhs_ka60_c"];

forwardpointvehicleclassname = "rhsusf_rg33_wd";
fobvehicleclassname = "rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy";

prizes = ["rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy","rhsusf_m1025_w_mk19","rhsusf_m109_usarmy", "rhsusf_m1a1aimwd_usarmy", "rhsusf_m1a2sep1tuskiiwd_usarmy", "RHS_M2A3_BUSKIII_wd", "rhsusf_m113_usarmy_MK19"]

civs = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_1_F_afro","C_man_polo_1_F_euro","C_man_polo_1_F_asia","C_man_polo_2_F","C_man_polo_2_F_afro","C_man_polo_2_F_euro","C_man_polo_2_F_asia","C_man_polo_3_F","C_man_polo_3_F_afro","C_man_polo_3_F_euro","C_man_polo_3_F_asia","C_man_polo_4_","C_man_polo_4_F_afro","C_man_polo_4_F_euro","C_man_polo_4_F_asia","C_man_polo_5_F","  	C_man_polo_5_F_afro","C_man_polo_5_F_euro","C_man_polo_5_F_asia","C_man_polo_6_F","C_man_polo_6_F_afro","C_man_polo_6_F_euro","C_man_polo_6_F_asia","C_man_p_fugitive_F","C_man_p_fugitive_F_afro","C_man_p_fugitive_F_euro","C_man_p_fugitive_F_asia","C_man_p_beggar_F","C_man_p_beggar_F_afro","C_man_p_beggar_F_euro","C_man_p_beggar_F_asia","C_man_w_worker_F","C_man_hunter_1_F","C_man_p_shorts_1_F","C_man_p_shorts_1_F_afro","C_man_p_shorts_1_F_euro","C_man_p_shorts_1_F_asia","C_man_shorts_1_F","C_man_shorts_1_F_afro","C_man_shorts_1_F_euro","C_man_shorts_1_F_asia","C_man_shorts_2_F","C_man_shorts_2_F_afro","C_man_shorts_2_F_euro","C_man_shorts_2_F_asia","C_man_shorts_3_F","C_man_shorts_3_F_afro","C_man_shorts_3_F_euro","C_man_shorts_3_F_asia","C_man_shorts_4_F","C_man_shorts_4_F_afro","C_man_shorts_4_F_euro","C_man_shorts_4_F_asia"]// all the civs apart from named and stpry related ones