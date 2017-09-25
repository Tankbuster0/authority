//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_kill1man";
__tky_starts;
private ["_blacklistedbuildings","_drlbmaster","_nearbldssurfaceruin","_nearblds","_nearbldsdeep","_foreachindex","_randpair","_surfacebld","_bldscrn","_bldpos","_bldtosetdam0","_mtext","_1texts","_2texts","_3text"];
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
typeselected = "repairlocalbuilding"; publicVariable "typeselected";// <-- debug only
_blacklistedbuildings = ["Land_SCF_01_heap_bagasse_f", "land_slum_01_f", "land_slum_03_f", "Land_House_Small_03_F", "Land_House_Small_04_F", "Land_House_Big_01_F","Land_House_Small_06_F"];
// get the buildings that sink their good model
_drlbmaster = []; //master array. [[buriedbld1,ruin1], [buriedbld2,ruin2], ~~~]
_nearblds = nearestObjects [cpt_position, ["House_f"], cpt_radius + 50, true];// all good buildings whether on surface or sunk

_nearbldsdeep = _nearblds select { (((getpos _x) select 2) < -90) and {(count (_x buildingPos -1)) > 90 }};// good buildings that are deep
{
	_nearbldssurfaceruin = ((nearestObjects [([((getpos _x) select 0), ((getpos _x) select 1), 0]), ["Ruins_F"], 3, false] ) select 0);
	//^^^ get the ruin that is on the surface
	_drlbmaster pushBack [_x, _nearbldssurfaceruin ];
} forEach _nearbldsdeep;
diag_log format ["*** d_rlb says _drlbmaster is %1", _drlbmaster];
{
diag_log format ["*** d_rlb master array record %1 buried %2 at %3 and surfaceruin %4 at %5. 2d distance is %6", _foreachindex, (_x select 0), getpos (_x select 0), (_x select 1), getpos (_x select 1), ((_x select 0) distance2D (_x select 1))];
} foreach _drlbmaster;
_randpair = selectRandom _drlbmaster;

_surfacebld = _randpair select 1;

_bldscrn = [_randpair select 0] call tky_fnc_getscreenname;
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
typeselected = "none"; publicVariable "typeselected";//<< debug only

__tky_ends
