 #include "..\includes.sqf"
_myscript = "fnc_usefirstemptyinhintqueue";
__tky_starts;
fnc_usefirstemptyinhintqueue =
	{
	private ["_i", "_tky_text"];
	params ["_tky_text"];
	//if (hintqueue select 0) isEqualTo "" then {(hintqueue select 0) = tky_text};
	//can this be done in a loop?
	for "_i" from 0 to 5 do
		{
		if ((hintqueue select _i) == "") exitWith {(hintqueue select _i) = _tky_text};
		};
	};
__tky_ends