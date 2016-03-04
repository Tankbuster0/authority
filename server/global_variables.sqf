// global_variable.includes
//by tankbuster
islandcentre = getarray (configFile >> "CfgWorlds" >> "Altis" >> "centerPosition");

opfor_reinf_truck_soldier = (if (RHS) then {"rhs_msv_grenadier"} else {"O_Soldier_GL_F"});
opfor_reinf_truck =  (if (RHS) then {"RHS_Ural_Open_MSV_01"} else {"O_Truck_03_transport_F"});

opfor_reinf_helos = ["RHS_Mi24V_FAB_vdv", "RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_FAB_vvsc", "rhs_ka60_c"];

forwardpointvehicle = "rhsusf_rg33_wd";

prizes = ["rhsusf_M1083A1P2_B_M2_wd_fmtv_usarmy","rhsusf_m1025_w_mk19","rhsusf_m109_usarmy", "rhsusf_m1a1aimwd_usarmy", "rhsusf_m1a2sep1tuskiiwd_usarmy", "RHS_M2A3_BUSKIII_wd", "rhsusf_m113_usarmy_MK19"]