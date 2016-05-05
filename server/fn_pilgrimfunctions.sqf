fn_p_relativePos =
{
	private ["_p1", "_dir","_dst","_r","_alt"];
	_p1 = _this select 0;
	_dir = _this select 1;
	_dst = _this select 2;

	_alt = 0;
	if (count _this > 3) then {_alt = _this select 3};

	_r = [(_p1 select 0) + sin _dir * _dst,(_p1 select 1) + cos _dir * _dst,_alt];

	_r
};

fn_p_buildingPos =
{
	/*
	   returns a list of all available building positions

	  Input:
		0: building (object)
		1: optional minheight check
			-1 turns it off
		2: optional inside check
			true or false

	  Return:
		array of positions (or empty array for building without any positions)
	*/

	private ["_building", "_positions", "_i", "_bpos"];

	_building = _this select 0;
	_minHeight = -1;
	if (count _this > 1) then {_minHeight = _this select 1};
	_isCheck = false;
	if (count _this > 2) then {_isCheck= _this select 2};

	_positions = [];

	_i = 1;
	while {_i > 0} do
	{
	   _bpos = _building buildingPos _i;
	   if (((_bpos select 0) isEqualTo 0) && ((_bpos select 1) isEqualTo 0) && ((_bpos select 2) isEqualTo 0))
	   then{_i = 0;}
	   else
	   {
			_clear = true;
			if (_minheight > -1) then
			{
				if ((_bpos select 2) < _minHeight) then {_clear = false};
			};

			if (_isCheck) then
			{
				_bPosCounter = [_bpos select 0, _bpos select 1, (_bpos select 2) + 20];
				_liw = lineIntersectsWith [ATLtoASL _bpos, ATLtoASL _bPosCounter];
				_clear = false;
				if (count _liw > 0 && {(_liw select 0) isKindOf "House"}) then {_clear = true};
			};

			//save bpos
			if (_clear) then {_positions set [(count _positions), _bpos]};
			_i = _i + 1;
	   };
	};

	// return positions
	_positions
};

fn_p_getWindowPos =
{
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
				_counterPosASL = [_samplePosASL, _lookDir, 30, _samplePosASL select 2]call fn_p_relativePos;
				if (!lineIntersects [_samplePosASL,_counterPosASL]) then {_quality = 1};

				//80 meter check: object or terrain
				if (_quality isEqualTo 1) then
				{
					_counterPosASL = [_samplePosASL, _lookDir, 80, _samplePosASL select 2]call fn_p_relativePos;
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
					_counterPosASL = [_samplePosASL, _lookDir, 200, _samplePosASL select 2]call fn_p_relativePos;
					if (!terrainIntersectASL[_samplePosASL, _counterPosASL]) then {_quality = 3};
				};

				_return set [count _return, [_x,_lookDir, _quality]];
			};

		};
	} foreach _roofedPoses;

	_return
};