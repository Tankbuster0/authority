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

tky_super_hint = compilefinal "_parray = [_this, 0] call BIS_fnc_param;
	_text = [_this ,1] call BIS_fnc_param;
	{if (_x == player) then {hint _text; [playerSide, 'HQ'] sideChat _text;};}foreach _parray;"; call BIS_fnc_MP;
tky_setfuel = compileFinal "(_this select 0) setfuel (_this select 1);" call BIS_fnc_MP;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];