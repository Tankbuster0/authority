//fn_initvehicle by tankbuster
//replaces uses BIS initvehicle
 #include "..\includes.sqf"
__tky_starts

// send me an object and I will randomise its texture and global it

params ["_obj"];
switch (true) do
	{
		case (typeOf _obj) isKindOf "Van_02_transport_base_F":// custom choice because we can't choose from all the available minibus texs
			{
				_textures = ["\a3\Soft_F_Orange\Van_02\Data\van_body_Syndikat_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_Vrana_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_bluepearl_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_fuel_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_green_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_black_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_red_CO.paa", "\a3\Soft_F_Orange\Van_02\Data\van_body_blue_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_orange_CO.paa","\a3\Soft_F_Orange\Van_02\Data\van_body_white_CO.paa"];
				_obj setObjectTextureGlobal [0, (selectRandom _textures)];
			};
		case _obj isKindOf "Heli_Transport_02_base_F": // custom choice because not all of the texs are good, plus there's 3 texs to be applied
			{
	            if ((random 1) > 0.5  ) then
	                {
	                _obj setObjectTextureGlobal [0,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_dahoman_co.paa"];
	                _obj setObjectTextureGlobal [1,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_dahoman_co.paa"];
	                _obj setObjectTextureGlobal [2,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_dahoman_co.paa"];
	                }
	                else
	                {
	                _obj setObjectTextureGlobal [0,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_1_ion_co.paa"];
	                _obj setObjectTextureGlobal [1,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_2_ion_co.paa"];
	                _obj setObjectTextureGlobal [2,"a3\air_f_beta\Heli_Transport_02\Data\Skins\heli_transport_02_3_ion_co.paa"];
	                };
			};
		default// everything else, grab all the available texs and choose one at random
			{
				_mytexturelist = (getArray (configFile/"CfgVehicles"/typeOf _obj/"texturelist")) select {typeName _x isEqualTo "STRING"};// array also contains numbers, remove them
				{
					_texturesources pushback ((getArray (configFile/"CfgVehicles"/typeOf _obj/"texturesources"/_x/"textures")) select 0);
				}foreach _mytexturelist;
				_obj setObjectTextureGlobal [0,selectRandom _texturesources];
			};
	};

__tky_ends
