// by tankbuster
_myscript = "pt_radarkilled";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
sleep 0.5;
[pt_radar] call BIS_fnc_effectKilledAirDestruction;
sleep 2;
format ["The primary target radar installation has been destroyed! The enemy now has no air support."] remoteexec ["hint", -2];



diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];