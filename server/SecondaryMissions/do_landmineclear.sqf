//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_landmineclear";
__tky_starts;
private ["_myplaces","_meadows","_smcleanup","_meadowdata","_mfpos","_numberofmines","_minecounter","_chosenmine","_realminepos","_mine","_minecone","_minename","_m1","_dirtohint"];
//get a good place for minefield
_myplaces = selectbestplaces [cpt_position, cpt_radius + 400, "meadow", 50,50];
_meadows = _myplaces select {((_x select 1) == 1)};
minearray = []; missionactive = true; missionsuccess = false; _smcleanup = [];
publicVariable "missionactive"; publicVariable "missionsuccess";
_meadowdata = selectRandom _meadows;
_mfpos = _meadowdata select 0;
//^^ choose one to start with, then below, if it isnt good, keep choosing until it is.
while
	{(	((_mfpos distance2D getMarkerPos "fobmarker") < 100) or ((_mfpos distance2D forward) < 100) or (_mfpos inArea format ["cpt_marker_%1", primarytargetcounter] ) or (_mfpos distance2D (nearestBuilding _mfpos) < 40 )	)	}
		do //choose a position that isn't near the fobveh or the forward vehicle or inside the town marker
		{
		_meadowdata = selectRandom _meadows;
		_mfpos = _meadowdata select 0;
		};
_numberofmines = ((selectrandom [1,2,3]) + (2 * playersnumber west)) min 10;
diag_log format ["***do_lnmcle going to make  %1 mines at %2", _numberofmines, _mfpos];
for "_minecounter" from 1 to _numberofmines do
	{
	_chosenmine = selectRandom aplandmines;
	_realminepos = [_mfpos, (26 + random 74 ), (random 360)] call BIS_fnc_relPos;
	_minecone = createVehicle ["RoadCone_L_F", _realminepos, [],0, "NONE"];
	_minecone addEventHandler ["explosion", "missionsuccess = false; missionactive = false; publicVariable 'missionactive'; publicVariable 'missionsuccess'; failtext = 'One of the mines has gone off. You failed the task.'; publicVariable 'failtext'; "];
	_minecone hideObjectGlobal true;
	//diag_log format ["*** cone made at %1", getpos _minecone];
	_mine = createMine [_chosenmine, _realminepos, [], 0];
	_minecone setpos (getpos _mine);
	minearray pushback _mine;
	//diag_log format ["***made %3 at %2, number %1, planned position was %4, minecone is at %5", _minecounter, (getpos _mine), _chosenmine, _realminepos, getpos _minecone ];
  	_minemarkername = format ["mine%1", _minecounter];
  	if (testmode) then
  		{
  		_helper = createVehicle ["Sign_Arrow_F", getpos _mine, [],0, "CAN_COLLIDE"];
  		_smcleanup pushback _helper;

	  	_m1 = createmarker [_minemarkername ,getpos _mine];
	  	_m1 setMarkerShape "ICON";
	  	_m1 setMarkerType "hd_dot";
	  };
	_smcleanup pushback _mine;
	_smcleanup pushback _minecone;
	};
//diag_log format ["*** do_m cleanup array is %1", _smcleanup];
sleep 4;
_mfreldir = [cpt_position getdir _mfpos] call TKY_fnc_cardinaldirection;
_mfdist = [((cpt_position distance2D _mfpos) + 24 - cpt_radius), 50] call BIS_fnc_roundNum;
smmissionstring = format ["Local elders have told us there's a minefield %1m %2of the edge of town. We need to defuse all of them. Only an engineer or explosives specialist can do this. Take a mine detector and a toolkit.", _mfdist, _mfreldir];
publicVariable "smmissionstring";
smmissionstring remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
//
while {missionactive} do
	{
	sleep 3;
	if (({mineactive _x} count minearray) isEqualTo 0) then
		{
		missionsuccess = true; publicVariable "missionsuccess";
		missionactive = false; publicVariable "missionactive";
		"All the mines have been cleared. Well done." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
for "_zz" from 0 to _numberofmines do
	{
	deleteMarker format ["mine%1", _zz];
	};
{
	_x removeAllEventHandlers "explosion";
	diag_log format ["*** removing eh from minecone %1 at %2", _x, getpos _x];
} foreach (_mfpos nearEntities ["RoadCone_L_F", 110]);
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";
__tky_ends