// by tankbuster
 #include "..\includes.sqf"
_myscript = "pt_radarkilled";
__tky_starts;
pt_radar removeAllEventHandlers "Killed";
sleep 0.5;
[pt_radar] call BIS_fnc_effectKilledAirDestruction;

format ["The primary target radar installation has been destroyed! The enemy now has no airborne reinforcements."] remoteexec ["hint", -2];

__tky_ends