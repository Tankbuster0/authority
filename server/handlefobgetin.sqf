_myscript = "handlefobgetin.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

if (!isNull(commander (_this select 0))) then 
{
	if ((_this select 2)  == (commander (_this select 0))) then 
	{
		[_this select 2, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
	} else {};
} else {};
//removeAllActions fobveh;
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];