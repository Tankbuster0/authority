/by tankbuster
 #include "..\includes.sqf"
 _myscript = "setvehicleloadout";
 params ["_vec"];

 clearWeaponCargoGlobal _vec;
 clearBackpackCargoGlobal _vec;
 clearItemCargoGlobal _vec;
 clearMagazineCargoGlobal _vec;

 _tvec = typeof _vec;

switch (_tvec) do
	{
	case fobvehicleclassname: {};

	case forwardpointvehicleclassname: {};


	}



