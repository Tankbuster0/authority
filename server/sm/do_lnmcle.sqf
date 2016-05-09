//by tankbuster
_myscript = "do_lnmcle";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
//land mine clearance mission

//get a good place for minefield
private ["_myplaces","_meadows","_smcleanup","_meadowdata","_mfpos","_numberofmines","_minecounter","_chosenmine","_realminepos","_mine","_minecone","_minename","_m1","_dirtohint"];
_myplaces = selectbestplaces [cpt_position, 1000, "meadow", 50,25];
_meadows = _myplaces select {(_x select 1) == 1};
minearray = []; missionactive = true; missionsuccess = false; _smcleanup = [];
_meadowdata = selectRandom _meadows;
_mfpos = _meadowdata select 0;
//^^ choose one to start with, then below, if it isnt good, keep choosing until it is.
while
	{(	((_mfpos distance fobveh) < 100) or ((_mfpos distance forward) < 100) or (_mfpos inArea "cpt_marker")	)	}
		do //choose a position that isn't near the fobveh or the forward vehicle or inside the town marker
		{
		_meadowdata = selectRandom _meadows;
		_mfpos = _meadowdata select 0;
		};

_numberofmines = ((selectrandom [2,3,4,5]) + (2 * playersnumber west)) min 12;
diag_log format ["***do_lnmcle going to make  %1 mines at %2", _numberofmines, _mfpos];
for "_minecounter" from 0 to _numberofmines do
	{
	_chosenmine = selectRandom aplandmines;
	_realminepos = [_mfpos, (random 15), (random 360)] call BIS_fnc_relPos;

	_minecone = createVehicle ["RoadCone_L_F", _realminepos, [],0, "NONE"];
	_minecone addEventHandler ["explosion", "missionactive = false; missionsuccess = false"];
	diag_log format ["*** cone made at %1", getpos _minecone];
	//hideObjectGlobal _minecone;

	_mine = createMine [_chosenmine, _realminepos, [], 0];
	minearray pushback _mine;
	diag_log format ["***made %3 at %2, number %1, planned position was %4", _minecounter, (getpos _mine), _chosenmine, _realminepos];

  	_minename = format ["mine%1", _minecounter];
  	_m1 = createmarker [_minename ,getpos _mine];
  	_m1 setMarkerShape "ICON";
  	_m1 setMarkerType "hd_dot";

	_smcleanup pushback _mine;
	_smcleanup pushback  _minecone;
	};
diag_log format ["*** do_m cleanup array is %1", _smcleanup];
//taskname = "task" + str primarytargetcounter + "sm" + str smcounter;
//[west, [taskname], ["Clear the landmines", "Clear the landmines","mine1"], _mfpos,1,2,true ] call bis_fnc_taskCreate;

sleep 4;

_dirtohint = cardinaldirs select (([([( cpt_position) getdir _mfpos, 45] call BIS_fnc_roundDir), 45] call BIS_fnc_rounddir) /45);
(format ["Local elders have told us there's a minefield %1 the town. We need to clear them without taking casualties.", _dirtohint]) remoteexec ["hint", -2];
waitUntil {sleep 3;false};
while {true} do
	{
	sleep 3;
	if (({mineactive _x} count minearray) isEqualTo 0) then
		{
		missionactive = false;
		missionsuccess = true;
		"All the mines have been cleared. Well done." remoteexec ["hint", -2];
		};

	};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];