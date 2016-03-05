private ["_max","_highestpossofar","_y","_cpos","_highobject","_dif"];
 _max = 0;
 _highestpossofar = cpt_position;

 for "_y" from 0 to (20 + (floor random 20)) do
 	{
 	_cpos =  [cpt_position, (cpt_radius + 50), 0, 100] call bis_fnc_findOverwatch;
 	_highobject = createVehicle ["Sign_Arrow_F", _cpos, [],0,"NONE"];
 	_dif = (((getposASL _highobject) select 2) - ((getposASL cpt_flag) select 2));
 	//diag_log format ["pos %1, dif %2", _cpos, _dif];
 	if (_dif > _max) then
 		{
 		_max = _dif;
 		_highestpossofar = _cpos;
 		diag_log format ["new best at %1 with %2 difference", _highestpossofar, _dif];
 		};
 	};
 diag_log format ["best pos %1, dif %2", _highestpossofar, _max];
 _highestpossofar set [2,0];
 alpha_1 setPos _highestpossofar;
 alpha_1 setCaptive true;