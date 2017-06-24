//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_runwayclear";
__tky_starts;




while {missionactive} do
	{
	sleep 3;
	if (not(alive _smsaveh) or (fuel _smsaveh isEqualTo 0)) then
		{
		missionsuccess = false;
		missionactive = false;
		};
	if ((not(_playerinveh)) and {isplayer (effectiveCommander _smsaveh)}) then {_playerinveh = true};
	if (_playerinveh and {(speed _smsaveh < 1) and (_smsaveh distance2D blubasehelipad) < 20}) then
		{
		missionsuccess = true;
		missionactive = false;
		};
	};
[_smcleanup, 1] call tky_fnc_smcleanup;
__tky_ends
