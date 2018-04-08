//by tankbuster
 #include "..\includes.sqf"
_myscript = "deployselected";
__tky_starts
player removeAction fobdeployactionid;
remoteexec ['tky_fnc_fobvehicledeploymanager',2];
sleep 4;
fobdeployactionid = player addaction ["Deploy/Undeploy FOB", "client\deployselected.sqf", "", 0,false,true, "", " (typeof (vehicle player) isEqualTo fobvehicleclassname )  and {((assignedVehicleRole player) isEqualTo ['cargo'] ) and (not (isEngineOn (vehicle player))) }  "];
//removes the deploy action when the user selects it (to prevent accidental x2 select), remote execs the deploymanager, pauses puts the addaction back on
__tky_ends