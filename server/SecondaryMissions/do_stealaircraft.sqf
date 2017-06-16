//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_stealaircaft";
__tky_starts;
//steal aircraft
_airport = selectRandom foundairfields;
_airportlogics = entities "logic" select {((_x getVariable "targettype") isEqualTo 2) and {((_x getVariable "targetstatus") isEqualTo 1) and ((_x getVariable "targetstatus") != 2)}};//get all enemy held airfields that are not current target

_smairfield =  selectRandom _airportlogics;

 format ["Secondart mission aircraft steal at %1", _smairfield getVariable "targetname"] remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
_hbuildings = ((nearestTerrainObjects [_smairfield, ["HOUSE"], 1000])) select {((typeof _x) find "anga") > -1};
diag_log format ["*** dsa finds %1 hangars ", count _hbuildings];
if ((_hbuildings < 1) or (random 1 > 0.5))then
	{_smtype = "heli";
	_smveh = selectRandom opfor_helis;
	}	else
	{_smtype = "plane";
	_smveh = selectRandom opfor_planes;
	};

diag_log format ["*** dsa is choosing a %1 %2", _smveh, _smtype];



__tky_ends


