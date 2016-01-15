// by tankbuster
_myscript = "makeconvoy.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
private ["_cpt","_furthestdistsofar","_furthestlocsofar","_pcst2","_possibleconvoystartpoints","_mn","_mkr","_nearestblufors","_bestconvoystartpoint","_data1"];
_cpt = _this select 0; // actually a logic
// choose a town a couple of K away, away from other blufor towns
_furthestdistsofar = 0; _furthestlocsofar = objNull; _pcst2 = [];
_possibleconvoystartpoints = _cpt nearEntities ["Logic", 3000];
{
	if (((_x getVariable ["targetstatus", -1]) == 1) and ((_x distance _cpt) > 1500)) then {_pcst2 pushback _x}; //if the town being checked is a real town, enemy held and more than 1500m away, add it to the pcst2 array
} foreach _possibleconvoystartpoints;
/*{
	diag_log format ["***poss.conv.start.point is %1 at %2, dist %3", (_x getVariable "targetname" ), getpos _x, (_x distance _cpt)];
	_mn = format ["cs%1", _forEachIndex];
	_mkr = createMarker [_mn, _x];
	_mkr setMarkerShape "ICON";
	_mkr setMarkerType "hd_dot";
}foreach _pcst2; */
// foound a bunch of enemyheld towns between 3k and 1.5k away. Now take the one that is furthest from blufor
//find nearest blufor town
{
	_nearestblufors = nearestobjects [_x, ["Flag_Blue_F"], 5000];
	if (_nearestblufors isEqualTo []) exitWith {_bestconvoystartpoint = _x};
	_data1 = _nearestblufors select 0;
	if ((_data1 distance _x) > _furthestdistsofar) then
		{_furthestdistsofar = (_data1 distance _x);
			_furthestlocsofar = _x;
		};
} foreach _pcst2;
//get a road section at the convoy start, put a vehicle there and give it a wp
_bcsproad = [getpos _bestconvoystartpoint, 1000, []] call bis_fnc_nearestRoad;
diag_log format ["best convoy start = %1 at %2. road chosen at %3", _bestconvoystartpoint, getpos _bestconvoystartpoint, getpos _bcsproad];
	_mkr = createMarker ["mkr", (getpos _bestconvoystartpoint) ];
	_mkr setMarkerShape "ICON";
	_mkr setMarkerType "hd_dot";
_cveh  = createVehicle [ "O_Truck_03_transport_F", (getpos _bcsproad), [],0, "NONE" ];
createVehicleCrew _cveh;
for "_z" from 1 to (_cveh emptyPositions "cargo") do {createunit};
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];