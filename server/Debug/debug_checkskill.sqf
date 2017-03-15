//debug_checkskill
 #include "..\includes.sqf"
{
	_munit = _x;
	diag_log format ["*** checkskill output: %1, aimac %2, aimsk %3, aimsp %4, cour %5", _munit, _munit skill "aimingAccuracy", _munit skill "aimingShake", _munit skill "aimingSpeed", _munit skill "courage"];
} foreach allUnits;
