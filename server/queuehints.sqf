//by tankbuster
 #include "..\includes.sqf"
_myscript = "queuehints";
__tky_starts;
private ["_mytext"];
while {true} do
	{
	waitUntil 	{sleep 2;(hintqueue select 0) != "" };
	_mytext = [hintqueue] call BIS_fnc_arrayShift;
	parsetext format [" <img image= 'pics\authlogo2.paa'/> <br /> <t color='#ffff00'>%1</t>", _mytext] remoteexec ["hint", -2];
	if (testmode) then {diag_log format ["*** queuehints will say %1", _mytext]};
	hintqueue set [9,""];
	sleep (((count _mytext) /5) min 10);
	};
__tky_ends


