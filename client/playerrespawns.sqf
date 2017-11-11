 #include "..\includes.sqf"
_myscript = "playersetup.sqf";
__tky_starts;
// replace all of the many respawn ehs with a single one that calls this file

if ("PARAM_Fatigue" call BIS_fnc_getParamValue == 0) then
	{
		player enableStamina false;
	};

if !("PARAM_AimSway" call BIS_fnc_getParamValue == 100) then
	{
		private _coef = ("PARAM_AimSway" call BIS_fnc_getParamValue) / 10;
		player setCustomAimCoef _coef;
		player setUnitRecoilCoefficient 0.2 + _coef;
	};












__tky_ends;