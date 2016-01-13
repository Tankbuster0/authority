_myscript = "init.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
if (worldName == "Altis") then
	{
	_location = createlocation ["NameLocal",  [20983,7242,25.656], 100,100];
	_location setText "Feres airfield";
	_location = createLocation ["NameLocal", [23145,18443.621,3.1900], 100, 100];
	_location setText "Almyra airfield";
	_location = createLocation ["NameLocal", [9155.25,21538.2,16.0988], 100,100];
	_location setText "Abdera airfield";
	};
if (("rhs_main" in activatedAddons) and ("rhsusf_main" in activatedAddons)) then {RHS = true} else {RHS = false};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];