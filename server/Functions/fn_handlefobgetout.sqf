 #include "..\includes.sqf"
_myscript = "handlefobgetout.sqf";
__tky_starts;

	// remove arty comms for anyone getting out of vehicle
[_this select 2, SupportReq, ArtySupport] remoteExecCall ["BIS_fnc_removeSupportLink",_this select 2, false];
BIS_supp_refresh = TRUE;

if ((_this select 0) == forward) then
	{
	if (isNull (driver (_this select 0))) then //someone is getting out of the forward
		{
		if (not isnull (group forward)) then //drivers seat is empty
			{
			//forward driver seat is empty but theres still other crew onboard
			[(group forward), (owner (effectivecommander forward))] remoteexec ["setGroupOwner", 2];
			}
			else
			{
			// forward driver seat is empty and vehicle is now empty
			[forward,2] remoteexec ["setOwner", 2];
			};

		};
	};
if ((_this select 0) == fobveh) then //someone is getting out of the fobveh
	{
	if ((_this select 2) isEqualTo (getAssignedCuratorUnit cur)) then {unassignCurator cur};
	if (isNull (driver fobveh)) then // the drivers seat is empty
		{
		if (not isnull (group fobveh)) then
			{
			//fobveh driverseat is empty but theres still other crew onboard
			[(group fobveh), (owner (effectiveCommander forward))] remoteexec ["setGroupOwner", 2];
			}
			else
			{
			// fobveh drivers seat is empty has got out and vehicle is now empty
			[fobveh,2] remoteexec ["setOwner", 2];
			};

		};
	};
__tky_ends