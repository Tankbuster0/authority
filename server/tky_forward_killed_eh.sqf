//by tankbuster
_myscript = "tky_forward killed _eh.sqf";
// execvmd by init server
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

while {true} do
	{
	waitUntil {sleep 1; (not (isNull forward))};
	if (not alive forward) then
		{
		[forward] execVM "server\assetrespawn.sqf";
		};
	waitUntil {sleep 1; (not forwardrespawning)};




	};