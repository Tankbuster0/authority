//by tankbuster
_myscript = "primarytargetcleared.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
nextpt setvariable ["targetstatus", 2];
cpt_marker setMarkerColor "ColorPink";
primarytargetcounter = primarytargetcounter + 1;
_nul = execVM "server\doprimary.sqf";


diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];