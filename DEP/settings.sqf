/*  Copyright 2016 Fluit

    This file is part of Dynamic Enemy Population.

    Dynamic Enemy Population is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation version 3 of the License.

    Dynamic Enemy Population is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Dynamic Enemy Population.  If not, see <http://www.gnu.org/licenses/>.
*/

// *************************************************************
// This is the settings file for DEP. Edit to your own liking.
// Every setting in this file is optional and will fall back
// to it's appropriate default value when commented out.
// For a complete list of possible settings and their values
// visit:   https://fluitarma.wordpress.com/dep-settings/
// *************************************************************


// *************************************************************
// General settings
// *************************************************************

 dep_side = independent;
// dep_own_side = west;
 dep_despawn = 3;
// dep_respawn_timeout = 0;
 dep_debug = false;
 dep_logging = true;
 dep_chat_logging = false;
 dep_safe_zone = [markerPos "dep_safezone_marker_1", markerPos "dep_safezone_marker_2", markerPos "dep_safezone_marker_3",markerPos "dep_safezone_marker_4",markerPos "dep_safezone_marker_5",markerPos "dep_safezone_marker_6"];
// dep_safe_rad = 800;
// dep_map_margin = 400;
// dep_ieds = true;
// dep_mines = true;
// dep_ied_chance = 0.7;
// dep_cr_ied = false;
// dep_veh_chance = 0.5;
dep_unit_init = "[_this] call tky_fnc_tc_setskill";
 dep_useheadless = false;
dep_headlessclient = "";
// dep_allow_mortars = false;
dep_civilians = true;
// dep_fail_civilians = 0;
// dep_civ_fail_script = "";
dep_zone_markers = [];


// *************************************************************
// Performance settings
// *************************************************************

// dep_max_ai_loc = 4;
// dep_aim_player = 0.3;
// dep_max_ai_tot = 200;
// dep_act_dist = 800;
// dep_act_height = 200;
// dep_act_speed = 200;


// *************************************************************
// Location types
// *************************************************************

 dep_roadblocks = 7;
// dep_bunkers = 5b
dep_patrols = 4;
// dep_forest_patrols = 0;
dep_air_patrols = 3;
dep_aa_camps = 2;
dep_housepop = 50;
// dep_ambushes = 10;
// dep_military = 4;
// dep_town_occupation = 0.8;


// *************************************************************
// Class names
// *************************************************************

// Military forces
 dep_u_soldier       = "I_soldier_F";
 dep_u_gl            = "I_Soldier_GL_F";
 dep_u_ar            = "I_Soldier_AR_F";
 dep_u_at            = "I_Soldier_LAT_F";
 dep_u_medic         = "I_medic_F";
 dep_u_aa            = "I_Soldier_AA_F";
 dep_u_aaa           = "I_Soldier_AAA_F";
 dep_u_sl            = "I_Soldier_SL_F";
 dep_u_marksman      = "I_soldier_M_F";
 dep_u_sniper        = "I_Sniper_F";

// Guerilla forces
 dep_u_g_soldier     = "I_G_Soldier_F";
 dep_u_g_gl          = "I_G_Soldier_GL_F";
 dep_u_g_ar          = "I_G_Soldier_AR_F";
 dep_u_g_at          = "I_G_Soldier_LAT_F";
 dep_u_g_medic       = "I_G_medic_F";
 dep_u_g_sl          = "I_G_Soldier_SL_F";
 dep_u_g_marksman    = "I_G_Soldier_M_F";

// Vehicles
// dep_civ_veh         = ["C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Truck_02_transport_F","C_Truck_02_covered_F","C_SUV_01_F"];
dep_ground_vehicles = ["I_C_Offroad_02_unarmed_F","I_C_Van_01_transport_F","I_G_Van_01_transport_F","I_G_Offroad_01_armed_F","O_T_Truck_03_transport_ghex_F","I_MRAP_03_F","I_MRAP_03_hmg_F","I_G_Offroad_01_F"];
dep_air_vehicles     = ["I_C_Plane_Civil_01_F","I_Heli_light_03_F","I_C_Heli_Light_01_civil_F","I_Heli_Transport_02_F","I_Heli_light_03_F","I_Heli_light_03_unarmed_F","O_Heli_Light_02_unarmed_F"];

// Static weapons
 dep_static_aa       = "CUP_I_ZU23_NAPA";
 dep_static_at       = "CUP_I_SPG9_NAPA";
 dep_static_hmg      = "CUP_I_DSHKM_NAPA";
 dep_static_gmg      = "CUP_I_DSHKM_NAPA";
 dep_static_hmg_tri  = "CUP_I_DSHKM_NAPA";