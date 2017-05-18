//by tankbuster
 #include "..\includes.sqf"
_myscript = "tky_bf_killed_eh.sqf";
// execvmd by init server
__tky_starts;

while {true} do
	{
	waitUntil {sleep 10; (true and {not (isNull bf))}};
	if ((not alive bf) or (((getPosASL bf) select 2) < -2.5)) then
		{
		bf setdamage 1;
		[bf] execVM "server\assetrespawn.sqf";
		sleep 120;
		};
	//waitUntil {sleep 1; (not forwardrespawning)};




	};