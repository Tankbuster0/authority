//by tankbuster
_myscript = "tky_fobveh killed _eh.sqf";
// execvmd by init server
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];

while {true} do
	{
	waitUntil {sleep 10; (not (isNull fobveh))};
	if (not alive fobveh) then
		{
		[fobveh] execVM "server\assetrespawn.sqf";
		sleep 120;
		};

	//waitUntil {sleep 1; not fobrespawning};



	};