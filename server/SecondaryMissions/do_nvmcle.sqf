//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_nvmcle";
__tky_starts;
//sea mine clearance mission

//Find a nice deep place for mf

_myplaces = selectbestplaces [cpt_position, 1000, "waterdepth", 50,100];
_seapos1 = _myplaces select {(_x select 1) > 10 and (_x select 1 < 80)};
_mfdata = selectRandom _seapos1;
_mfpos = _mfdata select 0;

_numberofmines = ceil (random ( 2 * (playersNumber west) ));
diag_log format ["***do_nvmcle going to make  %1 mines at %2", _numberofmines, _mfpos];
// trick with sea mines is to create them at the position where you want them as none of the setpos commands work on them

//for bottom mines, give it an atl zero  position, job done
// for surface mines, give it an asl zero position
// for mooted mines, nned to choose a random depth between the two
for "_minecounter" from 1 to _numberofmines do
	{
	_chosenmine = selectRandom seamines;
	_deepenough = false;
	while {not _deepenough} do
		{
		_realminepos = [_mfpos, (5 + random 20 ), (random 360)] call BIS_fnc_relPos;
		_seabedatlz =

	switch (_chosenmine) do
		{
		case "UnderwaterMine":
		};

	_minecone = createVehicle ["RoadCone_L_F", _realminepos, [],0, "NONE"];
	_minecone addEventHandler ["explosion", "missionactive = false; missionsuccess = false; failtext = 'One of the mines has gone off. You failed the task.'"];
	_minecone hideObjectGlobal true;
	diag_log format ["*** cone made at %1", getpos _minecone];
	_mine = createMine [_chosenmine, _realminepos, [], 0];
	_minecone setpos (getpos _mine);
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
	_smcleanup pushback _mine;
	_smcleanup pushback _minecone;
	};

__tky_ends


