//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_stealaircaft";
__tky_starts;
//steal aircraft
_airport = selectRandom foundairfields;
_airportlogics = entities "logic" select {((_x getVariable "targettype") isEqualTo 2) and ((_x getVariable "targetstatus") isEqualTo 1)};//get all enemy held airfields

_smairfield =  selectRandom _airportlogics;

 format ["Secondart mission aircraft steal at %1", _smairfield getVariable "targetname"] remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
_hbuildings = (nearestTerrainObjects [_smairfield, ["building"], 1000]) select {_x find "anga" > -1};
diag_log format ["*** dsa finds %1 hangars ", count _hbuildings];

__tky_ends


