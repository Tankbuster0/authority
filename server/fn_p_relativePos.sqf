// by Zapat and Tankbuster
//Edited by SPUn
_myscript = "fn_p_relativePos.sqf"

	private ["_p1", "_dir","_dst","_r","_alt"];
	_p1 = _this select 0;
	_dir = _this select 1;
	_dst = _this select 2;

	_alt = 0;
	if (count _this > 3) then {_alt = _this select 3};

	_r = [(_p1 select 0) + sin _dir * _dst,(_p1 select 1) + cos _dir * _dst,_alt];

	_r