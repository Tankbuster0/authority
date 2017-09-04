//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_kill1man";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private [];
// get the buildings that apply a dmaged tex but dont change the model (method "a")

_nearbldsa1 = nearestObjects [cpt_position, ["House_f"], cpt_radius + 20, true];
_nearbldsa2 = _nearbldsa1 select {((damage _x) < 1) and { ((_x buildingPos -1 ) > 6)}  };

// get the buildings that sink their good model (method "b")

_nearbldsb1 = nearestObjects [cpt_position], ["House_f"], cpt_radius + 20, true];
_nearbldsb2 = _nearbldsb1 select { (((getpos _x) select 2) < -90) and {(_x buildingPos -1) > 4}};



_distanddir = [_mytarget] call tky_fnc_distanddirfromtown;
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
