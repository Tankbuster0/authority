_myscript = "tky_supportmanager.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
while {true} do
	{
		if !(alive player) exitWith {};
		sleep 2;
		if !(SupportReq in synchronizedObjects player) then //if he doesnt already have arty
		{
			if !(isEngineOn vehicle player ) then // and the engine is off
				{
					if ((player in forward ) or (player in fobveh)) then //and hes in forward or fobveh
						{
							if (((assignedVehicleRole player) select 0) isEqualTo "cargo" ) then // and hes in cargo seat
							{
								(player) synchronizeObjectsAdd [SupportReq];
								[player, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
								BIS_supp_refresh = TRUE;
							};
						};
				}
				else
				{
					if (SupportReq in synchronizedObjects player) then //he does have arty but it should be removed..
					{
						[_this select 2, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink",_this select 2, false];
						[SupportReq, ArtySupport] call BIS_fnc_removeSupportLink;
						BIS_supp_refresh = TRUE;
					};
				};
		};
	};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];