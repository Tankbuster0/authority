 #include "..\includes.sqf"
_myscript = "tky_supportmanager.sqf";
__tky_starts;
while {true} do
	{
		sleep 3;
		if not (SupportReq in (synchronizedObjects player)) then //if he doesnt already have arty
		{
			if ((not(isEngineOn vehicle player )) and {(player in forward) or (player in fobveh)} and {((assignedVehicleRole player) select 0) isEqualTo "cargo"} and {alive player} and {(incapacitatedState player) isEqualTo "" }) then // and he fulfill all the conditions
				{
					(player) synchronizeObjectsAdd [SupportReq];
					[player, SupportReq, ArtySupport] call BIS_fnc_addSupportLink;
					BIS_supp_refresh = TRUE; publicVariable "BIS_supp_refresh";

				}
		}
		else
		{
			if (SupportReq in (synchronizedObjects player))  then
			{
				if ((isEngineOn vehicle player) or (not ((player in forward) or (player in fobveh))) or (not(((assignedVehicleRole player) select 0) isEqualTo "cargo")) or (not ( alive player)) or (not((incapacitatedState player) isEqualTo "" )))  then //he has arty but doesnt fulfill all of the conditions, arty should be rmeoved
					{
						player synchronizeObjectsRemove [SupportReq];
						[SupportReq, ArtySupport] call BIS_fnc_removeSupportLink;
						BIS_supp_refresh = TRUE; publicVariable "BIS_supp_refresh";

					};
			};
		};
	};

__tky_ends

