#define filename "primarytargetcleared.sqf"
_thisscript = "primarytargetscleared.sqf";
//by tankbuster
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];

cpt_marker setMarkerColor "ColorPink";
primarytargetcounter = primarytargetcounter + 1;
_nul = execVM "server\getnextprimary.sqf";


diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];