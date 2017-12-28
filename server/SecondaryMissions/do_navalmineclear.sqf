//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_navalmineclear";
__tky_starts;
private ["_myplaces","_seapos1","_mfdata","_mfpos","_numberofmines","_minecounter","_chosenmine","_deepenough","_realminepos","_seadepth","_minespawnpos","_minecone","_mine","_minemarkername","_helper","_smcleanup","_m1"];
//Find a nice deep place for mf
minearray = []; missionactive = true; missionsuccess = false; _smcleanup = [];
publicVariable "missionactive"; publicVariable "missionsuccess";
_myplaces = selectbestplaces [cpt_position, 1000, "waterdepth", 100,50];
_myplaces append (selectbestplaces [cpt_position, 1500, "waterdepth", 100,50]);
_myplaces append (selectbestplaces [cpt_position, 2000, "waterdepth", 100,50]);
_seapos1 = _myplaces select {(_x select 1) > 10 and (_x select 1 < 40)};
_mfdata = selectRandom _seapos1;
_mfpos = _mfdata select 0;
_numberofmines = (ceil (random ( 2 * (playersNumber west) )) min 6);
diag_log format ["***do_nvmcle going to make  %1 mines at %2", _numberofmines, _mfpos];
// trick with sea mines is to create them at the position where you want them as none of the setpos commands work on them
//for bottom mines, give it an atl zero  position,  for surface mines, give it an asl zero position for moored mines, need to choose a random depth between the two
for "_minecounter" from 1 to _numberofmines do
	{
	_chosenmine = selectRandom seamines;
	_deepenough = false;
	while {not _deepenough} do
		{
		_realminepos = _mfpos getpos [(3 + random 20), (random 360)];
		_seadepth = (getTerrainHeightASL _realminepos);// <--returns a negative number
		if (_seadepth < -15) then {_deepenough = true};
		};
	switch (_chosenmine) do
		{
		case "UnderwaterMine": {_minespawnpos = ATLToASL [_realminepos select 0, _realminepos select 1, abs (random _seadepth) ]};//moored
		case "UnderwaterMineAB": {_minespawnpos = ATLToASL [_realminepos select 0, _realminepos select 1, 0]};//bottom
		case "UnderwaterMinePDM": {_minespawnpos = _realminepos};//surface
		};
	_mine = createMine [_chosenmine, _minespawnpos, [], 0];
	minearray pushback _mine;
	diag_log format ["***%1 made %3 at %2, planned position was %4 ", _minecounter, (getpos _mine), _chosenmine, _minespawnpos ];
  	_minemarkername = format ["mine%1", _minecounter];
  	if (testmode) then
  		{
  		_helper = createVehicle ["Sign_Arrow_F", getposATL _mine, [],0, "CAN_COLLIDE"];
  		if (_chosenmine isEqualTo "UnderwaterMine") then {_helper setPosATL [getPosATL _mine select 0, getPosATL _mine select 1, (46 + (getPosATL _mine select 2))]};
  		_smcleanup pushback _helper;

	  	_m1 = createmarker [_minemarkername ,getpos _mine];
	  	_m1 setMarkerShape "ICON";
	  	_m1 setMarkerType "hd_dot";
	  	_m1 setMarkerText format ["%1", _minecounter];
  		};
	_smcleanup pushback _mine;
	};
diag_log format ["*** do_m cleanup array is %1", _smcleanup];
sleep 4;
_mfreldir = [cpt_position getdir _mfpos] call TKY_fnc_cardinaldirection;
_mfdist = [((cpt_position distance2D _mfpos) + 24 - cpt_radius), 50] call BIS_fnc_roundNum;
smmissionstring = format ["Local fishermen have told us there are mines in the water %1m %2 of the edge of town. We need to defuse all of them. Only an engineer or explosives specialist can do this and you'll need a mine detector and toolkit. When you find the mine, you will need to 'reveal' it - default key is 't' ", _mfdist, _mfreldir];
smmissionstring remoteExecCall  ["tky_fnc_usefirstemptyinhintqueue", 2, false];
publicVariable "smmissionstring";
while {missionactive} do
	{
	sleep 3;
	minearray = minearray - [objNull];//remove any exploded mines
	if ((({mineactive _x} count minearray) isEqualTo 0) and (count minearray isEqualTo _numberofmines) ) then
		{
		missionsuccess = true;
		missionactive = false;

		"All the mines have been cleared. Well done." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	if (count minearray < _numberofmines) then
		{
		missionsuccess = false;
		missionactive = false;

		failtext = "A mine has gone off. You've failed this secondary mission.";
		};
	};
publicVariable "missionsuccess"; publicVariable "missionactive";
{deletevehicle _x} foreach _smcleanup;
for "_zz" from 0 to _numberofmines do
	{
	deleteMarker format ["mine%1", _zz];
	};
__tky_ends