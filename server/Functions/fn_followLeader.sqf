//By Tankbuster
#include "..\includes.sqf"
_myscript = "fn_followleader";
__tky_starts
private ["_myhostage","_rescuer","_mode","_rescuerinvec","_rescuevec","_cargopositions","_nrplayer", "_mytext", "_dirindicatoron"];
/* custom AI for hostages. possible modes are captured, waiting, following, getin, invec and rescued and getout*/
_myhostage = _this select 0;
_mytext = _this select 1;
_destinationisbase = _this select 2;
_mode = "captured";
_dirindicatoron = false;
[
	_myhostage,
	_mytext,
	"\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa",
	"(_this distance2D _target) < 3",
	"(_caller distance2D _target) < 3",
	{},
	{},
   	{
	    [(_this select 0), ""] remoteExec ["switchMove", 0, false];
		(_this select 0) enableAI "ALL";
		[_this select 0, "careless"] remoteExec ["setBehaviour", 0, false];
		(_this select 0) setUnitPos "AUTO";
		(_this select 0) setCaptive false;
	},
    {},
    [],
    5,
    0,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
sleep 5;
waitUntil {sleep 1; (((behaviour _myhostage) == "careless") or  (not (captive _myhostage)))};
_rescuer = (_myhostage nearEntities ["SoldierWB", 4]) select 0;
_myhostage enableAI "ALL";
_myhostage doMove (getPosATL _rescuer);
_mode = "following";
_rescuerinvec = false;
_rescuevec = objNull;
_cargopositions = 0;
_myhostage allowFleeing 0;
while {missionactive} do
{
	if (_mode isequalto "following") then
		{sleep 4;} else {sleep 2;};
	//set waiting criteria. set after a failed getin, or after rescuer dies or quits
	if ((not alive _rescuer) or ((_myhostage distance2D _rescuer) > 100) ) then
		{// rescuer dies or runs away (or drives away)
			_mode = "waiting";
		};
	// following? set if hostage is waiting and a dismounted player is nearby
	_nrplayer = (_myhostage nearEntities ["SoldierWB", 3]) select 0;
	if ( (not (isNil "_nrplayer")) and {(_mode isEqualTo "waiting") and (isPlayer _nrplayer) and (isNull objectParent _nrplayer)} ) then
		{// theres a dismounted player near a dismounted waiting hostage
			_mode = "following";
			_rescuer = _nrplayer;
		};
	if ((not (_rescuerinvec)) and {not (isNull objectParent _rescuer)}) then
		{//rescuer just got in vehicle
			_mode = "getin";
		};
	if (not (isNull objectParent _myhostage)) then
		{// is actually in vec
			_mode = "invec";
		};
	if (_destinationisbase and {(_myhostage inArea "headmarker1") and (isNull objectParent _myhostage)}) then
		{// safely at base and out of vehicle
			_mode = "rescued";
		};
	if ((_rescuerinvec) and {isnull objectParent _rescuer}) then
		{//rescuer has just dismounted
			_mode = "getout";
		};
	////////////////////////////////////action selected mode////////////////////////////////////////////////
	switch (_mode) do
	{
		case "following":
			{
				_myhostage domove getpos _rescuer;
				_rescuerinvec = false;
			};
		case "waiting":
			{
				indicatorrun = false;
				publicVariable "indicatorrun";
				_rescuer = objNull;
				doStop _myhostage;
			};
		case "getin":
			{
				_rescuevec = vehicle _rescuer;
				_cargopositions = getNumber (configFile >> "CfgVehicles" >> typeOf _rescuevec >> "transportSoldier");
				_rescuerinvec = true;
				_myhostage assignAsCargo _rescuevec;
				sleep 0.1;
				if (not (isNull assignedVehicle _myhostage)) then
					{// there is space in vehicle, tell hom to get in
						[_myhostage] orderGetIn true;
					}
					else
					{// no space in vec, tell him to wait
						_mode = "waiting";
						_rescuer = objNull;
						doStop _myhostage;
					};
			};
		case "invec":
			{
				if (not (_rescuer in _rescuevec)) then
				{
					_mode = "getout";
				};
				if (not (_dirindicatoron)) then
					{
						indicatorrun = true;
						publicVariable "indicatorrun";
						sleep 0.1;
						[_rescuevec, vipdest ]remoteExecCall ["tky_fnc_dirIndicator", _rescuer, true];
						_dirindicatoron = true;
					};
			};
		case "rescued":
			{
				_rescuerinvec = false;
				_rescuer = objNull;
				_myhostage domove (getpos blubasewhiteboard);
				sleep 3;
				[_myhostage, "Acts_CivilIdle_1"] remoteExec ["switchMove", 0, false];
				_myhostage disableAI "MOVE";
			};
		case "getout":
			{
				unassignVehicle _myhostage;
				[_myhostage] orderGetIn false;
				doStop _myhostage;
				_rescuer = objNull;
				_rescuerinvec = false;
				_rescuevec = objNull;
				_mode = "waiting";
				indicatorrun = false;
				publicVariable "indicatorrun";
			};
	};
	if (testmode) then
	{
		diag_log format ["*** %1 is mode %2  Rescuer is %3 who is %5 in the  %4 vehicle, %5 ", _myhostage, _mode,name _rescuer, _rescuevec, _rescuerinvec, assignedVehicle _myhostage];
	};
};
__tky_ends