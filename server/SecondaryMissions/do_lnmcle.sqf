//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_lnmcle";
__tky_starts;
//land mine clearance mission
private ["_myplaces","_meadows","_smcleanup","_meadowdata","_mfpos","_numberofmines","_minecounter","_chosenmine","_realminepos","_mine","_minecone","_minename","_m1","_dirtohint"];
//get a good place for minefield

_myplaces = selectbestplaces [cpt_position, cpt_radius + 200, "meadow", 50,50];
_meadows = _myplaces select {(_x select 1) == 1};
minearray = []; missionactive = true; missionsuccess = false; _smcleanup = [];
_meadowdata = selectRandom _meadows;
_mfpos = _meadowdata select 0;
//^^ choose one to start with, then below, if it isnt good, keep choosing until it is.
while
	{(	((_mfpos distanceSqr fobveh) < 10) or ((_mfpos distanceSqr forward) < 10) or (_mfpos inArea format ["cpt_marker_%1", primarytargetcounter] ) or (_mfpos distance (nearestBuilding _mfpos) < 25 )	)	}
		do //choose a position that isn't near the fobveh or the forward vehicle or inside the town marker
		{
		_meadowdata = selectRandom _meadows;
		_mfpos = _meadowdata select 0;
		};

_numberofmines = ((selectrandom [2,3,4,5]) + (2 * playersnumber west)) min 12;
diag_log format ["***do_lnmcle going to make  %1 mines at %2", _numberofmines, _mfpos];
for "_minecounter" from 1 to _numberofmines do
	{
	_chosenmine = selectRandom aplandmines;
	_realminepos = [_mfpos, (26 + random 124 ), (random 360)] call BIS_fnc_relPos;
	_minecone = createVehicle ["RoadCone_L_F", _realminepos, [],0, "NONE"];
	_minecone addEventHandler ["explosion", "missionactive = false; missionsuccess = false; failtext = 'One of the mines has gone off. You failed the task.'"];
	_minecone hideObjectGlobal true;
	diag_log format ["*** cone made at %1", getpos _minecone];
	_mine = createMine [_chosenmine, _realminepos, [], 0];
	_minecone setpos (getpos _mine);
	//_defuseHelper = "ACE_DefuseObject" createVehicle (getPos _mine);
    //_defuseHelper attachTo [_mine, [0,0,0]];
    //_defuseHelper setVariable ["ACE_explosives_Explosive",_mine, true];
	minearray pushback _mine;
	diag_log format ["***made %3 at %2, number %1, planned position was %4, minecone is at %5", _minecounter, (getpos _mine), _chosenmine, _realminepos, getpos _minecone ];
  	_minemarkername = format ["mine%1", _minecounter];
  	if (testmode) then
  		{
  		_helper = createVehicle ["Sign_Arrow_F", getpos _mine, [],0, "CAN_COLLIDE"];
  		_smcleanup pushback _helper;
  		};
  	_m1 = createmarker [_minemarkername ,getpos _mine];
  	_m1 setMarkerShape "ICON";
  	_m1 setMarkerType "hd_dot";

  	//_smcleanup pushback _defuseHelper;
	_smcleanup pushback _mine;
	_smcleanup pushback improve_minecone;
	};
diag_log format ["*** do_m cleanup array is %1", _smcleanup];
sleep 4;/*
(format ["Local elders have told us there's a minefield %1of %2, about %3m from the edge of town. We need to defuse them.",
 	(cardinaldirs (select ([(cpt_position getdir _mfpos), 45] call BIS_fnc_rounddir) /45)),
 	 cpt_name,
 	 ([ ( ( (_mfpos distance2D cpt_position) - cpt_radius) + 24), 50]  call BIS_fnc_roundNum) ]

)remoteexec ["hint", -2];*/
//[(24+ 76), 50] call BIS_fnc_roundNum <- rounds to nearest 50m

_mfreldir = cpt_position getdir _mfpos;
_mfdist = cpt_position distance2D _mfpos;
format ["Local elders have told us there's a minefield %1 bearing %2 from the edge of town. We need to defuse all of them.", _mfdist, _mfreldir] remoteExecCall ["tky_fnc_t_usefirstemptyhintinqueue", 2, false];
//
while {missionactive} do
	{
	sleep 3;
	if (({mineactive _x} count minearray) isEqualTo 0) then
		{
		missionactive = false;
		missionsuccess = true;
		"All the mines have been cleared. Well done." remoteexec ["hint", -2];
		};

	};
{deletevehicle _x} foreach _smcleanup;
for "_zz" from 0 to _numberofmines do
	{
	deleteMarker format ["mine%1", _zz];
	};

__tky_ends