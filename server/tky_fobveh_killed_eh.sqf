//by tankbuster
 #include "..\includes.sqf"
_myscript = "tky_fobveh_killed_eh.sqf";
// execvmd by init server
__tky_starts;

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