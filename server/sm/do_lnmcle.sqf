//by tankbuster
_myscript = "do_lnmcle.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
//land mine clearance mission

//get a good place for minefield

private ["_myplaces","_mydata","_mname","_m1","_exp"];
_myplaces = selectbestplaces [cpt_position, 1000, "meadow", 50,10];
 /*
 {
  _mydata = _x;
  _mname = (format ["%1",_forEachIndex ]);
  _m1 = createmarker [_mname,(_mydata select 0)];
  _m1 setMarkerShape "ICON";
  _m1 setMarkerType "hd_dot";
  _exp = [(_mydata select 1),1] call BIS_fnc_cutDecimals;
  if (_exp ==1) then {_mname setMarkerColor "ColorGreen"};
  _m1 setMarkerText str _exp;
 }foreach _myplaces;
 */

_mfpos =  (selectRandom  (_myplaces select {(_x select 1) == 1})) select 0;//select only those that are meadow 1, from them get a random one, and from that, get the position part of the array

for "_minecounter" from 5 to ((2 * playersNumber west) min 12) do
	{
	_mine = createMine [(selectRandom alllandmines), _mfpos, [], 50];
  	_m1 = createmarker [(format ["mine%1", foreachindex]) ,getpos _mine];
  	_m1 setMarkerShape "ICON";
  	_m1 setMarkerType "hd_dot";
	};

taskname = "task" + str primarytargetcounter + "sm" + str smcounter
[west, [taskname], ["Clear the target of all enemy forces", "Clear target of enemy forces","cpt_marker"], cpt_position,1,2,true ] call bis_fnc_taskCreate;

sleep 2;

_dirtohint = cardinaldirs select (([([( cpt_position) getdir _mfpos, 45] call BIS_fnc_roundDir), 45] call BIS_fnc_rounddir) /45)
format ["Local elders have told us there's a minefield %1 the town. We need to clear them without taking casualties."] remoteexec ["hint", -2];

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];