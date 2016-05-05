_myscript = "playersetup.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
waituntil {alive player};
//waituntil {(((player distance fobveh) < 10) or ((player distance forward) < 10) or ((player distance ammobox) < 10)) };
waitUntil {((((getpos player select 0) > 100) and ((getpos player select 1) > 100)) or ((player distance forward) < 10) or ((player distance ammobox)< 10))};
sleep 0.5;
//^^^ wait until player really REALLY properly is in game
if (isNil{fobveh}) then
	{
	fobveh = [missionNamespace, "fobveh", nil] call BIS_fnc_getServerVariable;
	};

//fobdeployactionid = player addaction ["Deploy FOB", "remoteexec ['tky_fnc_fobvehicledeploymanager',2]", "", 0,false,false, "", "(typeof (vehicle player) == 'CUP_B_Mastiff_HMG_GB_W' ) and (round (speed vehicle player) isEqualTo 0)"];

//sleep 10;
diag_log format ["***4 pos player %1", getpos player];
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];

// (player isEqualTo (driver fobveh))