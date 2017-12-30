//By Tankbuster
#include "..\includes.sqf"
_myscript = "fn_followleader";
__tky_starts
private ["_myhostage","_rescuer","_mode","_rescuerinvec","_rescuevec","_cargopositions","_nrplayer"];
/* custom AI for hostages.
1. Allows them to determine who their rescuer is
2. Sets follow mode so they move towards their rescuer
3. Makes them get in their rescuers vehicle if there's cargo space, if not, makes them wait for another dismounted rescuer
4
possible modes are captured, waiting, following, getin, invec and rescued and getout
*/
_myhostage = _this select 0;
_mode = "captured";
diag_log format ["*** fn_fl gets %1", _myhostage];
[
	_myhostage,
	"Free Hostage",
	"\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa",
	"(_this distance2D _target) < 3",
	"(_caller distance2D _target) < 3",
	{},
	{},
   	{
	    [(_this select 0), ""] remoteExec ["switchMove", 0, false];
		(_this select 0) enableAI "ALL";
		[_this select 0, "safe"] remoteExec ["setBehaviour", 2, false];
		(_this select 0) setUnitPos "UP";
	},
    {},
    [],
    5,
    0,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd",[0,-2] select isDedicated,true];
sleep 1;
waitUntil {sleep 1; ((behaviour _myhostage) == "safe")};
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
	sleep 2;
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
	if ((_myhostage inArea "headmarker1") and {isNull objectParent _myhostage}) then
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
				_rescuer = objNull;
				doStop _myhostage;
				//if (_myhostage)
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
			};
		case "rescued":
			{
				[_myhostage, "Acts_CivilIdle_1"] remoteExec ["switchMove", 0, false];
				_myhostage disableAI "MOVE";
				_rescuerinvec = false;
				_rescuer = objNull;
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
			};
	};
	if (testmode) then
	{
		diag_log format ["*** %1 is mode %2 and assigned to %5. Rescuer is %3 who is in the  %4 vehicle, %5 ", _myhostage, _mode,name _rescuer, _rescuevec, _rescuerinvec, assignedVehicle _myhostage];
	};
};
__tky_ends