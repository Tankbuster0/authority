//showkilldeathratio and tankbuster
 #include "..\includes.sqf"
 _myscript = "showkilldeathratio.sqf";
__tky_starts
 while {true} do
		{
			waitUntil {sleep 0.5; (visibleScoretable)};
			private _kdr = ( (getPlayerScores player ) select 0) / ((getPlayerScores player) select 4);
			hint format ["KDR = %1", ([_kdr, 1 ] call BIS_fnc_cutDecimals) ];
			waitUntil {sleep 0.5; (not visibleScoretable)};
			hint "";
		};
__tky_ends