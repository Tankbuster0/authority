//fn_initvehicle by tankbuster
//replaces uses BIS initvehicle
 #include "..\includes.sqf"
__tky_starts

// send me an object and I will randomise its texture and global it

params ["_obj"];
switch (true) do
	{
		case (typeOf _obj) isKindOf "Van_02_transport_base_F":
			{
				//it's a minibus. get the handpicked textures and apply one
				_textures = ["\a3\Soft_F_Orange\Van_02\Data\van_body_Syndikat_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_Vrana_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_bluepearl_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_fuel_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_green_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_black_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_red_CO.paa", "\a3\Soft_F_Orange\Van_02\Data\van_body_blue_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_orange_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_white_CO.paa"];
				_obj setObjectTextureGlobal [0, (selectRandom _textures)];
			};
		case _obj isKindOf "Heli_Transport_02_base_F": {/* hand pick a tex */};
		/*
		case _obj isKindOf "Plane_Civil_01_base_F":
		case _obj isKindOf "Heli_Light_01_unarmed_base_F":
		case _obj isKindOf "Quadbike_01_base_F":
		case _obj isKindOf "Hatchback_01_base_F":
		case _obj isKindOf "SUV_01_base_F":
		case _obj isKindOf "C_Offroad_01_F":
		case _obj isKindOf "C_Offroad_02_unarmed_F":
		case _obj isKindOf "Scooter_Transport_01_base_F":
		*/
		default
			{
				_mytexturelist = (getArray (configFile/"CfgVehicles"/typeOf _obj/"texturelist")) select {typeName _x isEqualTo "STRING"};// array also contains numbers, remove them
				{
					_texturesources pushback ((getArray (configFile/"CfgVehicles"/typeOf _obj/"texturesources"/_x/"textures")) select 0);
				}foreach _mytexturelist;
				_obj setObjectTextureGlobal [0,selectRandom _texturesources];

			};
	};

__tky_ends
