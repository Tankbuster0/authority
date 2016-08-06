//debug_endprimarytarget
//by tankbuster
_myscript = "debug_endprimarytarget.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];


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
			_x setdamage 1;
		}
}foreach (cpt_position nearentities (cpt_radius + 300));
if (cpt_type ==1 ) then
	{
	{_x setdamage 1} foreach roadblockgates;
	};
pt_radar setdamage 1;
pt_hq setdamage 1;
debugendmission = true;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];