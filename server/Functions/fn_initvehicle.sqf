//fn_initvehicle by tankbuster
//replaces uses BIS initvehicle
 #include "..\includes.sqf"
__tky_starts

// send me an object and I will randomise it's texture and global it

params ["_obj"];
switch (true) do
	{
		case (typeOf _obj) isKindOf "Van_02_transport_base_F":
			{
				//it's a minibus. get the handpicked textures and apply one
			};
		case (typeOf _obj) in ["C_Offroad_stripped_F", "C_Offroad_luxe_F"]:
			{
				// it's one of the randomised offroads.
			};
		case (typeOf _obj) isKindOf "Plane_Civil_01_base_F":
			{
				// normal ceasar and racing. for these, we don't need to handpick, and we can extract all of the available textures and apply one
			};
	};

__tky_ends
