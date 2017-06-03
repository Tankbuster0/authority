
_myscript = "fnc_usefirstemptyinhintqueue";
// USAGE FROM EITHER CLIENT OR SERVER
// "TEXT IN HERE" remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
	private ["_i"];
	params ["_tky_text"];
	for "_i" from 0 to 9 do
		{
		if ((hintqueue select _i) isEqualTo "") exitWith {hintqueue set [_i, _tky_text]};
		};
