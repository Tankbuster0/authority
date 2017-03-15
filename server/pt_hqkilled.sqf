// by tankbuster
 #include "..\includes.sqf"
_myscript = "pt_hqkilled";
__tky_starts;
sleep 0.5;
hqnet setdamage 1;
format ["The enemy HQ here has been destroyed. They now have no further combat air support."] remoteexec ["hint", -2];
pt_fire = createVehicle ["test_EmptyObjectForFireBig", (getpos pt_hq), [],0,"NONE"];


__tky_ends