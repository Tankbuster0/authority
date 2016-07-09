//debug_endprimarytarget
//by tankbuster
_myscript = "debug_endprimarytarget.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];


{if(side _x isEqualTo east)then{_x setdamage 1}}foreach (cpt_position nearentities (cpt_radius + 200));
if (cpt_type ==1 ) then
	{
	{_x setdamage 1} foreach roadblockgates;
	};
pt_radar setdamage 1;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];