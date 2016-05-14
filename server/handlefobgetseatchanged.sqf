_myscript = "handlefobgetseatchanged.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

{
	[_x, SupportReq, ArtySupport] call BIS_fnc_removeSupportLink;
}forEach crew (_this select 0);

if (!isnull (commander (_this select 0)) ) then 
{
	[(commander (_this select 0)) , SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
} else {};

//removeAllActions fobveh;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];