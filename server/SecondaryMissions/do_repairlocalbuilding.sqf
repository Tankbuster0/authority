//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_kill1man";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private [];

_blacklistedbuildings = ["Land_SCF_01_heap_bagasse_f", "land_slum_01_f", "land_slum_03_f"];
// get the buildings that apply a dmaged tex but dont change the model (method "a")

_nearbldsa1 = nearestObjects [cpt_position, ["House_f"], cpt_radius + 20, true];
_nearbldsa2 = _nearbldsa1 select {((damage _x) < 1) and { ((_x buildingPos -1 ) > 6)}  };

// get the buildings that sink their good model (method "b")
_nearbldsb2 = _nearbldsa1 select { (((getpos _x) select 2) < -90) and {(_x buildingPos -1) > 4}};
{
	_nearbldsb3  pushback ((nearestObjects [([((getpos _x) select 0), ((getpos _x) select 1), 0]), ["Ruins_F"], 3, false] ) select 0);
	^^^ // get the ruin that is on the surface
} forEach _nearbldsb2;
diag_log format ["*** d_rlb has damagedtex buildings %1", _nearbldsa2];
diag_log format ["*** d_rld has buried good buildings %1, count %2", _nearbldsb2, count _nearbldsb2];
diag_log format ["*** d_rld finds surface ruins %1 count %2", _nearbldsb3, count _nearbldsb3];

_actualblds = _nearbldsa2;
_actualblds = _actualblds + _nearbldsb3;

_bldtorepair = selectRandom _actualblds;
_bldscrn = [_bldtorepair] call tky_fnc_getscreenname;
_bldpos = getpos _bldtorepair;
diag_log format ["*** d_rlb chooses %1, screenname %2, at %3", _bldtorepair, _bldscrn, _bldpos ];

_mtext = [_bldpos] call tky_fnc_distanddirfromtown;

// ^^^ got this far

smmissionstring = format ["Do some shit at %1 and blah blah etc", _sometown getVariable "targetname"];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";

 failtext = "Dudes. You suck texts";
_
while {missionactive} do
	{
	sleep 3;
	if (/*failure conditions*/) then
		{
		missionsuccess = false;
		missionactive = false;
		failtext = "You suck. Mission failed because of reasons"; publicVariable "failtext";
		};

	if (/*succeed conditions*/) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
