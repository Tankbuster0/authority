//by tankbuster
_myscript = "assembleaircraft";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_containerobject","_mycaller","_prizeclass","_prizeclassscreenname","_sleep","_prizepos","_bestvisibility","_bestdir","_d","_testpos","_cansee","_prizevec"];
_mycaller = _this select 0;
_prizeclass = prizebox getvariable "eventualtype";
_prizeclassscreenname = [_prizeclass] call tky_fnc_getscreenname;
_sleep = 15;
if (((typeOf _mycaller) find "ngineer") > -1) then // string "ngineer" is in the classname of the caller, ie, is an engineer
	{
		_sleep = 10;
	};
hint format ["Assembling %1. Please wait %2 seconds.", _prizeclassscreenname, _sleep];
sleep _sleep;
_prizepos = getpos prizebox;
_bestvisibility = 0;
_bestdir = 0;
for "_d" from 0 to 315 step 45 do
	{
		_testpos = prizebox getrelpos [30 , _d];
		_testpos set [2, 1];
		_cansee = [player, "VIEW"] checkVisibility [_prizepos, _testpos];
		if (_cansee > _bestvisibility) then
			{
				_bestvisibility = _cansee;
				_bestdir = _d;
			};
	};
sleep 1;
deletevehicle prizebox;
sleep 1;
_prizevec = createVehicle [_prizeclass, _prizepos, [],0,"NONE"];
_prizevec setdir _bestdir;
airprizeawaitingassmbly = false;
publicVariable "airprizeawaitingassmbly";

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];