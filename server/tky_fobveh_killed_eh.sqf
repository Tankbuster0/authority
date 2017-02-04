//by tankbuster
_myscript = "tky_fobveh_killed_eh.sqf";
// execvmd by init server
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

while {true} do
	{
	waitUntil {sleep 10; (not (isNull fobveh))};
	if ((not alive fobveh) or (((getPosASL fobveh) select 2) < -2.5)) then
		{
		fobveh setdamage 1;
		[fobveh] execVM "server\assetrespawn.sqf";
		if (fobdeployed) then
			{
				[] call tky_fnc_fobvehicledeploymanager;
				format ["The Forward Operating Base has been destroyed! A new FOB vehicle is being airdropped."] remoteexec ["hint", -2];
			};

		sleep 120;
		};

	//waitUntil {sleep 1; not fobrespawning};



	};