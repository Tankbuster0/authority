
_myscript = "fnc_usefirstemptyinhintqueue";

	private ["_i", "_tky_text"];
	params ["_tky_text"];
	for "_i" from 0 to 5 do
		{
		if ((hintqueue select _i) == "") exitWith {(hintqueue select _i) = _tky_text};
		};
