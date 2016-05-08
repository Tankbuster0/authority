//By Alex
//Will make unit surrender and drop weapons.
//Some units drop more weapons than others.
//Sometimes a unit is  a rebel
// Params:	Unit - 0
//			Rebel - 1

//DEBUG PROFILING
_fnc_dump = {
	player globalchat str _this;
	diag_log str _this;
	//copytoclipboard str _this;
};
//////////////////////////////////


private ["_unit","_rebel","_movePos","_nw"];
_unit = param [0];
_rebel = param [1,false];
_movePos = param [2];

[_unit] remoteExec ["tky_fnc_addAceInterToCaptive", 0, true];

//TODO Local fix later
//_takeCaptive = ['alex_takecaptive','Take Captive','',{[_this select 0,true] call ACE_captives_fnc_setSurrendered; },{ if (((_this select 0) getVariable ["ace_captives_isHandcuffed", false] isEqualTo false) && ((_this select 0) getVariable ["ace_captives_isSurrendering", false] isEqualTo false)) then {true;} else {false;};}] call ace_interact_menu_fnc_createAction;
//[_unit, 0, ["ACE_MainActions"], _takeCaptive] call ace_interact_menu_fnc_addActionToObject;
//-------------------

// Drop Weapons on ground
_holder = createVehicle ["GroundWeaponHolder", position _unit, [], 0, "CAN_COLLIDE"];

//Mrkr debug
_m = createMarker [FORMAT["db_mw%1",_holder], position _holder];
_m setMarkerShape "ICON";
_m setMarkerType "hd_dot";

_holder addItemCargo ["ItemWatch",1];
{_unit removeMagazine _x} forEach magazines _unit;

_willingness = selectRandom [0,1,2];

_unit action ["DropWeapon", _holder, primaryWeapon _unit ];
sleep 2;
if (_willingness > 0 && !(secondaryWeapon _unit isequalto "")) then
{
	_unit action ["DropWeapon", _holder, secondaryWeapon _unit ];
};
sleep 2;
if (_willingness > 1 && !(handgunWeapon _unit isequalto "")) then		
{
	_unit action ["DropWeapon", _holder, handgunWeapon _unit ];
};
sleep 2;

// Make em stand up and ungroup, Also remove all weapons to be sure.
_unit setUnitPos "UP";
[_unit] joinSilent grpNull;

// Make em act relaxed.
_unit call ACE_weaponselect_fnc_putWeaponAway;
_unit setCaptive true;
_unit setSpeedMode  "LIMITED";
group _unit setBehaviour "CARELESS";
group _unit setCombatMode "BLUE";
_unit setUnitPos "UP";

// Move to trigger center.
sleep 1;
_gopos = [_movePos, 5 + random 5, random 360] call BIS_fnc_relPos;
_unit doMove _gopos;
//[_unit,true] call ACE_captives_fnc_setSurrendered;

_unit addEventHandler ["FiredNear", "if (_this select 2 < 7) then {[_this select 0,true] call ACE_captives_fnc_setSurrendered;} else {};"];
_unit addEventHandler ["Hit", "[_this select 0,true] call ACE_captives_fnc_setSurrendered;"];

if (!_rebel) then 
{
	_unit disableAI "TARGET";
	_unit disableAI "AUTOTARGET";
	//while {_unit distance _movePos > 15} do {sleep 2;};
	//[_unit,true] call ACE_captives_fnc_setSurrendered;
} 
else 
{
	_t = random [20, 60, 90];
	sleep _t;
	
	_unit setCaptive false;
	[_unit,false] call ACE_captives_fnc_setSurrendered;
	_unit removeAllEventHandlers "Hit";
	_unit removeAllEventHandlers "FiredNear";
	
	if ( primaryWeapon _unit isequalto "" || handgunWeapon _unit isequalto "" ) then 
	{
		// Unit has no weapons on him.
		_nw = nearestObject [_unit, "GroundWeaponHolder"];
		if (_nw isEqualTo objNull) then
		{
			_unit addMagazines ["HandGrenade",3];
			
		} else 
		{
			_unit setSpeedMode  "FULL";
			_unit doMove (position _nw);
			_unit setSpeedMode  "FULL";
		
			while {_unit distance _nw > 1} do {};
			_unit action ["TakeWeapon", _nw, weaponCargo _nw select 0];
			
		};
		
		_unit setUnitPos "AUTO";
		group _unit setBehaviour "COMBAT";
		group _unit setCombatMode "RED";
		
	} else 
	{
		//Unit has weapons, ready to fire.
		_unit setUnitPos "AUTO";
		group _unit setBehaviour "COMBAT";
		group _unit setCombatMode "RED";
	};
	
	
};
