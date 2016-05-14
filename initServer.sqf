_myscript = "initserver.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
initserverfinished = false; publicVariable "initserverfinished";
missionsetupprogress = 0; publicVariable "missionsetupprogress";
sleep 0.5;
opforcenter = createCenter opfor;
independentcenter = createCenter independent;
civcenter = createCenter civilian;
logiccenter = createCenter sideLogic;
blufor setFriend [opfor, 0.1];
opfor setFriend [blufor, 0.1];
#include "server\global_variables.sqf";
["Initialize"] call BIS_fnc_dynamicGroups;
mapsize  = getnumber (configfile/"CfgWorlds"/worldName/"mapSize");
mapcentre = [mapsize / 2, mapsize /2, 0];// <-- is a posatl
sleep 0.5;
primarytargetcounter = 1;
previousmission = locationNull;
foundairfields = [];

// Place support modules
_logicGroup = createGroup sideLogic;
SupportReq = _logicGroup createUnit ["SupportRequester",[0,0,0], [], 0, "FORM"];
ArtySupport = _logicGroup createUnit ["SupportProvider_Artillery", [0,0,0], [], 0, "FORM"];

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
		/*
		if (not isNull dropveh) then
			{
			"dropvehmarker" setmarkerpos getpos dropveh;
			"dropvehmarker" setMarkerAlpha 1;
			}
			else
			{"dropvehmarker" setMarkerAlpha 0};
		*/
		};
	};



if (worldName in ["Altis", "altis"]) then
	{

		_airportlogicgroup = createGroup logiccenter;
		_logicgroup = createGroup logiccenter;

		altisdata = (loadfile "targetdata\altis.txt") splitstring "\";
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
			// 3 is at status
			// 4 is at type
			// 5 is at ruin count
			_arrayState = 0;

			// Variables for the gameLogic
			_targetName= "";
			_targetLocation = [0,0,0];
			_targetRadius = 0;
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
			_statusString = "";
			_typeString = "";
			_ruincountString = "";

			{
				// Name shite ------------------------------------------------------
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

				// Status Shite --------------------------------------------------
				if (_arrayState == 3) then {
					if (_tnF) then {
						_statusString = _statusString + (toString [_x]);
					};
					if (_x == 44) then {
						if (!_tnF) then {_tnF = true;}
						else {
							_arrayState = 4;
							_targetStatus = parseNumber _statusString;
							_tnF = false;
						};
					};
				};

				// Type Shite --------------------------------------------------
				if (_arrayState == 4) then {
					if (_tnF) then {
						_typeString = _typeString + (toString [_x]);
					};
					if (_x == 44) then {
						if (!_tnF) then {_tnF = true;}
						else {
							_arrayState = 5;
							_targetType = parseNumber _typeString;
							_tnF = false;
						};
					};
				};

				// Ruin Shite --------------------------------------------------
				if (_arrayState == 5) then {
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
			_logic setvariable ["targetstatus", _targetStatus];
			_logic setVariable ["targettype", _targetType];
			_logic setVariable ["targetruincount", _targetRuinCount];

			if (_targetType == 2) then {
				foundairfields pushback _logic;
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
		_handle1 = [] execVM "server\getprimarytargetlocations.sqf";
		waitUntil {scriptDone _handle1};
	};

sleep 0.5;
_handle2 = [] execVM "server\missionsetup.sqf";
waitUntil {scriptDone _handle2};
sleep 0.5;
_handle3 = [] execVM "server\doprimary.sqf";
initserverfinished = true;
publicVariable "initserverfinished";
diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];
















