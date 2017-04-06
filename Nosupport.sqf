//A blacklist that removes all secondary weapons and all weapon/respawn/special backpacks
blacklist = [
	"launch_B_Titan_short_F", //weapon launchers
	"launch_I_Titan_short_F",
	"launch_O_Titan_short_F",
	"launch_B_Titan_F",
	"launch_I_Titan_F",
	"launch_O_Titan_F",
	"launch_NLAW_F",
	"launch_RPG32_F",
	"launch_Titan_short_F",
	"launch_Titan_F",

	"B_Respawn_Sleeping_bag_blue_F", //backpack respawn sleeping bags
	"B_Respawn_Sleeping_bag_brown_F",
	"B_Respawn_Sleeping_bag_F",

	"B_Respawn_TentDome_F", //backpack respawn tents
	"B_Respawn_TentA_F",

	"I_GMG_01_A_weapon_F", //backpack static GMGs
	"B_GMG_01_A_weapon_F",
	"O_GMG_01_A_weapon_F",
	"I_GMG_01_weapon_F",
	"B_GMG_01_weapon_F",
	"O_GMG_01_weapon_F",
	"I_GMG_01_high_weapon_F",
	"B_GMG_01_high_weapon_F",
	"O_GMG_01_high_weapon_F",


	"I_HMG_01_A_weapon_F", //backpack static HMGs
	"B_HMG_01_A_weapon_F",
	"O_HMG_01_A_weapon_F",
	"I_HMG_01_weapon_F",
	"B_HMG_01_weapon_F",
	"O_HMG_01_weapon_F",
	"I_HMG_01_support_F",
	"B_HMG_01_support_F",
	"O_HMG_01_support_F",
	"I_HMG_01_high_weapon_F",
	"B_HMG_01_high_weapon_F",
	"O_HMG_01_high_weapon_F",
	"I_HMG_01_support_high_F",
	"B_HMG_01_support_high_F",
	"O_HMG_01_support_high_F",

	"I_AA_01_weapon_F",	//Static launcher AA
	"B_AA_01_weapon_F",
	"O_AA_01_weapon_F",
	"I_AT_01_weapon_F",	//Static launcher AT
	"B_AT_01_weapon_F",
	"O_AT_01_weapon_F",

	"I_Mortar_01_support_F", //mortar tripod
	"B_Mortar_01_support_F",
	"O_Mortar_01_support_F",
	"I_Mortar_01_weapon_F", //mortar tube
	"B_Mortar_01_weapon_F",
	"O_Mortar_01_weapon_F",

	"O_Static_Designator_02_weapon_F", //backpack remote designators
	"B_Static_Designator_01_weapon_F",
	"B_Carryall_mcamo_AAA", //rocket backpack ( no not that kind :/ )
	"B_Carryall_mcamo_AAT",

	"B_Parachute", //backpack parachute

	"I_UAV_01_backpack_F", //backpack UAVs
	"B_UAV_01_backpack_F",
	"O_UAV_01_backpack_F",

	"B_AssaultPack_Kerry" //backpack specials
];


if !( isServer ) exitWith {};

_ammoBox = _this;

//[ box, [ white, black ], targets, name, condition ]
JIPID =  [ _ammoBox, [east, "blacklist"], east, "No launchers", { true } ] call LARs_fnc_blacklistArsenal;
JIPID =  [ _ammoBox, [west, "blacklist"], west, "No launchers", { true } ] call LARs_fnc_blacklistArsenal;
JIPID =  [ _ammoBox, [independent, "blacklist"], independent, "No launchers", { true } ] call LARs_fnc_blacklistArsenal;