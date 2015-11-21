#define filename "getprimarytargetlocations.sqf"
_thisscript = "getprimarytargetlocations.sqf";
//by tankbuster
//execvd'd by initserver
diag_log format ["*** %1 starts %2,%3", _thisscript, diag_tickTime, time];
private ["_mapsize","_mapcentre","_possibleprimaries","_pos","_primaries", "_rrad", "_betterhousecount", "_betterpos", "_deltahousecount", "_newpos", "_bestpos", "_besthousecount", "_shifts", "_shift", "_shiftedhousecount", "_data2", "_myindex", "_data1", "_mname1", "_data2", "_mname2", "_y", "_z", "_exitit", "_mydistance", "_logicgroup"];
_mapsize  = worldSize;
_mapcentre = [_mapsize / 2, _mapsize / 2 ,0];
_possibleprimaries = nearestLocations [_mapcentre, ["NameCityCapital", "NameCity", "NameVillage"], _mapsize /2];
diag_log format ["Worldname %2 is %3. Possibleprimaries count = %1", count _possibleprimaries, worldName, _mapsize];
_possibleprimariescount = count _possibleprimaries;
_betterhousecount = []; _betterpos = [];
// ======functions
fnc_getcitylimits =
// finds citylimits for the position given
// if 2nd param is true, script will concentrate more on actual houses
// returns the radius of the city limits and the house count within that
	{
	private ["_locpos","_countonlyhouses","_oldringshousecount","_rads","_houses","_dummyhouses","_ringhousecount","_allhousecount", "_finalhousecount", "_myradius", "_rings", "_foundhouses", "_myhouse", "_excludedbuildings", "_exitit", "_previousringhousecount", "_excludedcount",  "_previousringhousecount", "_excludedcount", "_possiblebases", "_skiparray"];
	params ["_locpos", "_countonlyhouses"];
	_locpos set [2,0];
	_ringhousecount = 0;_oldringshousecount = 0;_previousringhousecount = 0;_rads = 300;_finalhousecount = 0; _excludedcount = 0;
	_excludedbuildings = ["Land_TTowerSmall_1_F", "Land_Dome_Big_F", "Cargo_Patrol_base_F", "Cargo_House_base_F", "Cargo_Tower_base_F", "Cargo_HQ_base_F","Piers_base_F", "PowerLines_base_F", "PowerLines_Wires_base_F", "PowerLines_Small_base_F", "Land_PowerPoleWooden_L_F",  /*"Lamps_base_F",*/ "Land_Research_HQ_F", "Land_Research_house_V1_F", "Land_MilOffices_V1_F", "Land_TBox_F", "Land_Chapel_V1_F","Land_Chapel_Small_V2_F",  "Land_Chapel_Small_V1_F", "Land_BellTower_01_V1_F", "Land_BellTower_02_V1_F", "Land_fs_roof_F","Land_fs_feed_F", "Land_Windmill01_ruins_F", "Land_d_Windmill01_F", "Land_i_Windmill01_F","Land_i_Barracks_V2_F", "Land_spp_Transformer_F", "Land_dp_smallFactory_F", "Land_Shed_Big_F", "Land_Metal_Shed_F","Land_i_Shed_Ind_F","Land_Communication_anchor_F", "Land_TTowerSmall_2_F", "Land_Communication_F","Land_cmp_Shed_F", "Land_cmp_Tower_F", "Land_u_Shed_Ind_F", "Land_TBox_F"];
	for "_myradius" from 75 to 450 step 75 do
		{
		_houses = []; _excludedcount = 0;
		_dummyhouses = (_locpos nearObjects ["House_F", _myradius]);
			{
			if (_countonlyhouses) then
				{
				_myhouse = _x;_exitit = false;
					{

					if (_myhouse isKindOf _x) exitWith {_exitit = true};
					} foreach _excludedbuildings;
				if (_exitit) then {/*diag_log format ["%1 excluded because is %2", typeof _myhouse, _x];*/ _excludedcount = _excludedcount +1;} else {_houses pushBack _myhouse;};

				} else {_houses = _dummyhouses};
			} foreach _dummyhouses;

		_allhousecount = (count _houses);
		_ringhousecount = _allhousecount - _oldringshousecount;
		//diag_log format ["houses count = %1 at ring %2 meters", _ringhousecount, _myradius];
		if ((_ringhousecount < _previousringhousecount) and (_myradius > 99)) exitWith {_rads = _myradius; _finalhousecount = _ringhousecount; };
		_oldringshousecount = _oldringshousecount +  _ringhousecount;
		_previousringhousecount = _ringhousecount;
		};
	[_rads, _finalhousecount]
	};

// ===== end functions
{
//diag_log "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
//diag_log format ["location = %1", text _x];
_pos = locationPosition _x;
_data1 = [_pos, true] call fnc_getcitylimits;
_deltahousecount = _data1 select 1;
_rrad = (_data1 select 0);
/*
_mname1 = format ["mn%1", _foreachindex];
_mkr = createMarker [_mname1, _pos];
_mkr setMarkerShape "ELLIPSE";
_mkr setMarkerType "Empty";
_mkr setMarkerSize [_rrad,_rrad];
_mkr setMarkerText (str _rrad);
_mkr setMarkerBrush "Horizontal";
diag_log format ["marker %1 drawn for %2 at %3 with houses %4", _rrad, text _x, _pos, _deltahousecount]; */
// so we have a good marker set for the town..
// lets see if moving it a little might help?
_newpos = [];_bestpos = _pos;_besthousecount = _deltahousecount;
_shifts = [/*[0,50],*/[-50,50],[-50,0],[-50,-50],[0,-50],[50,-50],[50,0], [50,50]];
	{
	_newpos = [((_pos select 0) + (_x select 0)), ((_pos select 1) + (_x select 1)), 0];
	_data2 = [_newpos, true] call fnc_getcitylimits;
	_shiftedhousecount = _data2 select 1;
	//diag_log format [" shift %1 gives pos %2 and houses %3", _x, _newpos, _shiftedhousecount];
	if (_shiftedhousecount > _besthousecount) then
		{
		_besthousecount = _shiftedhousecount;
		_bestpos = _newpos;
		};
	}foreach _shifts;
//diag_log format ["%3 _bestpos %1, hcount %2", _bestpos, _besthousecount, text _x];
/*
_mname2 = format ["smn%1", _foreachindex];
_mkr2 = createMarker [_mname2, _bestpos];
_mkr2 setMarkerShape "ELLIPSE";
_mkr2 setMarkerType "Empty";
_mkr2 setMarkerSize [_rrad,_rrad];
_mkr2 setMarkerText (str _rrad);
_mkr2 setMarkerBrush "Vertical";
*/
// create a game logic at each town position and store variables on it.
_logicgroup = createGroup logiccenter;
_logic = _logicgroup createUnit ["Logic", _bestpos, [], 0, "NONE"];
_logic setVariable ["targetname", (text _x)];
_logic setVariable ["targetradius", _rrad];
_logic setvariable ["targetstatus", -1];
_logic setVariable ["targettype", 1];
missionsetupprogress = (_foreachindex / _possibleprimariescount);
publicVariable "missionsetupprogress";
} foreach _possibleprimaries;
// find all the military bases by finding all the big towers. As some of the bases have more than tower in them,
// remove those that have other towers nearby
_possiblebases = []; _skiparray = [];
_dummybases = _mapcentre nearObjects ["Cargo_Tower_base_F", _mapsize /2];
_basecount = count _dummybases;
for "_z" from 0 to (_basecount -1) do
	{
	_mytower = _dummybases select _z;
	if !(_mytower in _skiparray) then
		{
		_possiblebases pushback _mytower;
		_neighbours = _mytower nearObjects ["Cargo_Tower_base_F", 250];
		if ((count _neighbours) > 0) then
			{
			{_skiparray pushback _x} forEach _neighbours;
			};
		};
	};
{
_logic = _logicgroup createUnit ["Logic", getpos _x, [], 0, "NONE"];
_logic setVariable ["targetname", ("Military base")];
_logic setVariable ["targetradius", 250];
_logic setvariable ["targetstatus", -1];
_logic setVariable ["targettype", 3];
} foreach _possiblebases;
diag_log format ["possible bases count %1", count _possiblebases];
diag_log format ["*** %1 ends %2,%3", _thisscript, diag_tickTime, time];