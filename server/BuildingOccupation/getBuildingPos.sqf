// by Zapat and Tankbuster
//Edited by SPUn
_myscript = "fn_p_buildingPos.sqf";
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
	   then {
	        _i = 0;
	   } else {
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