// by tankbuster
 #include "..\includes.sqf"
_myscript = "pt_radarkilled";
__tky_starts;
pt_radar removeAllEventHandlers "Killed";
sleep 0.5;

//format ["The primary target radar installation has been destroyed! The enemy now has no airborne reinforcements."] remoteexec ["hint", -2];
["The primary target radar installation has been destroyed! The enemy now has no airborne reinforcements."] call tky_fnc_t_usefirstemptyinhintqueue;

__tky_ends