// by tankbuster
 #include "..\includes.sqf"
_myscript = "pt_radarkilled";
__tky_starts;
pt_radar removeAllEventHandlers "Killed";
sleep 0.5;
pt_radar_alive = false;
//["The primary target radar installation has been destroyed! The enemy now has no airborne reinforcements."] call tky_fnc_usefirstemptyinhintqueue;
"The primary target radar installation has been destroyed! The enemy now has no airborne reinforcements." remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
__tky_ends