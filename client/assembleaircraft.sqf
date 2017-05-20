//by tankbuster
 #include "..\includes.sqf"
_myscript = "assembleaircraft";
__tky_starts;
private ["_mybox","_mycaller","_prizeclass","_prizeclassscreenname","_sleep","_prizepos","_bestvisibility","_bestdir","_d","_testpos","_cansee","_prizevec"];
_mycaller = _this select 0;
_mybox = nearestObject [(getpos _mycaller),"Cargo_base_F"];
_prizeclass = _mybox getvariable "eventualtype";
_prizeclassscreenname = [_prizeclass] call tky_fnc_getscreenname;
_sleep = 15;
if (((typeOf _mycaller) find "ngineer") > -1) then // string "ngineer" is in the classname of the caller, ie, is an engineer
	{
		_sleep = 10;
	};
hint format ["Assembling %1. Please wait %2 seconds.", _prizeclassscreenname, _sleep];
sleep _sleep;
_prizepos = getpos _mybox;
_bestvisibility = 0;
_bestdir = 0;
for "_d" from 0 to 315 step 45 do
	{
		_testpos = _mybox getrelpos [60 , _d];
		_testpos set [2, 1];
		_cansee = [player, "VIEW"] checkVisibility [(ATLToASL _prizepos),(ATLToASL _testpos)];
		if (_cansee > _bestvisibility) then
			{
				_bestvisibility = _cansee;
				_bestdir = _d;
			};
	};
sleep 1;
deletevehicle _mybox;
sleep 1;
_prizevec = createVehicle [_prizeclass, _prizepos, [],0,"NONE"];
_prizevec setdir _bestdir;
if (_prizeclass isEqualTo blufordropaircraft) then
	{
	[_prizevec, "bf"] call fnc_setvehiclename;
	nul = execVM "server\tky_bf_killed.sqf";
	}
	else
	{
	[_prizevec, (format ["prize%1", prizecounter])] call fnc_setvehiclename;
	}

	;
airprizeawaitingassmbly = false;
publicVariable "airprizeawaitingassmbly";

__tky_ends