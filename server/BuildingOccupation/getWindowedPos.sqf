// by Zapat and Tankbuster
//Edited by SPUn
 #include "..\includes.sqf"
_myscript = "fn_p_getWindowPos.sqf";
/*
		function returns the window positions of a house

		Input:
			0: house object

		Return:
			[[0,1,2],[0,1,2],...]

			0: position
			1: lookout direction
			2: quality of lookout
						0 = object within 30 meters
						1 = object or terrain within 80 meters
						2 = terrain within 200 meters
						3 = unobscured for more than 200 meters
	*/

	private ["_house","_return","_chkdst","_houseDir","_roofedPoses","_samplePosASL","_counterPosASL","_rayDir","_counterPosAboveASL","_isWindow","_liw","_lookDir","_quality"];

	_house = _this select 0;
	_return = [];
	_chkdst = 5;

	_houseDir = getDir _house;
	if (isNil("fn_p_buildingPos")) then {fn_p_buildingPos = compile preprocessFile "Server\BuildingOccupation\getBuildingPos.sqf";};
	//if (isNil("fn_p_relativePos")) then {fn_p_buildingPos = compile preprocessFile "BuildingOccupation\relativePos.sqf";};
	_roofedPoses = [];
	_roofedPoses = [_house,-1,true] call fn_p_buildingPos;

	if (count _roofedPoses isEqualTo 0) exitWith {[]};

	{
		_samplePosASL = ATLtoASL[_x select 0, _x select 1, (_x select 2) + 1.5];

		for "_rayDir" from _houseDir to (_houseDir + 270) step 90 do
		{

			_counterPosASL =  [(_samplePosASL select 0) + sin _rayDir * _chkdst,(_samplePosASL select 1) + cos _rayDir * _chkdst,_samplePosASL select 2];
			_counterPosAboveASL = [_counterPosASL select 0, _counterPosASL select 1, (_counterPosASL select 2) + 30];

			_isWindow = true;
			//counterpos mustn't be under roof
			_liw = lineIntersectsWith [_counterPosAboveASL, _counterPosASL];
			if (count _liw > 0 &&{(_liw select 0) isKindOf "House"}) then {_isWindow = false};

			//counterpos must have free los
			if(_isWindow) then
			{
				_liw = lineIntersectsWith [_samplePosASL, _counterPosASL];
				if (count _liw > 0 &&{(_liw select 0) isKindOf "House"}) then {_isWindow = false};
			};

			if (_isWindow) then
			{
				_lookDir = ([_samplePosASL,_counterPosASL] call BIS_fnc_dirTo);
				_quality = 0;

				//30 meter check: any object
				//_counterPosASL = [_samplePosASL, _lookDir, 30, _samplePosASL select 2]call fn_p_relativePos;
				_counterPosASL = [_samplePosASL, 30, _lookDir] call BIS_fnc_relPos;
				if (!lineIntersects [_samplePosASL,_counterPosASL]) then {_quality = 1};

				//80 meter check: object or terrain
				if (_quality isEqualTo 1) then
				{
					//_counterPosASL = [_samplePosASL, _lookDir, 80, _samplePosASL select 2]call fn_p_relativePos;
					_counterPosASL = [_samplePosASL, 80, _lookDir] call BIS_fnc_relPos;
					if (!lineIntersects [_samplePosASL,_counterPosASL] && {!terrainIntersectASL[_samplePosASL, _counterPosASL]} ) then {_quality = 2};
					/*_liw = lineIntersectsWith [_samplePosASL, _counterPosASL];
					if
					(
						( count _liw isEqualTo 0 || { count _liw > 0 && !((_liw select 0) isKindOf "House") } ) &&
						{!terrainIntersectASL[_samplePosASL, _counterPosASL]}
					) then {_quality = 2};*/
				};

				//200 meter check: terrain
				if (_quality isEqualTo 2) then
				{
					//_counterPosASL = [_samplePosASL, _lookDir, 200, _samplePosASL select 2]call fn_p_relativePos;
					_counterPosASL = [_samplePosASL, 200, _lookDir] call BIS_fnc_relPos;
					if (!terrainIntersectASL[_samplePosASL, _counterPosASL]) then {_quality = 3};
				};

				_return set [count _return, [_x,_lookDir, _quality]];
			};

		};
	} foreach _roofedPoses;

	_return