//by tankbuster
 #include "..\includes.sqf"
 _myscript = "setvehicleloadout";
 params ["_vec"];



switch (typeof _vec) do
	{
	case forwardpointvehicleclassname:
		{
		clearWeaponCargoGlobal _vec;
 		clearBackpackCargoGlobal _vec;
 		clearItemCargoGlobal _vec;
 		clearMagazineCargoGlobal _vec;

		_vec addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer", 20];
		_vec addMagazineCargoGlobal ["20Rnd_762x51_Mag", 20];
		_vec addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell", 10];
		_vec addMagazineCargoGlobal ["SmokeShellBlue", 5];
		_vec addMagazineCargoGlobal ["Laserbatteries", 6];
		_vec addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 8];
		_vec addMagazineCargoGlobal ["Titan_AT", 10];
		_vec addMagazineCargoGlobal ["Titan_AA", 10];
		_vec addMagazineCargoGlobal ["B_IR_Grenade", 5];

		_vec addItemCargoGlobal ["Laserdesignator_02_ghex_F", 20];
		_vec addItemCargoGlobal ["FirstAidKit",15];
		_vec addItemCargoGlobal ["ItemMap",1];
		_vec addItemCargoGlobal ["Medikit",5];
		_vec addItemCargoGlobal ["Toolkit",2];


		};

	case fobvehicleclassname:
		{
		clearWeaponCargoGlobal _vec;
 		clearBackpackCargoGlobal _vec;
 		clearItemCargoGlobal _vec;
 		clearMagazineCargoGlobal _vec;

		_vec addItemCargoGlobal ["FirstAidKit",15];
		_vec addItemCargoGlobal ["ItemMap",1];
		_vec addItemCargoGlobal ["Medikit",5];
		_vec addItemCargoGlobal ["Toolkit",2];
		};


	};



