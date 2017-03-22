//by tankbuster

 #include "..\includes.sqf"
_myscript = "queuehints";
__tky_starts;
private [];

while {true} do
	{
	waitUntil 	{sleep 2;(hintqueue select 0) != "" };
	format ["%1", [hintqueue] call BIS_fnc_arrayShift;] remoteexec ["hint", -2];
	hintqueue set [5,""];
	sleep 25;
	};



__tky_ends