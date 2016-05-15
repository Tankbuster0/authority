_myscript = "handlefobgetseatchanged.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

{
	if if (str _x == "alpha_10" || str _x == "bravo_10") then {
	[_x, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink", 2, false];} else {};
}forEach crew (_this select 0);

if (!isnull (commander (_this select 0)) ) then 
{
	[(commander (_this select 0)) , SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_addSupportLink", 2, false];
} else {};

//removeAllActions fobveh;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];