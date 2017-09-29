//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_kill1man";
__tky_starts;
//note this script uses "client\sm_repbld_action" to run the repair action
private ["_blacklistedbuildings","_startblds0","_startblds1","_startbldtodmg","_drlbmaster","_nearblds","_nearbldsdeep","_goodbpos","_surfacepos","_nearruins","_nearbldssurfaceruin","_foreachindex","_randpair","_deepbld","_surfacebld","_bldscrn","_bldpos","_mtext","_1texts","_2texts","_3text"];
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
_blacklistedbuildings = ["Land_SCF_01_heap_bagasse_f", "land_slum_01_f", "land_slum_03_f", "Land_House_Small_03_F", "Land_House_Small_04_F", "Land_House_Big_01_F","Land_House_Small_06_F", "Land_House_Big_03_F"];
// Damage a building somewhere in the town so that we have something to go at
_startblds0 = nearestObjects [cpt_position, ["House_f"], cpt_radius + 50, true];
_startblds1 = _startblds0 select { ((getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "DestructionEffects" >> "Ruin1" >> "type")) != "") and ((count (_x buildingPos -1) > 7) )};
_startbldtodmg = selectRandom _startblds1;
_startbldtodmg setdamage 1;
diag_log format ["*** drlb damaged a %1 at start and waiting for it to sink before carrying on", _startbldtodmg];
waitUntil {sleep 1;(getpos _startbldtodmg) select 2 < -95};

// get the buildings that sink their good model
_drlbmaster = []; //master array. [[buriedbld1,ruin1], [buriedbld2,ruin2], ~~~]
_nearblds = nearestObjects [cpt_position, ["House_f"], cpt_radius + 50, true];// all good buildings whether on surface or sunk
diag_log format ["*** @13, _nearblds %1", _nearblds];
_nearbldsdeep = _nearblds select { (((getpos _x) select 2) < -50) and {(count (_x buildingPos -1)) > 7 }};// good buildings that are deep
diag_log format ["*** @15, nbdeep %1", _nearbldsdeep];
{
	_goodbpos = getpos _x,
	diag_log format ["*** @18 goodbpos %1", _goodbpos];
	_surfacepos = [_goodbpos select 0, _goodbpos select 1,0];
	diag_log format ["*** @20 surfacepos %1", _surfacepos];
	_nearruins =  nearestObjects [_surfacepos, ["Ruins_F"], 4, true];
	diag_log format ["*** @22 nearruins %1", _nearruins];
	_nearbldssurfaceruin = _nearruins select 0;
	diag_log format ["*** @24 _nearbldssurfaceruin %1", _nearbldssurfaceruin];
	_drlbmaster pushBack ([_x, _nearbldssurfaceruin ]);
} forEach _nearbldsdeep;
diag_log format ["*** d_rlb says _drlbmaster is %1", _drlbmaster];
{
diag_log format ["*** d_rlb master array record %1 buried %2 at %3 and surfaceruin %4 at %5. 2d distance is %6", _foreachindex, (_x select 0), getpos (_x select 0), (_x select 1), getpos (_x select 1), ((_x select 0) distance2D (_x select 1))];
} foreach _drlbmaster;
_randpair = selectRandom _drlbmaster;
_deepbld = _randpair select 0;
_surfacebld = _randpair select 1;

_bldscrn = [_deepbld] call tky_fnc_getscreenname;
_bldpos = getpos _surfacebld;
diag_log format ["*** d_rlb chooses %1, screenname %2, at %3", _surfacebld, _bldscrn, _bldpos ];
[_surfacebld, "surfacebld"] call fnc_setvehiclename;
[_deepbld, "deepbld"] call fnc_setvehiclename;
_mtext = [_bldpos] call tky_fnc_distanddirfromtown;

_1texts = ["During the assault we damaged a ", "We've been told about some collateral damage suffered by a ", "It seems our people have damaged a ", "Our actions have damaged a "];
_2texts = ["We need to repair this. Hearts and minds, guys. Hearts and minds. ", "We should fix this up. These people support us and we can't ruin their town. ", "We broke it, we need to fix it. ", "Let's make this good again. These people are on our side. "];
_3text = "Only an engineer can do this. If he has a Bobcat or Repair Vehicle near him, it will be completed faster";
smmissionstring = (selectRandom _1texts) + _bldscrn + " " + _mtext + ". " + (selectRandom _2texts) + _3text;

smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";

_bbox0 = boundingBox _surfacebld;
_bb1 = _bbox0 select 0;
_bb2 = _bbox0 select 1;

_mx1y1 = [_bb1 select 0, _bb1 select 1, _bb1 select 2];// model bottom left
_mx1y2 = [_bb1 select 0, _bb2 select 1, _bb1 select 2];// model top left
_mx2y2 = [_bb2 select 0, _bb2 select 1, _bb1 select 2];// model top right
_mx2y1 = [_bb2 select 0, _bb1 select 1, _bb1 select 2];// model bottom right

missionnamespace setvariable ["wx1y1",(surfacebld modelToWorld _mx1y1)];//world bottom left
missionnamespace setvariable ["wx1y2",(surfacebld modelToWorld _mx1y2)];//world top left
missionnamespace setvariable ["wx2y2",(surfacebld modelToWorld _mx2y2)];//world top right
missionnamespace setvariable ["wx2y1",(surfacebld modelToWorld _mx2y1)];//world bottom right
startrlbaction = true;publicVariable "startrlbaction";




while {missionactive} do
	{
	sleep 3;
	if (false) then // work on a failure condition
		{
		missionsuccess = false;
		missionactive = false;
		failtext = "You suck. Mission failed because of reasons"; publicVariable "failtext";
		};

	if ((damage _deepbld) == 0) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
startrlbaction = false; publicVariable "startrlbaction";
publicVariable "missionsuccess";
publicVariable "missionactive";

__tky_ends
