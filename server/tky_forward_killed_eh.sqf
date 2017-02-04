//by tankbuster
_myscript = "tky_forward_killed_eh.sqf";
// execvmd by init server
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

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