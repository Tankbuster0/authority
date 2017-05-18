// by tankbuster
// takes a position and returns a logic
#include "..\includes.sqf"
_myscript = "choosenextprimary.sqf";
private ["_pos","_allpossibletargets","_mbi","_nvc","_notlegittargets","_overseastargets","_logics","_tstatus","_ttype","_tname","_dir","_dist","_onislandtargets","_finaltargetlist","_sortedtargetlist"];
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
_pos = _this select 0;// position of the old target
__tky_debug;
_allpossibletargets = [];
islandhop = false;
_mbi = ["militarybasesincluded", 1] call BIS_fnc_getParamValue;
_nvc = ["notveryclose",500] call BIS_fnc_getParamValue;
_notlegittargets = []; _overseastargets = [];
//_logics = entities "Logic";
_logics = _pos nearEntities ["Logic", 6000];
sleep 0.1;
//count how many remaining targets on this island
__tky_debug;
_rtoti = {(((_x getVariable ["targetstatus", -1]) isEqualTo 1) and ((_x getVariable ["targetlandmassid", -1]) isEqualTo cpt_island))} count _logics; // redtargetsonthisisland
_btoti = {(((_x getVariable ["targetstatus", -1]) isEqualTo 2) and ((_x getVariable ["targetlandmassid", -1]) isEqualTo cpt_island))} count _logics; // blutargetsonthisisland
_atoti = {((floor (_x getVariable ["targetlandmassid", -1])) isEqualTo cpt_island)} count _logics; // alltargetsonthisisland

diag_log format ["*** cnp gives blucount %1 and redcout %2 and total targets %3", _btoti, _rtoti, _atoti];
__tky_debug;
if (_rtoti < 2) then
	{
		islandhop = true;
		publicVariable "islandhop";
		["bfkilledeh", {execVM "server\tky_bf_killed_eh.sqf";}, 60, "seconds"] call BIS_fnc_runLater;
	};

{
	_tstatus = _x getVariable ["targetstatus", -1];
	_ttype = _x getVariable ["targettype", -1];
	_tname = _x getVariable ["targetname", "Springfield"];
	_tlmass = _x getVariable ["targetlandmassid", -1];
	if (islandhop) then {_tlmass = cpt_island}; //if islandhop, make all the targets appear to have the same landmassid as the current one, effectively allowing it to choose overseas targets.
	_dir = _pos getdir _x;
	_dist = _pos distance2d _x;
	if (
		    (isNil "_tstatus") or
		    (_tstatus != 1) or
		    ((_mbi == 0) and (_ttype == 3) ) or
		    ((_pos distance2D _x) < _nvc) or
		    (_tlmass != cpt_island)
		) then
				{_notlegittargets pushback _x;};
} forEach _logics;
_finaltargetlist = _logics - _notlegittargets;
__tky_debug;
if (testmode) then {diag_log format ["***@42 cnp removed %1 from the list because they are not legit targets", count _notlegittargets]};

sleep 0.1;

if ((count _finaltargetlist) > 1) then
	{_sortedtargetlist = [_finaltargetlist, [] , {_x distanceSqr _pos}, "ASCEND"] call BIS_fnc_sortBy;}
	else
	{_sortedtargetlist = _finaltargetlist;};
__tky_debug;
sleep 0.1;
if (testmode) then
	{
		diag_log "***cnp@ 55 has sorted";
		{diag_log format ["*** cnp:  %1 is %2m from pos and %3 overseas", (_x getVariable "targetname"), (floor (_x distance2d _pos)), (if (_x in _overseastargets) then {"is"} else {"isnt"})  ] } foreach _sortedtargetlist;
	};
_sortedtargetlist resize 2;
nextpt = selectRandom _sortedtargetlist;
__tky_debug;
if ((nextpt getVariable ["targetlandmassid", -1] ) != cpt_island) then
	{// island hopping. give players a blackfish veh transport
		_nul7 = [(getMarkerPos "headmarker2"), blufordropaircraft, "B_T_VTOL_01_vehicle_F", [0,0,200] , "Because the next target is on a different island, you are being given a transport aircraft"] execVM "server\spawnairdrop.sqf";
		//format ["The next target is on a different island. There's a Blackfish vehicle transport being dropped in a container at the airhead."] remoteexec ["hint", -2];
	};
sleep 0.1;
__tky_debug;
if (testmode) then {diag_log format ["***cnp chooses %1 which is radius %2", (nextpt getVariable "targetname"), nextpt getVariable "targetradius"]};
diag_log format ["*** %1 ends %2, %3", _myscript, diag_tickTime, time];
nextpt