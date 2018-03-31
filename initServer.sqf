#include "includes.sqf"
authenicatedAdmins = [];
publicVariable "authenicatedAdmins";
initserverfinished = false; publicVariable "initserverfinished";
missionsetupprogress = 0; publicVariable "missionsetupprogress";
sleep 0.5;


// added advanced urban rapelling via serverside addon

// Sethduda's Advanced Towing
_nul = execVM "SA_AdvancedTowing\fn_advancedTowingInit.sqf
// Genesis92x's VCOM AI
[] execVM "VCOMAI\init.sqf";

/*independentcenter = createCenter independent;
civcenter = createCenter civilian;*/
logiccenter = createCenter sideLogic;
blufor setFriend [opfor, 0.1];// blufor enemy to opfpr
opfor setFriend [blufor, 0.1];// opfor enemy to opfor
blufor setFriend [independent, 0.1]; //blufor enemy to indi
independent setFriend [blufor, 0.1]; //indi enemy to blufor
opfor setFriend [independent, 1]; //opfor friendly to indi
independent setFriend [opfor, 1]; //indi freindly to opfor
#include "server\global_variables.sqf";
["Initialize"] call BIS_fnc_dynamicGroups;
mapsize  = getnumber (configfile/"CfgWorlds"/worldName/"mapSize");
mapcentre = [mapsize / 2, mapsize /2, 0];// <-- is a posatl
sleep 0.5;
primarytargetcounter = 1;
previousmission = locationNull;
foundairfields = [];
pdflag = false;
[] spawn //moving markers on forward and fob
	{
	while {true} do
		{
		sleep 1;
		if (not isnull forward) then
			{
			"forwardmarker" setMarkerPos getpos forward;
			if ((alive forward) and (isTouchingGround forward) and (initserverfinished)) then // hide marker if fobveh isnt yet in the game or is in the air (ie, being dropped in)
			    {"forwardmarker" setMarkerAlpha 1}
			    else
			    {"fowardmarker" setMarkerAlpha 0};
			 };
		if (not isnull fobveh) then
			{
			"fobmarker" setMarkerPos getpos fobveh;
			if ((alive fobveh) and (isTouchingGround fobveh) and (initserverfinished)) then // hide marker if fobveh isnt yet in the game or is in the air (ie, being dropped in)
			    {"fobmarker" setMarkerAlpha 1}
			    else
			    {"fobmarker" setMarkerAlpha 0};
		   };
		};
	};
__tky_debug
if ((tolower worldName) in ["altis", "tanoa", "panthera3"]) then
	{
		diag_log "*** mission uses existing targetdata file";
		_airportlogicgroup = createGroup logiccenter;
		_logicgroup = createGroup logiccenter;
		_loadfilename = format ["targetdata\%1.txt", (toLower worldName)];
		altisdata = (loadfile _loadfilename) splitstring "\";
		TESTOUTPUT = [];
		//-------------------------
		// BEWARE THE STRINGPARSER
		//-------------------------
		// I'M SO SORRY TANKY
		{
			// Get First Element and transform it into numbers, Also get rid of first brackets
			_currentN = toArray ([[_x,1] call BIS_fnc_trimString,0,-1] call BIS_fnc_trimString);
			// This will be used to check where we are.
			// 1 is at position
			// 2 is at radius
			// 3 is at landmassid
			// 4 is at status
			// 5 is at type
			// 6 is at ruin count
			_arrayState = 0;
			// Variables for the gameLogic
			_targetName= "";
			_targetLocation = [0,0,0];
			_targetRadius = 0;
			_targetlandmassId = 0;
			_targetStatus = 0;
			_targetType = 0;
			_targetRuinCount = 0;
			// Flag to check when we reached a '"', this means that the name will be coming up until the next '"'
			_isName = false;
			// Flag to check we have reached location bit
			_isLocation = false;
			_locationXF = true;
			_locationYF = false;
			_locationXString = "";
			_locationYString = "";
			_locationX = 0;
			_locationY = 0;
			_locationDone = false;
			// Generic helper flag for the last 4 properties
			_tnF = false;
			_radiusString = "";
			_landmassidstring = "";
			_statusString = "";
			_typeString = "";
			_ruincountString = "";
			{	// Name shite ------------------------------------------------------
				if (_arrayState == 0) then {
					if (_isName && (_x != 34)) then {_targetName = _targetName + (toString [_x]);};
					if ((_x == 34)) then {
						if ((!_isName)) then {
							_isName = true;
						} else {
							_arrayState = 1;
						}; //34 is '"'
					};
				};
				// Location Shite --------------------------------------------------
				if (_arrayState == 1) then {
					if ((_x == 93) && (_isLocation)) then
					{
						_isLocation = false;
						_locationXF = false;
						_locationYF = false;
						_arrayState = 2; // We are now at Radius
					}; //91 is ']'
					if (_isLocation) then {
						if (_x == 44) then {
							if (_locationYF) then // Second "," we now have X and Y and are at Z which is 0 anyway
							{
								_locationXF = false;
								_locationYF = false;
							};
							if (_locationXF) then {
								_locationXF = false;
								_locationYF = true;
							};
						}; // 44 is ","
						if (_locationXF) then {_locationXString = _locationXString + (toString [_x]);};
						if (_locationYF && (_x != 44)) then {_locationYString = _locationYString + (toString [_x]);};
					};
					// Fill in location
					if ((_arrayState == 2) && (!_locationDone)) then {
								_locationX = parseNumber _locationXString;
								_locationY = parseNumber _locationYString;
								_targetLocation = [_locationX, _locationY, 0];
								_locationDone = true;
					};
					if (_x == 91) then {_isLocation = true;}; //91 is '['
				};
				// Radius Shite --------------------------------------------------
				if (_arrayState == 2) then {
					if (_tnF) then {
						_radiusString = _radiusString + (toString [_x]);
					};
					if (_x == 44) then {
						if (!_tnF) then {_tnF = true;}
						else {
							_arrayState = 3;
							_targetRadius = parseNumber _radiusString;
							_tnF = false;
						};
					};
				};
				// Landmass ID Shite --------------------------------------------------
				if (_arrayState == 3) then {
					if (_tnF) then {
						_landmassidstring = _landmassidstring + (toString [_x]);
					};
					if (_x == 44) then {
						if (!_tnF) then {_tnF = true;}
						else {
							_arrayState = 4;
							_targetlandmassId = parseNumber _landmassidstring;
							_tnF = false;
						};
					};
				};
				// Status Shite --------------------------------------------------
				if (_arrayState == 4) then {
					if (_tnF) then {
						_statusString = _statusString + (toString [_x]);
					};
					if (_x == 44) then {
						if (!_tnF) then {_tnF = true;}
						else {
							_arrayState = 5;
							_targetStatus = parseNumber _statusString;
							_tnF = false;
						};
					};
				};
				// Type Shite --------------------------------------------------
				if (_arrayState == 5) then {
					if (_tnF) then {
						_typeString = _typeString + (toString [_x]);
					};
					if (_x == 44) then {
						if (!_tnF) then {_tnF = true;}
						else {
							_arrayState = 6;
							_targetType = parseNumber _typeString;
							_tnF = false;
						};
					};
				};

				// Ruin Shite --------------------------------------------------
				if (_arrayState == 6) then {
					if (_tnF) then {
						_ruincountString = _ruincountString + (toString [_x]);
						_targetRuinCount = parseNumber _ruincountString;
					};
					if (_x == 44) then {
						if (!_tnF) then {_tnF = true;};
					};
				};

			} foreach _currentN;
			_logic = _logicgroup createUnit ["Logic", _targetLocation, [], 0, "NONE"];
			if (_targetType == 2) then {
				_logic = _airportlogicgroup createUnit ["Logic", _targetLocation, [], 0, "NONE"];
			};
			_logic setVariable ["targetname", _targetName];
			_logic setVariable ["targetradius", _targetRadius];
			_logic setVariable ["targetlandmassid", _targetlandmassId];
			_logic setvariable ["targetstatus", _targetStatus];
			_logic setVariable ["targettype", _targetType];
			_logic setVariable ["targetruincount", _targetRuinCount];

			if (_targetType == 2) then {
				foundairfields pushback _logic;
			};

			if (false) then
				{
				_mname2 = format ["smn%1", _foreachindex];
				_mkr2 = createMarker [_mname2, _targetLocation];
				_mkr2 setMarkerShape "ELLIPSE";
				_mkr2 setMarkerType "Empty";
				_mkr2 setMarkerSize [_targetRadius,_targetRadius];
				_mkr2 setMarkerText (str _foreachindex);
				_mkr2 setMarkerBrush "Vertical";
				};

			//TESTOUTPUT pushBack _tempArr;
			missionsetupprogress = 1;
			publicVariable "missionsetupprogress";
		} foreach altisdata;
		//-------------------------
		// REJOICE THE STRINGPARSER
		//-------------------------

	}else
	{
		diag_log "*** mission doesn't find a targetdata file and runs gptl instead";
		_handle1 = [] execVM "server\getprimarytargetlocations.sqf";
		waitUntil {scriptDone _handle1};
	};
__tky_debug
//diag_log "*** initServer done targetdata stuff";
sleep 0.5;
if ((tolower worldName) isEqualTo "tanoa") then
	{
		_ntobjs = nearestTerrainObjects [[5693, 9930], [], 60, false];
		//diag_log format ["marker4 is at %1 and nto is %2", getmarkerpos "marker_4", _ntobjs ];
		{
			if (_x inArea "marker_4") then
				{
				hideObjectGlobal _x;
				//diag_log format ["hiding a %1", _x];
				};
		} foreach _ntobjs;
	};
__tky_debug
if not (false) then
	{
		for "_m" from 1 to 100 do
			{
			_mname =  format ["dep_safezone_marker_%1", _m];
			_thismarkerpos = getMarkerPos _mname;
			if ((_thismarkerpos select 0) isEqualTo 0 ) exitWith {};// no more markers, can quit loop.
			_mname setMarkerAlpha 0; //marker exists and not testmode, so hide markers
			};
	};
__tky_debug
// ^^^^ hide dep safezone markers if not testmode
forward allowDamage false;
_handle2 = [] execVM "server\missionsetup.sqf";
__tky_debug
waitUntil {missionrunning};
sleep 0.5;
__tky_debug
_nul = execVM "server\tky_fobveh_killed_eh.sqf";
_nul = execVM "server\tky_forward_killed_eh.sqf";
__tky_debug
_nul = [] execVM "server\doprimary.sqf";
_nul = [] execVM "server\queuehints.sqf";
preservedvehicles = [];
"gotinvec" addPublicVariableEventHandler {preservedvehicles pushBackUnique gotinvec};
[] spawn
	{
		while {true} do
			{// remove deads
				sleep 5;
				preservedvehicles = preservedvehicles select {alive _x};
			};
	};
Saro_fnc_bomber = compileFinal preProcessFileLineNumbers "server\PT_ai\sssb.sqf";
initserverfinished = true;
publicVariable "initserverfinished";