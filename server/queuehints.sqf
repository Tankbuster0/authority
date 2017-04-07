//by tankbuster

 #include "..\includes.sqf"
_myscript = "queuehints";
__tky_starts;
private ["_mytext"];

while {true} do
	{
	waitUntil 	{sleep 2;(hintqueue select 0) != "" };
	_mytext = [hintqueue] call BIS_fnc_arrayShift;
	format ["%1", _mytext] remoteexec ["hint", -2];
	hintqueue set [5,""];
	sleep ((count _mytext /4) min 25);
	};



__tky_ends