// by tankbuster
 #include "..\includes.sqf"
_myscript = "pt_radarkilled";
__tky_starts;
pt_radar removeAllEventHandlers "Killed";
sleep 0.5;
_pos = getpos pt_radar;
[pt_radar] call BIS_fnc_effectKilledAirDestruction;
deleteVehicle pt_radar;
sleep 2;
pt_radar =  createVehicle ["Land_Factory_Hopper_ruins_F", _pos, [],0, "CAN_COLLIDE"];
pt_radar setdamage 1;
format ["The primary target radar installation has been destroyed! The enemy now has no airborne reinforcements."] remoteexec ["hint", -2];



__tky_ends