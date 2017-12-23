//by tankbuster
 #include "..\includes.sqf"
 __tky_starts
_myscript = "addactiopns";
fobdeployactionid = player addaction ["Deploy/ Undeploy FOB", "remoteexec ['tky_fnc_fobvehicledeploymanager',2]", "", 0,false,true, "", " (typeof (vehicle player) isEqualTo fobvehicleclassname )  and {((assignedVehicleRole player) isEqualTo ['cargo'] ) and (not (isEngineOn (vehicle player))) }  "];
vehiclespawnerid1 = player addaction ["Make Quadbike", "client\fn_spawnrunabout.sqf","",0,false,true, "","_myobj = getCursorObjectParams; (typeof (_myobj select 0)) isEqualTo 'Land_DataTerminal_01_F' and {(_myobj select 2) < 2}"];
bfboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "(player distance2d bfbox) < 3"];
prizeboxactionid = player addaction ["Assemble Aircraft", "client\assembleaircraft.sqf", "", 0, false,false, "", "(player distance2D prizebox) < 3"];
flipactionid = player addAction ["Flip Vehicle", "client\unflipvehicle.sqf", "", 0, false, true, "", "_this == vehicle _target && {(vectorUp _target) select 2 < 0}"];
__tky_ends