//by tankbuster
_myscript = "assembleaircraft";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
params [_containerobject, _mycaller];
hint "Assembling aircraft!";
if (_mycaller in [alpha_9, bravo_9]) then
	{
		sleep 10;
	}
	else
	{
		sleep 20;
	};
_prizeclass = _containerobject getvariable "eventualtype";
_prizepos = getpos _containerobject;
deleteVehicle _containerobject;

_bestvisibility = 0;
_bestdir = 0;
for "_d" from 0 to 315 step 45 do
	{
		_testpos = _prizepos getrelpos [30 , _d];
		_testpos set [2, 1];
		_cansee = [player, "VIEW"] checkVisibility [_prizepos, _testpos];
		if (_cansee > _bestvisibility) then
			{
				_bestvisibility = _cansee;
				_bestdir = _d;
			};
	};
_prizevec = createVehicle [_prizeclass, _prizepos, [],0,"NONE"];
_prizevec setdir _bestdir;

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];