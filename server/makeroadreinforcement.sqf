// by tankbuster
_myscript = "makeroadreinforcement.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
private ["_cpt","_furthestdistsofar","_furthestlocsofar","_pcst2","_possibleconvoystartpoints","_mn","_mkr","_nearestblufors","_bestconvoystartpoint","_data1","_bcsproad","_cveh","_rrgroup","_z","_unit","_cevh"];
_cpt = _this select 0; // actually a logic
//diag_log format ["*** mrr @ 6 _cpt %1", _cpt];
// choose a town a couple of K away, away from other blufor towns
_furthestdistsofar = 0; _furthestlocsofar = objNull; _pcst2 = [];
_possibleconvoystartpoints = _cpt nearEntities ["Logic", 3000];
//diag_log format ["*** mrr @ 10 possconvstartpoints count %1 ", count _possibleconvoystartpoints];
{
	if (((_x getVariable ["targetstatus", -1]) == 1) and ((_x distance _cpt) > 1500)) then {_pcst2 pushback _x}; //if the town being checked is a real town, enemy held and more than 1500m away, add it to the pcst2 array
} foreach _possibleconvoystartpoints;
// found a bunch of enemyheld towns between 3k and 1.5k away. Now take the one that is furthest from blufor
//find nearest blufor town
//diag_log format ["*** mrr @ 16 _pcst2 count %1", count _pcst2];
{
	_nearestblufors = nearestobjects [_x, ["Flag_Blue_F"], 5000];
	diag_log format ["*** mrr @ 19 nearestblufors count %1", count _nearestblufors];
	if (_nearestblufors isEqualTo []) exitWith {_bestconvoystartpoint = _x};
	_data1 = _nearestblufors select 0;
	if ((_data1 distance _x) > _furthestdistsofar) then
		{_furthestdistsofar = (_data1 distance _x);
		_bestconvoystartpoint = _x;
		};
} foreach _pcst2;
//get a road section at the convoy start, put a vehicle there and give it a wp
_bcsproad = [getpos _bestconvoystartpoint, 1000, []] call bis_fnc_nearestRoad;
//diag_log format ["best convoy start = %1 at %2. road chosen at %3", _bestconvoystartpoint, getpos _bestconvoystartpoint, getpos _bcsproad];
_mkr = createMarker ["mkr", (getpos _bestconvoystartpoint) ];
_mkr setMarkerShape "ICON";
_mkr setMarkerType "hd_dot";
sleep 15;
_cveh  = createVehicle [ opfor_reinf_truck, (getpos _bcsproad), [],0, "FORM" ];
_cveh addEventHandler ["HandleDamage", {if (isNull (_this select 3)) then { 0; } else { _this select 2; }; }]; // tankys magic no damage when shit driver crashes
_cveh setDir ([_cveh, _cpt] call bis_fnc_dirTo);
_rrgroup = createGroup east;
for "_z" from 1 to ((_cveh emptyPositions "cargo") -4) do
	{_unit = _rrgroup createunit [opfor_reinf_truck_soldier, (getpos _cveh) , [],0, "CARGO"];
	_unit moveInCargo _cveh;
	_unit assignAsCargo _cveh;

	};
for "_z" from 0 to 1 do
	{_unit = _rrgroup createunit [opfor_reinf_truck_soldier, (getpos _cveh) , [],0, "NONE"];
	_unit moveInTurret [_cveh, [_z]];
	_unit assignAsTurret [_cveh, [_z]];
	};
createVehicleCrew _cveh;
(driver _cveh) setrank "COLONEL";
[driver _cveh] joinSilent _rrgroup;
roadreinforcementvehicles pushback _cveh;
sleep 20;
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
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];