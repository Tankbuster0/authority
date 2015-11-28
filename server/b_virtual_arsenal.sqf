
// by BL1P OF 'Dedicated Rejects'
#define THIS_FILE "b_virtual_arsenal"

private ["_ret", "_this"];

//--- check if player has an acre radio
_ret = false;
if !(isserver) then {
	acre_enabled = isClass(configFile/"CfgPatches"/"acre_main");
	if (acre_enabled) then
		{
		_ret = [player] call acre_api_fnc_hasRadio;
		};
	};
if (_ret) exitwith {systemchat "You can not use the VR ammo system while you have an ACRE radio.";};

//--- BackPacks
[_this,[
	"B_AssaultPack_blk",
	"B_AssaultPack_cbr",
	"B_AssaultPack_dgtl",
	"B_AssaultPack_rgr",
	"B_AssaultPack_khk",
	"B_AssaultPack_mcamo",
	"B_AssaultPack_sgg",
	"B_Kitbag_cbr",
	"B_Kitbag_mcamo",
	"B_Kitbag_sgg",
	"B_FieldPack_blk",
	"B_TacticalPack_rgr",
	"B_TacticalPack_mcamo",
	"B_TacticalPack_oli",
	"B_Bergen_blk",
	"B_Bergen_mcamo",
	"B_Bergen_sgg",
	"B_Bergen_blk",
	"B_BergenC_blu",
	"B_Carryall_oli",
	"B_Carryall_khk",
	"B_Carryall_mcamo",
	"B_Mortar_01_weapon_F",
	"B_Mortar_01_support_F",
	"B_AA_01_weapon_F",
	"B_HMG_01_support_F",
	"B_AT_01_weapon_F",
	"B_HMG_01_support_F",
	"B_Static_Designator_01_weapon_F",
	"tf_rt1523g",
	"tf_rt1523g_big",
	"tf_rt1523g_black",
	"tf_rt1523g_fabric",
	"tf_rt1523g_green",
	"tf_rt1523g_sage"

],true] call BIS_fnc_addVirtualBackpackCargo;

//--- Mags
[_this,[
	"30Rnd_9x21_Mag",
	"16Rnd_9x21_Mag",
	"11Rnd_45ACP_Mag",
	"30Rnd_45ACP_Mag_SMG_01",
	"20Rnd_556x45_UW_mag",
	"30Rnd_556x45_Stanag",
	"30Rnd_65x39_caseless_mag",
	"30Rnd_65x39_caseless_mag_Tracer",
	"100Rnd_65x39_caseless_mag",
	"100Rnd_65x39_caseless_mag_Tracer",
	"20Rnd_762x51_Mag",
	"200Rnd_65x39_cased_Box",
	"200Rnd_65x39_cased_Box_Tracer",
	"7Rnd_408_Mag",
	"10Rnd_338_Mag",
    	"130Rnd_338_Mag",

	"NLAW_F",
	"Titan_AT",
	"Titan_AP",
	"Titan_AA",

	"B_IR_Grenade",
	"HandGrenade",
	"MiniGrenade",
	"DemoCharge_Remote_Mag",
	"SatchelCharge_Remote_Mag",
	"ATMine_Range_Mag",
	"Laserbatteries",
	"ClaymoreDirectionalMine_Remote_Mag",
	"APERSMine_Range_Mag",
	"APERSBoundingMine_Range_Mag",
	"SLAMDirectionalMine_Wire_Mag",
	"APERSTripMine_Wire_Mag",
	"HandGrenade_stone",

	"1Rnd_HE_Grenade_shell",
	"1Rnd_Smoke_Grenade_shell",
	"1Rnd_SmokeBlue_Grenade_shell",
	"1Rnd_SmokeGreen_Grenade_shell",
	"1Rnd_SmokeOrange_Grenade_shell",
	"1Rnd_SmokePurple_Grenade_shell",
	"1Rnd_SmokeRed_Grenade_shell",
	"1Rnd_SmokeYellow_Grenade_shell",
	"3Rnd_HE_Grenade_shell",
	"3Rnd_Smoke_Grenade_shell",
	"3Rnd_SmokeBlue_Grenade_shell",
	"3Rnd_SmokeGreen_Grenade_shell",
	"3Rnd_SmokeOrange_Grenade_shell",
	"3Rnd_SmokePurple_Grenade_shell",
	"3Rnd_SmokeRed_Grenade_shell",
	"3Rnd_SmokeYellow_Grenade_shell",
	"3Rnd_UGL_FlareCIR_F",
	"3Rnd_UGL_FlareGreen_F",
	"3Rnd_UGL_FlareRed_F",
	"3Rnd_UGL_FlareWhite_F",
	"3Rnd_UGL_FlareYellow_F",
	"UGL_FlareCIR_F",
	"UGL_FlareGreen_F",
	"UGL_FlareRed_F",
	"UGL_FlareWhite_F",
	"UGL_FlareYellow_F",

	"SmokeShell",
	"SmokeShellYellow",
	"SmokeShellGreen",
	"SmokeShellRed",
	"SmokeShellPurple",
	"SmokeShellOrange",
	"SmokeShellBlue",

	"Chemlight_green",
	"Chemlight_red",
	"Chemlight_yellow",
	"Chemlight_blue"


],true] call BIS_fnc_addVirtualMagazineCargo;


//--- Weapons
[_this,[
	"hgun_P07_F",
	"hgun_P07_snds_F",
	"hgun_Pistol_heavy_01_snds_F",
	"hgun_Pistol_heavy_01_MRD_F",

	"arifle_MX_F",
	"arifle_MX_GL_F",
	"arifle_MX_SW_F",
	"arifle_MXC_F",
	"arifle_MXM_F",
	"arifle_MXC_Black_F",
	"arifle_MX_Black_F",
	"arifle_MX_GL_Black_F",
	"arifle_MX_SW_Black_F",
	"arifle_MXM_Black_F",
	"arifle_SDAR_F",
	"arifle_TRG20_F",
	"arifle_TRG21_F",
	"arifle_TRG21_GL_F",
	"SMG_01_F",
	"LMG_Mk200_F",
	"srifle_EBR_F",
	"srifle_LRR_SOS_F",
	"srifle_DMR_02_F",
	"srifle_DMR_02_camo_F",
	"srifle_DMR_02_sniper_F",
	"srifle_DMR_03_khaki_F",
	"srifle_DMR_03_multicam_F",
	"srifle_DMR_03_spotter_F",
	"srifle_DMR_03_tan_F",
	"srifle_DMR_03_woodland_F",

	"MMG_02_black_F",
	"MMG_02_black_RCO_BI_F",
	"MMG_02_camo_F",
	"MMG_02_sand_F",
	"MMG_02_sand_RCO_LP_F",

	"launch_NLAW_F",
	"launch_B_Titan_F",
	"launch_B_Titan_short_F",

	"Binocular",
	"Rangefinder",
	"Laserdesignator"

],true] call BIS_fnc_addVirtualWeaponCargo;

//--- Items and Stuff
[_this,[
	//--- Stuff
	"tf_anprc152",
	"tf_rf7800str",
	"ItemRadio",
	"ItemCompass",
	"ItemGPS",
	"ItemMap",
	"ItemWatch",
	"NVGoggles",
	"FirstAidKit",
	"Medikit",
	"ToolKit",
	"B_UavTerminal",
	"MineDetector",

	//--- Scopes
	"optic_Aco",
	"optic_ACO_grn",
	"optic_Aco_smg",
	"optic_ACO_grn_smg",
	"optic_Holosight",
	"optic_Holosight_smg",
	"optic_Hamr",
	"optic_MRCO",
	"optic_Arco",
	"optic_MRD",
	"optic_Nightstalker",
	"optic_tws_mg",
	"optic_tws",
	"optic_Yorris",
	"optic_SOS",
	"optic_DMS",
	"optic_NVS",
	"optic_LRPS",
	"optic_AMS_snd",
	"optic_AMS_khk",
	"optic_AMS",


	//--- Suppresors
	"muzzle_snds_acp",
	"muzzle_snds_B",
	"muzzle_snds_H_MG",
	"muzzle_snds_H",
	"muzzle_snds_L",
	"muzzle_snds_M",
	"muzzle_snds_H_SW",
	"muzzle_snds_338_black",
	"muzzle_snds_338_green",
	"muzzle_snds_338_sand",

	//--- Bipods
	"bipod_01_F_blk",
	"bipod_01_F_mtp",
	"bipod_01_F_snd",

	//--- Attachments
	"acc_flashlight",
	"acc_pointer_IR",

	//--- Uniforms
	"U_B_CTRG_3",
	"U_B_CTRG_2",
	"U_B_CTRG_1",
	"U_B_CombatUniform_mcam",
	"U_B_CombatUniform_mcam_tshirt",
	"U_B_CombatUniform_mcam_vest",
	"U_B_CombatUniform_mcam_worn",
	"U_B_CombatUniform_sgg",
	"U_B_CombatUniform_sgg_tshirt",
	"U_B_CombatUniform_sgg_vest",
	"U_B_SpecopsUniform_sgg",
	"U_B_CombatUniform_wdl",
	"U_B_CombatUniform_wdl_tshirt",
	"U_B_CombatUniform_wdl_vest",
	"U_B_FullGhillie_ard",
	"U_B_FullGhillie_lsh",
	"U_B_FullGhillie_sard",
	"U_B_Ghilliesuit",
	"U_B_HeliPilotCoveralls",
	"U_B_PilotCoveralls",
	"U_B_Wetsuit",

	//--- Vests
	"V_HarnessOGL_gry",
	"V_HarnessOGL_brn",
	"V_HarnessOSpec_brn",
	"V_HarnessOSpec_gry",
	"V_BandollierB_blk",
	"V_BandollierB_oli",
	"V_BandollierB_khk",
	"V_Chestrig_khk",
	"V_Chestrig_oli",
	"V_PlateCarrierGL_rgr",
	"V_PlateCarrier3_rgr",
	"V_PlateCarrier2_rgr",
	"V_PlateCarrierL_CTRG",
	"V_PlateCarrierH_CTRG",
	"V_PlateCarrierGL_blk",
	"V_PlateCarrierGL_mtp",
	"V_PlateCarrierGL_rgr",
	"V_PlateCarrierIAGL_dgtl",
	"V_PlateCarrierIAGL_oli",
	"V_PlateCarrierSpec_blk",
	"V_PlateCarrierSpec_mtp",
	"V_PlateCarrierSpec_rgr",
	"V_TacVest_camo",
	"V_TacVest_oli",
	"V_TacVestCamo_khk",
	"V_RebreatherB",

	//--- Helmets
	"H_HelmetB_plain_mcamo",
	"H_HelmetB_light_snakeskin",
	"H_HelmetB_camo",
	"H_HelmetB",
	"H_Helmet_Kerry",
	"H_HelmetB_paint",
	"H_HelmetB_light",
	"H_HelmetB_grass",
	"H_HelmetB_light_sand",
	"H_HelmetSpecB_paint1",
	"H_HelmetSpecB_paint2",
	"H_HelmetSpecB",
	"H_CrewHelmetHeli_B",
	"H_PilotHelmetFighter_B",
	"H_PilotHelmetHeli_B",

	//--- Berets
	"H_Beret_blk",
	"H_Beret_02",
	"H_Beret_grn_SF",


	//--- Caps n Hats
	"H_Booniehat_khk",
	"H_Booniehat_mcamo",
	"H_Booniehat_dgtl",
	"H_Booniehat_khk_hs",
	"H_Bandanna_sgg",
	"H_Bandanna_khk",
	"H_Bandanna_khk_hs",
	"H_Bandanna_camo",
	"H_Bandanna_mcamo",

	"H_Cap_khaki_specops_UK",
	"H_MilCap_mcamo",
	"H_Watchcap_blk",
	"H_Watchcap_khk",
	"H_Watchcap_camo",
	"H_Cap_red",
	"H_Cap_blu",
	"H_Cap_grn",

	"H_Shemag_olive",
	"H_Shemag_khk",
	"H_Shemag_olive_hs",


	//--- Glasses
	"G_Diving",
	"G_Aviator",
	"G_Tactical_Clear",
	"G_Sport_Red",
	"G_Spectacles",
	"G_Combat",
	"G_Lowprofile",
	"G_Shades_Black",
	"G_Tactical_Black",
	"G_Balaclava_lowprofile",
	"G_Balaclava_combat",
	"G_Bandanna_beast",
	"G_Bandanna_shades"
],true] call BIS_fnc_addVirtualItemCargo;

["Open",false] spawn BIS_fnc_arsenal;
