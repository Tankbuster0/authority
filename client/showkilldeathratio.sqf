//showkilldeathratio and tankbuster
 #include "..\includes.sqf"
 _myscript = "showkilldeathratio.sqf";

 while {true} do
		{
			__tky_debug
			waitUntil {sleep 0.5; (visibleScoretable)};
			__tky_debug
			private _kdr = ( (getPlayerScores player ) select 0) / ((getPlayerScores player) select 4);
			hint format ["KDR = %1", ([_kdr, 1 ] call BIS_fnc_cutDecimals) ];
			__tky_debug
			waitUntil {sleep 0.5; (not visibleScoretable)};
			__tky_debug
			hint "";
		};
