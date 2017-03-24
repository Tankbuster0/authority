
_myscript = "fnc_usefirstemptyinhintqueue";

	private ["_i"];
	params ["_tky_text"];
	for "_i" from 0 to 5 do
		{
		if ((hintqueue select _i) isEqualTo "") exitWith {hintqueue set [_i, _tky_text]};
		};
