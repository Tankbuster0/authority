//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_runwaycraterclear";
__tky_starts;
fnc_pickupcrater =
	{
	params ["_thiscrater", "_bobcat"];

	_thiscrater attachto [_bobcat, [0,6,-2] ];

	waitUntil {(speed _bobcat) < -3};
	detach _thiscrater;
	};
private ["_candiposs","_runwayposs","_runwayposshuffled","_nx","_craterpos","_crater","_cratereh"];
mybobcat = createVehicle ["B_APC_Tracked_01_CRV_F", (getpos blubasehelipad), [],0,"NONE"];

_candiposs = nearestObjects [cpt_position, [], 300, true];
_runwayposs = _candiposs select {(str _x) find "bleroa" > 0 };
_runwayposshuffled = _runwayposs call BIS_fnc_arrayShuffle;

for "_nx" from 0 to (playersNumber west + (floor (random 4))) do
	{
	_craterpos = _runwayposshuffled select _nx;
	_crater = createVehicle ["craterlong_small", getpos _craterpos, [],0,"NONE"];
	_cratereh addeventhandler ["epecontactstarts", {if ((attachedObjects (_this select 1)) isEqualTo []) then { } };


	};
/*

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
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";
*/
__tky_ends
