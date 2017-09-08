private ["_obs","_cplines","_linenames","_stname","_namewithoutid","__helper","_linea","_linebx","_lineb","_ax","_ay","_bx","_by","_carposx","_carposy","_mycar", "_spawndir"];
_obs = nearestObjects [dude, [], 100, true];
_cplines = [];
_linenames = ["rd_line_5m.p3d", "runway_01_centerline_5m_f.p3d", "decal_white_line_f.p3d"];
{
_stname = str _x;// make it into a string
//diag_log format ["*** object is %1, stringname is %2", _x, _stname ];
_namewithoutid = ((_stname splitstring ": ") select 1);// strip the id number and colon
if (((count _stname) > 12) and {_namewithoutid in _linenames} ) then
	{
	_helper =createVehicle ["Sign_Arrow_F", (getpos _x), [],0, "CAN_COLLIDE"];
	_cplines pushBack _x;
	};
if (((count _stname) > 12) and {_namewithoutid == "rd_taxi.p3d"} ) then
	{
	if ((random 1) > 0.1) then
		{
		_mbus = createvehicle ["C_Van_02_transport_F", getpos _x, [],0, "CAN_COLLIDE" ];
		_mbus setdir ( (getdir _x ) + 90);

		};
	};

} foreach _obs;
{
_linea = _x;
_linebx = _cplines select {(_linea distance2d _x) < 4.3};
if ((count _linebx) > 0) then
	{
	_lineb = _linebx select 0;
	//diag_log format ["*** linea is dir %1 and b is %2 and they are %3 apart", getdir _linea, getdir _lineb, _linea distance2d _lineb];
	if ((_lineb distance2d _linea > 3) and {(floor (getdir _linea)) isEqualTo (floor (getdir _lineb))}) then
		{;
		_carposx = (((getpos _linea) select 0) + ((getpos _lineb) select 0)) /2;
		_carposy = (((getpos _linea) select 1) + ((getpos _lineb) select 1)) /2;
		if ((random 1) > 0.5) then
			{
			_mycar = createvehicle ["C_Hatchback_01_F", [_carposx, _carposy, 2], [],0,"CAN_COLLIDE"];
			if ((random 1) > 0.5 ) then
				{
				_mycar setdir (getdir _linea);
				}
				else
				{
				if ((getdir _linea) < 180) then {_spawndir = 180 + (getdir _linea)} else {_spawndir = 180 - (getdir _linea)};
				_mycar setdir _spawndir;
				};
			sleep 0.2;
			};
		};
	};
} foreach _cplines;