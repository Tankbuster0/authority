// by tankbuster
_myscript = "makeconvoy.sqf";
diag_log format ["*** %1 starts %2, %3", _myscript, diag_tickTime, time];
_cpt = _this select 0; // actually a logic
// choose a town a couple of K away, away from other blufor towns
_furthestdistsofar = 0; _furthestlocsofar = objNull; _pcst2 = [];
_possibleconvoystartpoints = _cpt nearEntities ["Logic", 3000];
{
	if (((_x getVariable ["targetstatus", -1]) == 1) and ((_x distance _cpt) > 1500)) then {_pcst2 pushback _x};
} foreach _possibleconvoystartpoints;
{
	diag_log format ["***poss.conv.start.point is %1 at %2, dist %3", (_x getVariable "targetname" ), getpos _x, (_x distance _cpt)];
	_mn = format ["cs%1", _forEachIndex];
	_mkr = createMarker [_mn, _x];
	_mkr setMarkerShape "ICON";
	_mkr setMarkerType "hd_dot";

}foreach _pcst2;
// foound a bunch of enemyheld towns between 3k and 1.5k away. Now take the one that is furthest from blufor
//find nearest blufor
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];