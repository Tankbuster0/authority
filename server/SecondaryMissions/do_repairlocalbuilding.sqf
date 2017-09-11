//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_kill1man";
__tky_starts;
private ["_blacklistedbuildings","_nearbldsa1","_nearbldsa2","_nearbldsb2","_nearbldsb3","_actualblds","_surfacebld","_bldscrn","_bldpos","_mtext","_1texts","_2texts","_3text","_smcleanup", "_method"];
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
typeselected = "repairlocalbuilding"; publicVariable "typeselected";// <-- debug only
_method = "a";
_blacklistedbuildings = ["Land_SCF_01_heap_bagasse_f", "land_slum_01_f", "land_slum_03_f", "Land_House_Small_03_F"];
// get the buildings that apply a dmaged tex but dont change the model (method "a")
_nearbldsb3 = [];
_nearbldsa1 = nearestObjects [cpt_position, ["House_f"], cpt_radius + 20, true];
_nearbldsa2 = _nearbldsa1 select {((damage _x) > 0) and ((count (_x buildingPos -1 )) > 6) and (not ((typename _x) in _blacklistedbuildings) ) };

// get the buildings that sink their good model (method "b")
_nearbldsb2 = _nearbldsa1 select { (((getpos _x) select 2) < -90) and {(count (_x buildingPos -1)) > 4}};
{
	_nearbldsb3 pushback ((nearestObjects [([((getpos _x) select 0), ((getpos _x) select 1), 0]), ["Ruins_F"], 3, false] ) select 0);
	//^^^ get the ruin that is on the surface
} forEach _nearbldsb2;
diag_log format ["*** d_rlb has %2 damagedtex buildings %1", _nearbldsa2, count _nearbldsa2];
diag_log format ["*** d_rld has %2 buried good buildings %1", _nearbldsb2, count _nearbldsb2];
diag_log format ["*** d_rld finds %2 surface ruins %1", _nearbldsb3, count _nearbldsb3];
_actualblds = _nearbldsa2;// <-- a2 = tex buildings, on surface, damaged. method a
_actualblds = _actualblds + _nearbldsb3; // <-- b3 = surfaceruin, method b
_surfacebld = selectRandom _actualblds;
if (_surfacebld in _nearbldsb3) then {_method = "b"};
if (_method isEqualTo "b") then
	{
	_bldtosetdam0 = ((nearestObjects [([((getpos _surfacebld) select 0), ((getpos _surfacebld) select 1), -100]), ["house_f"], 15, false] ) select 0);
	diag_log format ["*** d_rlb because method b, bld to setdam0 to is %1 at %2 and is deep underground %3",_bldtosetdam0, getpos _bldtosetdam0, ((getpos _bldtosetdam0 select 2) < -80)];
	}
	else
	{
	_bldtosetdam0 = _surfacebld;
	diag_log format ["*** d_rlb because method a, bld to setdam0 is %1 at %2 and is on the surface %3 ", _bldtosetdam0, getpos _bldtosetdam0, ((getpos _bldtosetdam0) select 2 ) > -4];
	}
_bldscrn = [_bldtosetdam0] call tky_fnc_getscreenname;
_bldpos = getpos _surfacebld;
diag_log format ["*** d_rlb chooses %1, screenname %2, at %3", _surfacebld, _bldscrn, _bldpos ];
[_surfacebld, "surfacebld"] call fnc_setvehiclename;
[_bldtosetdam0, "bldtosetdam0"] call fnc_setvehiclename;
_mtext = [_bldpos] call tky_fnc_distanddirfromtown;

_1texts = ["During the assault we damaged a ", "We've been told about some collateral damage suffered by a ", "It seems our people have damaged a ", "Our actions have damaged a "];
_2texts = ["We need to repair this. Hearts and minds, guys. Hearts and minds. ", "We should fix this up. These people support us and we can't ruin their town. ", "We broke it, we need to fix it. ", "Let's make this good again. These people are on our side. "];
_3text = "Only an engineer can do this. If he has a Bobcat or Repair Vehicle near him, it will be completed faster";
smmissionstring = (selectRandom _1texts) + _bldscrn + " " + _mtext + ". " + (selectRandom _2texts) + _3text;

smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";

while {missionactive} do
	{
	sleep 3;
	if (false) then // work on a failure condition
		{
		missionsuccess = false;
		missionactive = false;
		failtext = "You suck. Mission failed because of reasons"; publicVariable "failtext";
		};

	if ((damage _bldtosetdam0) == 0) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		//^^^ got this far. need to make success conditions
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";

__tky_ends
