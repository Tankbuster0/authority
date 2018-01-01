//debug_endprimarytarget
//by tankbuster
 #include "..\includes.sqf"
_myscript = "debug_endprimarytarget.sqf";
__tky_starts;


{
	if(
		   (([_x, true] call BIS_fnc_objectSide) isEqualTo east)
		   or
		   (side _x isEqualTo east)
		   or
		   (([_x, true] call BIS_fnc_objectSide) isEqualTo independent)
		   or
		   (side _x isEqualTo independent)
	   ) then
		{
			if ((not (_x in preservedvehicles)) and {_x isKindOf "AllVehicles"}) then {_x setdamage 1;};
		}
}foreach (cpt_position nearentities (cpt_radius + 300));
if (cpt_type ==1 ) then
	{
	{_x setdamage 1} foreach roadblockgates;
	};
roadblockscleared = true;
pt_radar setdamage 1;
pt_hq setdamage 1;
debugendmission = true;
__tky_ends