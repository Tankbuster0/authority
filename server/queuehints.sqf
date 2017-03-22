//by tankbuster

 #include "..\includes.sqf"
_myscript = "queuehints";
__tky_starts;
private [];

while {true} do
	{
	waitUntil 	{sleep 2;(hintqueue select 0) != "" };
	format ["%1", hintqueue select 0] remoteexec ["hint", -2];
	sleep 25;
	_mydata = [hintqueue] call BIS_fnc_arrayShift;
	hintqueue set [5,""];
	};



__tky_ends