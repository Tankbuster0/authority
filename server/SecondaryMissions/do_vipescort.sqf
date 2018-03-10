//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_vipescort";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private ["_myvip","_vipclass","_potdesttowns","_potdestowns","_thistown","_buildings1","_buildings2","_podests","_buildings3","_buildings4","_buildings5","_smcleanup", "_vipgroup"];
_podests = []; _smcleanup = [];
_vipgroup = createGroup [west, true];
_vipclass = selectrandom vips;
_myvip = _vipgroup createUnit [_vipclass, blubasewhiteboard,[],0, "FORM"];
[_myvip, (format ["vip%1", 1])] call fnc_setVehicleName;
_myvip disableAI "ALL";
_myvip setCaptive true;
_myvip setBehaviour "safe";
[_myvip, "Collect VIP", false] spawn tky_fnc_followLeader;
_smcleanup pushBack _myvip;
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
vipdest = selectRandom _podests;

smmissionstring = format ["There's a VIP %1 waiting at the airhead. We must get him safely to the %2 %3. Air, road or sea - don't care how you do it, just make it happen!", ([_myvip]call tky_fnc_getscreenname), ([vipdest] call tky_fnc_getscreenname), [vipdest] call tky_fnc_distanddirfromtown];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring"; publicVariable "vipdest";
while {missionactive} do
	{
		sleep 2;
		if (not(alive _myvip)) then
			{
			failtext = "The VIP died before getting to his destination. Mission failed.";
			missionsuccess = false;
			missionactive = false;
			};
		if ([_myvip,vipdest] call tky_fnc_pointisinbox) then // vip gets to building. win.
			{
			missionsuccess = true;
			missionactive = false;
			"The VIP got there safely! Good work, team." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
			};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
if (not missionsuccess) then {publicVariable "failtext"};
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
