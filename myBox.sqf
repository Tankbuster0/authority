//A blacklist that removes all secondary weapons and all weapon/respawn/special backpacks
blacklist1 = [
	"launch_B_Titan_short_F", //weapon launchers
	"launch_I_Titan_short_F",
	"launch_O_Titan_short_F",
	"launch_B_Titan_F",
	"launch_I_Titan_F",
	"launch_O_Titan_F",
	"launch_Titan_short_F",
	"launch_Titan_F",
	"launch_NLAW_F",
	"launch_RPG32_F",
	"optic_aco",
	"optic_aco_smg",
	"optic_hamr",
	"optic_sos",
	"optic_holosight",
	"optic_nvs",
	"optic_tws",
	"optic_tws_mg",
	"optic_mrd",
	"optic_dms",
	"optic_lrps",
	"optic_ams",
	"optic_ams_khk",
	"optic_ams_snd",
	"optic_holosight_smg",
	"optic_aco_grn",
	"optic_mrco",
	"optic_khs_old"
];


if !( isServer ) exitWith {};

_ammoBox = _this;

//[ box, [ white, black ], targets, name, condition ]
JIPID =  [ _ammoBox, [west, "blacklist1"], 0, "No launchers/optics", { true } ] call LARs_fnc_blacklistArsenal;