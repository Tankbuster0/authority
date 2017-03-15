//by tankbuster
 #include "..\includes.sqf"
_myscript = "tky_forward_killed_eh.sqf";
// execvmd by init server
__tky_starts;

while {true} do
	{
	waitUntil {sleep 10; (not (isNull forward))};
	if ((not alive forward) or (((getPosASL forward) select 2) < -2.5)) then
		{
		forward setdamage 1;
		[forward] execVM "server\assetrespawn.sqf";
		sleep 120;
		};
	//waitUntil {sleep 1; (not forwardrespawning)};




	};