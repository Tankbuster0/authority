// by tankbuster
 #include "..\includes.sqf"
_myscript = "pt_hqkilled";
__tky_starts;
sleep 0.5;
hqnet setdamage 1;
//["The enemy HQ here has been destroyed. The enemy now have no further combat air support"] call tky_fnc_t_usefirstemptyinhintqueue;
"The enemy HQ here has been destroyed. The enemy now have no further combat air support." remoteexecCall ["tky_fnc_t_usefirstemptyinhintqueue",2,false];
pt_fire = createVehicle ["test_EmptyObjectForFireBig", (getpos pt_hq), [],0,"NONE"];



__tky_ends