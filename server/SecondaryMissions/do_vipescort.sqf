//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_vipescort";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";

_myvip = selectrandom vips;

_buildings1 = (nearestterrainobjects [player, ["house"], 10000, false,true]) select {(sizeof (typeof _x) > 40) and (count (_x buildingpos -1)> 15)};
_buildings2 = _buildings1 select {
		(((str _x) find "bagasse") isequalto -1) or
		(((str _x) find "pier") isequalto -1) or
		(((str _x) find "containerline") isequalto -1) or
		(((str _x) find "drydock") isequalto -1)
		 };






smmissionstring = format ["There's a %1 waiting at the airhead. The enemy reserves are attacking %1. Get your forces organised there and kill them all. Expect mostly mechanised infantry and perhaps an aircraft or two.", cpt_name];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";
private _smcleanup = [];
private _edgeroads0 = []; private _edgeroads1 = []; private _castarttime = floor serverTime; private _warnflag = false;
cavecs = []; caunits = []; cavecintowncounter = 0;

while {missionactive} do
	{

		if (FALSE) then// failure. enemy get a vehicle or aircraft into the middle of the town
			{// currently, there's no failure condition for this
			missionsuccess = false;
			missionactive = false;
			};
		if (({alive _x} count caunits) < 3) then // success. all or most enemy forces are destroyed
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
