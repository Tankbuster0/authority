//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_nvmcle";
__tky_starts;
private ["_myplaces","_seapos1","_mfdata","_mfpos","__tky_debug","_numberofmines","_minecounter","_chosenmine","_deepenough","_realminepos","_seadepth","_minespawnpos","_minecone","_mine","_minemarkername","_helper","_smcleanup","_m1"];
//sea mine clearance mission

//Find a nice deep place for mf
minearray = []; missionactive = true; missionsuccess = false; _smcleanup = [];
_myplaces = selectbestplaces [cpt_position, 1000, "waterdepth", 50,100];
_seapos1 = _myplaces select {(_x select 1) > 10 and (_x select 1 < 80)};
_mfdata = selectRandom _seapos1;
_mfpos = _mfdata select 0;
__tky_debug
_numberofmines = ceil (random ( 6 * (playersNumber west) ));
_numberofmines = 1;//debug only
diag_log format ["***do_nvmcle going to make  %1 mines at %2", _numberofmines, _mfpos];
// trick with sea mines is to create them at the position where you want them as none of the setpos commands work on them

//for bottom mines, give it an atl zero  position, job done
// for surface mines, give it an asl zero position
// for mooted mines, nned to choose a random depth between the two
for "_minecounter" from 1 to _numberofmines do
	{
	_chosenmine = selectRandom seamines;
	_chosenmine =  "UnderwaterMinePDM";//debug only
	_deepenough = false;
	while {not _deepenough} do
		{
		_realminepos = [_mfpos, (5 + random 40 ), (random 360)] call BIS_fnc_relPos;
		_seadepth = (getTerrainHeightASL _realminepos);// <--returns a negative number
		if (_seadepth < -10) then {_deepenough = true};
		};
	switch (_chosenmine) do
		{
		case "UnderwaterMine": {_minespawnpos = ATLToASL [_realminepos select 0, _realminepos select 1, abs (random _seadepth) ]};//moored
		case "UnderwaterMineAB": {_minespawnpos = ATLToASL [_realminepos select 0, _realminepos select 1, -0.25]};//bottom
		case "UnderwaterMinePDM": {_minespawnpos = _realminepos};//surface
		};

	_minecone = createVehicle ["RoadCone_L_F", _minespawnpos, [],0, "NONE"];
	_minecone addEventHandler ["explosion", "missionactive = false; missionsuccess = false; failtext = 'One of the mines has gone off. You failed the task.'"];
	//_minecone hideObjectGlobal true;
	diag_log format ["*** cone made at %1", getpos _minecone];
	_mine = createMine [_chosenmine, _minespawnpos, [], 0];
	if (_chosenmine isEqualTo "UnderwaterMineAB") then {_mine setVectorUp surfaceNormal position _mine;};
	_minecone setpos (getpos _mine);
	minearray pushback _mine;
	_minecone attachTo [_mine];
	diag_log format ["***made %3 at %2, number %1, planned position was %4, minecone is at %5", _minecounter, (getpos _mine), _chosenmine, _minespawnpos, getpos _minecone ];
  	_minemarkername = format ["mine%1", _minecounter];
  	if (testmode) then
  		{
  		_helper = createVehicle ["Sign_Arrow_F", getposATL _mine, [],0, "CAN_COLLIDE"];
  		_smcleanup pushback _helper;
  		};
  	_m1 = createmarker [_minemarkername ,getpos _mine];
  	_m1 setMarkerShape "ICON";
  	_m1 setMarkerType "hd_dot";
	_smcleanup pushback _mine;
	_smcleanup pushback _minecone;
	};


diag_log format ["*** do_m cleanup array is %1", _smcleanup];
sleep 4;
_mfreldir = cardinaldirs select (([cpt_position getdir _mfpos, 45] call BIS_fnc_roundDir) /45);
_mfdist = [((cpt_position distance2D _mfpos) + 24 - cpt_radius), 50] call BIS_fnc_roundNum;
format ["Local fishermen have told us there are mines %1m %2 the edge of town. We need to defuse all of them. Only and engineer or explosives specialist can do this. Take a mine detector and a toolkit.", _mfdist, _mfreldir] remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
//
while {missionactive} do
	{
	sleep 3;
	if (({mineactive _x} count minearray) isEqualTo 0) then
		{
		missionactive = false;
		missionsuccess = true;
		"All the mines have been cleared. Well done." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};

	};
{deletevehicle _x} foreach _smcleanup;
for "_zz" from 0 to _numberofmines do
	{
	deleteMarker format ["mine%1", _zz];
	};

__tky_ends


