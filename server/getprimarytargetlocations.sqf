//by tankbuster
//execvd'd by initserver
// finds towns, improves their centre location and radius, also finds military bases and airfields and makes a logic at all of them.
 #include "..\includes.sqf"
_myscript = "getprimarytargetlocations";
__tky_starts;
targetdata =[]; _starttime = time;
private ["_mapsize","_mapcentre","_possibleprimaries","_pos","_primaries", "_rrad", "_betterhousecount", "_betterpos", "_deltahousecount", "_newpos", "_bestpos", "_besthousecount", "_shifts", "_shift", "_shiftedhousecount", "_data2", "_myindex", "_data1", "_mname1", "_data2", "_mname2", "_y", "_z", "_exitit", "_mydistance", "_logicgroup", "_airportlogicgroup"];
_mapsize  = worldSize;
_mapcentre = [_mapsize / 2, _mapsize / 2 ,0];
_possibleprimaries = nearestLocations [_mapcentre, ["NameCityCapital", "NameCity", "NameVillage"], _mapsize /2];
diag_log format ["***Worldname %2 is %3. Possibleprimaries count = %1", count _possibleprimaries, worldName, _mapsize];
_possibleprimariescount = count _possibleprimaries;
_betterhousecount = []; _betterpos = [];
// ======functions
fnc_getcitylimits =
// finds citylimits for the position given
// if 2nd param is true, script will concentrate more on actual houses
// returns the radius of the city limits and the house count within that
	{
	private ["_locpos","_countonlyhouses","_oldringshousecount","_rads","_houses","_dummyhouses","_ringhousecount","_allhousecount", "_finalhousecount", "_myradius", "_rings", "_foundhouses", "_myhouse", "_excludedbuildings", "_exitit", "_previousringhousecount",  "_previousringhousecount",  "_possiblebases", "_skiparray"];
	params ["_locpos", "_countonlyhouses"];
	_locpos set [2,0];
	_ringhousecount = 0;_oldringshousecount = 0;_previousringhousecount = 0;_rads = 300;_finalhousecount = 0;
	_excludedbuildings = ["Land_TTowerSmall_1_F", "Land_Dome_Big_F", "Cargo_Patrol_base_F", "Cargo_House_base_F", "Cargo_Tower_base_F", "Cargo_HQ_base_F","Piers_base_F", "PowerLines_base_F", "PowerLines_Wires_base_F", "PowerLines_Small_base_F", "Land_PowerPoleWooden_L_F",  "Land_Research_HQ_F", "Land_Research_house_V1_F", "Land_MilOffices_V1_F", "Land_TBox_F", "Land_Chapel_V1_F","Land_Chapel_Small_V2_F",  "Land_Chapel_Small_V1_F", "Land_BellTower_01_V1_F", "Land_BellTower_02_V1_F", "Land_fs_roof_F","Land_fs_feed_F", "Land_Windmill01_ruins_F", "Land_d_Windmill01_F", "Land_i_Windmill01_F","Land_i_Barracks_V2_F", "Land_spp_Transformer_F", "Land_dp_smallFactory_F", "Land_Shed_Big_F", "Land_Metal_Shed_F","Land_i_Shed_Ind_F","Land_Communication_anchor_F", "Land_TTowerSmall_2_F", "Land_Communication_F","Land_cmp_Shed_F", "Land_cmp_Tower_F", "Land_u_Shed_Ind_F", "Land_TBox_F"];
	for "_myradius" from 75 to 450 step 75 do
		{
		_houses = [];
		_dummyhouses = (_locpos nearObjects ["House_F", _myradius]);
			{
			if (_countonlyhouses) then
				{
				_myhouse = _x;_exitit = false;
					{

					if (_myhouse isKindOf _x) exitWith {_exitit = true};
					} foreach _excludedbuildings;
				if !(_exitit) then {_houses pushBack _myhouse;};

				} else {_houses = _dummyhouses};
			} foreach _dummyhouses;
		_allhousecount = (count _houses);
		_ringhousecount = _allhousecount - _oldringshousecount;
		if ((_ringhousecount < _previousringhousecount) and (_myradius > 99)) exitWith {_rads = _myradius; _finalhousecount = _ringhousecount; };
		_oldringshousecount = _oldringshousecount +  _ringhousecount;
		_previousringhousecount = _ringhousecount;
		};
	[_rads, _finalhousecount]
	};
// ===== end functions
{
_pos = locationPosition _x;
_data1 = [_pos, true] call fnc_getcitylimits;
_deltahousecount = _data1 select 1;
_rrad = (_data1 select 0);
// so we have a good marker set for the town.. lets see if moving it a little might help?
_newpos = [];_bestpos = _pos;_besthousecount = _deltahousecount;
_shifts = [/*[0,50],*/[-50,50],[-50,0],[-50,-50],[0,-50],[50,-50],[50,0], [50,50]];
	{
	_newpos = [((_pos select 0) + (_x select 0)), ((_pos select 1) + (_x select 1)), 0];
	_data2 = [_newpos, true] call fnc_getcitylimits;
	_shiftedhousecount = _data2 select 1;
	if (_shiftedhousecount > _besthousecount) then
		{
		_besthousecount = _shiftedhousecount;
		_bestpos = _newpos;
		};
	}foreach _shifts;
if (testmode) then
	{
	_mname2 = format ["smn%1", _foreachindex];
	_mkr2 = createMarker [_mname2, _bestpos];
	_mkr2 setMarkerShape "ELLIPSE";
	_mkr2 setMarkerType "Empty";
	_mkr2 setMarkerSize [_rrad,_rrad];
	_mkr2 setMarkerText (str _rrad);
	_mkr2 setMarkerBrush "Vertical";
	};

// create a game logic at each town position and store variables on it.
if (!(surfaceIsWater _bestpos) or (!((text _x) isEqualTo "Sagonisi"))) then
	{

	_logicgroup = createGroup logiccenter;
	_logic = _logicgroup createUnit ["Logic", _bestpos, [], 0, "NONE"];
	_logic setVariable ["targetname", (text _x)];
	_logic setVariable ["targetradius", _rrad];
	_logic setvariable ["targetstatus", 1];
	_logic setVariable ["targettype", 1];
	_logic setVariable ["targetruincount", (count (_bestpos nearObjects ["Ruins", _rrad]))];
	};
missionsetupprogress = (_foreachindex / _possibleprimariescount);
publicVariable "missionsetupprogress";
_towndata = [text _x,_bestpos,_rrad,1,1,(count (_bestpos nearObjects ["Ruins", _rrad]))];
targetdata pushback _towndata;
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
if (!(surfaceIsWater _bestpos) ) then
	{
	_logic = _logicgroup createUnit ["Logic", getpos _x, [], 0, "NONE"];
	_logic setVariable ["targetname", ("Military base")];
	_logic setVariable ["targetradius", 250];
	_logic setvariable ["targetstatus", 1];
	_logic setVariable ["targettype", 3];
	if (testmode) then
		{
		_mname2 = format ["bmn%1", _foreachindex];
		_mkr2 = createMarker [_mname2, getpos _x];
		_mkr2 setMarkerShape "ELLIPSE";
		_mkr2 setMarkerType "Empty";
		_mkr2 setMarkerSize [250,250];
		_mkr2 setMarkerBrush "Horizontal";
		};
	};
	_basedata = ["Military Base", getpos _x, 250, 1, 3, -1];
	targetdata pushback _basedata;
} foreach _possiblebases;
diag_log format ["possible bases count %1", count _possiblebases];
//find airfields.
foundairfields = [];
_airportlogicgroup = createGroup logiccenter;
_airfieldlocs = nearestLocations [mapcentre ,["NameVillage", "NameLocal", "Airport"], mapsize / 2];
		{
		_llt = tolower (text _x);// lowercase location text
		if  (
			     ((_llt find "airf")  > -1) or
			     ((_llt find "aéro")  > -1) or
			     ((_llt find "airs")  > -1) or
			     ((_llt find "airb")  > -1) or
			     ((_llt find "aerod")  > -1)
		     )  then
			{
			_ptarget = _airportlogicgroup createUnit ["Logic", getpos _x, [], 0, "NONE"];
			_ptarget setVariable ["targetname", text _x];
			_ptarget setVariable ["targetradius", 300];
			_ptarget setvariable ["targetstatus", 1];// enemy held
			_ptarget setVariable ["targettype", 2];// type airfield
			foundairfields pushback _ptarget;
/*		if (testmode) then
			{
			_mname2 = format ["amn%1", _foreachindex];
			_mkr2 = createMarker [_mname2, getpos _x];
			_mkr2 setMarkerShape "ELLIPSE";
			_mkr2 setMarkerType "Empty";
			_mkr2 setMarkerSize [300,300];
			_mkr2 setMarkerBrush "DiagGrid";
			};
*/
			_airfielddata = [text _x, getpos _x,300,1,2,-1];
			targetdata pushBack _airfielddata;
			};
		} foreach _airfieldlocs;
diag_log format ["*** total target count is %1", (count targetdata)];
diag_log format ["*** %1 ends %2,%3, took %4", _myscript, diag_tickTime, time, (time - _starttime)];