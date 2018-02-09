//debug_makemarker
 #include "..\includes.sqf"
 		_dmkr = createMarker[format["debug%1",floor (random 999999999)], _this select 0];
		_dmkr setMarkerType "mil_dot";
		_dmkr setMarkerText "debug";
		_dmkr setMarkerColor "ColorRed";

