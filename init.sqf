#define filename "init.sqf"
_thisscript = "init.sqf";
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
if (worldName == "Altis") then
	{
	_location = createlocation ["NameLocal",  [20983,7242,25.656], 100,100];
	_location setText "Feres airfield";
	_location = createLocation ["NameLocal", [23145,18443.621,3.1900], 100, 100];
	_location setText "Almyra airfield";
	_location = createLocation ["NameLocal", [9118.67,21513.1,15.8545], 100,100];
	_location setText "Abdera airfield";
	};



diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];