//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_vipescort";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private ["_myvip","_potdesttowns","_potdestowns","_thistown","_buildings1","_buildings2","_podests","_vipdest","_vipdestactual","_buildings3","_buildings4","_buildings5","_smcleanup"];
_podests = [];
_myvip = selectrandom vips;

_potdesttowns = (cpt_position nearEntities ["Logic", 5000]) select {((_x getVariable ["targetstatus", -1]) > -1) and {(_x distance2d cpt_position) > 1000}};
if ((call tky_fnc_fleet_heli_vtols) isEqualTo []) then
	{
		_potdesttowns = _potdesttowns select {(_x getVariable ["targetlandmassid", -1]) isEqualTo cpt_island};
		diag_log format ["***dvipe says team have no helis so only selecting dests on same island"];
	};
//^^ towns we could use.. now find a building near one of them
diag_log format ["***possible towns count is %1", count _potdesttowns];
{
	_thistown = _x;
	_buildings1 = (nearestterrainobjects [_thistown, ["house", "church", "chapel", "tourism"], 300, false,true]) select {(sizeof (typeof _x) > 28) and (count (_x buildingpos -1) > 13)};
	diag_log format ["***b1 counts %1 houses, churches, chapels and tourisms in %2", count _buildings1, _thistown getVariable "targetname"];
	_buildings2 = _buildings1 select {
			(((str _x) find "bagasse") isequalto -1) and
			(((str _x) find "pier") isequalto -1) and
			(((str _x) find "containerline") isequalto -1) and
			(((str _x) find "drydock") isequalto -1) and
			(((str _x) find "scf") isequalto -1) and
			(((str _x) find "storagetank") isequalto -1) and
			(((str _x) find "hangar") isequalto -1)
			 };
	if ((count _buildings2 ) > 10) then
		{
			_buildings2 = _buildings2 select {(((str _x) find "warehouse") isEqualTo -1)};
			_buildings2 = _buildings2 select {(((str _x) find "barracks") isEqualTo -1)};
			diag_log format ["***lots of buildings so removed the warehouses and barracks"];
		};
	_podests append _buildings2;// all the applicable buildings within this town
}foreach _potdesttowns;
//_podests should now be a big array of all the applicable buildings inside the towns nearenough and on the appropriate island

_vipdest = selectRandom _podests;
_vipdestactual = typeOf _vipdest;

smmissionstring = format ["There's a VIP %1 waiting at the airhead. We must get him safely to the %2 %3. Air, road or sea - don't care how you do it, just make it happen!", ([_myvip]call tky_fnc_getscreenname), ([_vipdest] call tky_fnc_getscreenname), [_vipdest] call tky_fnc_distanddirfromtown];




/*
_buildings3 = [];
{
_buildings3 pushBack ([_x] call tky_fnc_stripidandcolonandspace);
} foreach _buildings2;
diag_log format ["***b3 is %1", _buildings3];
_buildings4 = _buildings3 call BIS_fnc_consolidateArray;
diag_log format ["***b4 is %1", _buildings4];
_buildings5 = [];
{
	_buildings5 pushback [(_x select 1), (_x select 0)];
} foreach _buildings4;
diag_log format ["***b5 preseroted is %1", _buildings5];
_buildings5 sort true;
diag_log format ["*** b5 post sort is %1", _buildings5];
{
	diag_log format ["%1", _x];
} foreach _buildings5;
*/

smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";


while {missionactive} do
	{

		if (FALSE) then// failure. enemy get a vehicle or aircraft into the middle of the town
			{// currently, there's no failure condition for this
			missionsuccess = false;
			missionactive = false;
			};
		if (FALSE) then // success. all or most enemy forces are destroyed
			{
			missionsuccess = true;
			missionactive = false;
			"Your team defeated the attack. Good work guys." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			{_x setDamage 1;} forEach caunits;
			};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
if (not missionsuccess) then {publicVariable "failtext"};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
