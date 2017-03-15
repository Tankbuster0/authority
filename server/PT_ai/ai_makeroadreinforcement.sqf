// by tankbuster
 #include "..\includes.sqf"
_myscript = "ai_makeroadreinforcement.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
private ["_cpt","_furthestdistsofar","_furthestlocsofar","_pcst2","_possibleconvoystartpoints","_mn","_mkr","_nearestblufors","_bestconvoystartpoint","_data1","_bcsproad","_cveh","_rrgroup","_z","_unit","_cevh", "_bcsp_name"];
_cpt = _this select 0; // actually a logic
// choose a town a couple of K away, away from other blufor towns
_furthestdistsofar = 0; _furthestlocsofar = objNull; _pcst2 = [];
_possibleconvoystartpoints = _cpt nearEntities ["Logic", 5000];
{
	if (((_x getVariable ["targetstatus", -1]) == 1) and ((_x distanceSqr _cpt) > 38)) then {_pcst2 pushback _x}; //if the town being checked is a real town, enemy held and more than 1500m away, add it to the pcst2 array
} foreach _possibleconvoystartpoints;
// found a bunch of enemyheld towns between 3k and 1.5k away. Now take the one that is furthest from blufor
//find nearest blufor town
{
	_nearestblufors = nearestobjects [_x, ["Flag_Blue_F"], 5000/*, false*/];
	if (_nearestblufors isEqualTo []) exitWith {_bestconvoystartpoint = _x};
	_data1 = _nearestblufors select 0;
	if ((_data1 distance _x) > _furthestdistsofar) then
		{_furthestdistsofar = (_data1 distance _x);
		_bestconvoystartpoint = _x;
		_bcsp_name = (_x getVariable "targetname");
		};
} foreach _pcst2;
//get a road section at the convoy start, put a vehicle there and give it a wp
_bcsproad = [getpos _bestconvoystartpoint, 1000, []] call bis_fnc_nearestRoad;

/*_mkr = createMarker ["mkr", (getpos _bestconvoystartpoint) ];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "hd_dot";*/
sleep 15;
_rrgroup = createGroup east;
_cveh = [(getpos _bcsproad), ([getpos _bcsproad, _cpt] call bis_fnc_dirTo), opfor_reinf_truck, _rrgroup] call tky_fnc_spawnandcrewvehicle;
_cveh setUnloadInCombat [true, false];
_cveh addEventHandler ["HandleDamage", {if (isNull (_this select 3)) then { 0; } else { _this select 2; }; }]; // tankys magic no damage when shit driver crashes

roadreinforcementvehicles pushback _cveh;
sleep 10;
_rrgroup allowFleeing 0;
_rrgroup setCombatMode "GREEN";
_rrgroup setFormation "COLUMN";
_rrgroup setSpeedMode "LIMITED";
_wp1 = _rrgroup addWaypoint [(getpos _bcsproad),0];
_wp1 setWaypointBehaviour "SAFE";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setwaypointtype "MOVE";
_wp1 setWaypointFormation "COLUMN";

_wp2 = _rrgroup addWaypoint [_cpt, 40];
_wp2 setWaypointType "UNLOAD";
_wp2 setWaypointBehaviour "SAFE";
//_wp2 setWaypointScript "server\PT_ai\ai_roadreinforcementsattack.sqf";
_wp2 setWaypointStatements [ "true", "_nul = this execVM 'server\PT_ai\ai_roadreinforcementsattack.sqf'"];
//diag_log format ["*** mrr makes a truck at %1", _bcsp_name];
__tky_ends