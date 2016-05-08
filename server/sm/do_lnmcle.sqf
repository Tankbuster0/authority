//by tankbuster
_myscript = "do_lnmcle";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
//land mine clearance mission

//get a good place for minefield
private ["_myplaces","_mydata","_mname","_m1","_exp"];
_myplaces = selectbestplaces [cpt_position, 1000, "meadow", 50,50];
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
_mfpos = []; minearray = []; missionactive = true; missionsuccess = false; _smcleanup = [];
while {((_mfpos == []) or ((_mfpos distance fobveh) < 100) or ((_mfpos distance forward) < 100)) } do //choose a position that isn't near the fobveh or the forward vehicle
	{
	_mfpos =  (selectRandom  (_myplaces select {(_x select 1) == 1})) select 0;//select only those that are meadow 1, from them get a random one, and from that, get the position part of the array
	};

for "_minecounter" from 5 to ((2 * playersNumber west) min 12) do
	{
	_mine = createMine [(selectRandom alllandmines), _mfpos, [], 50];
	minearray pushback _mine;
	_minecone = createVehicle ["RoadCone_L_F", getpos _mine, [],0, "CAN_COLLIDE"];
	_minecone addEventHandler ["explosion", "missionactive = false; missionsuccess = false"];
	hideObjectGlobal _minecone;
  	_m1 = createmarker [(format ["mine%1", foreachindex]) ,getpos _mine];
  	_m1 setMarkerShape "ICON";
  	_m1 setMarkerType "hd_dot";
	_smcleanup pushback _mine;
	_smcleanup pushback  _minecone;
	};

taskname = "task" + str primarytargetcounter + "sm" + str smcounter;
[west, [taskname], ["Clear the target of all enemy forces", "Clear target of enemy forces","cpt_marker"], cpt_position,1,2,true ] call bis_fnc_taskCreate;

sleep 2;

_dirtohint = cardinaldirs select (([([( cpt_position) getdir _mfpos, 45] call BIS_fnc_roundDir), 45] call BIS_fnc_rounddir) /45)
format ["Local elders have told us there's a minefield %1 the town. We need to clear them without taking casualties."] remoteexec ["hint", -2];

while {missionactive} do
	{
	sleep 3;
	if (({mineactive _x} count minearray) isEqualTo 0) then
		{
		missionactive = false;
		missionsuccess = true;
		};

	};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];