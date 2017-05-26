//by tankbuster
 #include "..\includes.sqf"
_myscript = "replacequads";
__tky_starts;
while {primarytargetcounter isEqualTo 1} do

	{
		sleep 5;
		_headobjs = (markerpos "headmarker1" nearEntities 50) select {(isplayer _x) or (_x isKindOf "Quadbike_01_base_f")};
		if (count _headobjs < 1) then
		{
			_quadpos = [(markerpos "headmarker1"), 0, 12,3,0,1,0] call BIS_fnc_findSafePos;
			"B_Quadbike_01_F" createVehicle _quadpos;
		};



	};
__tky_ends