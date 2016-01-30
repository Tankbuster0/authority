// global_variable.includes
//by tankbuster
islandcentre = getarray (configFile >> "CfgWorlds" >> "Altis" >> "centerPosition");

opfor_reinf_truck_soldier = (if (RHS) then {"rhs_msv_grenadier"} else {"O_Soldier_GL_F"});
opfor_reinf_truck =  (if (RHS) then {"RHS_Ural_Open_MSV_01"} else {"O_Truck_03_transport_F"});

opfor_reinf_helos = ["RHS_Mi24V_FAB_vdv", "RHS_Mi8MTV3_vvs","RHS_Mi8MTV3_FAB_vvsc", "rhs_ka60_c"];