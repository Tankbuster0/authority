scriptName "fn_playerMarkers";

/*
	Code written by Haz
*/

#define __FILENAME "fn_playerMarkers.sqf"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

private _scale = ctrlMapScale (_this select 0) < 0.070;

{
	if ((effectiveCommander (vehicle _x) == _x)) then
	{
		private _vehicle = vehicle _x;
		private _iconType = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "icon");
		private _iconColour = [(side _x), false] call BIS_fnc_sideColor;
		private _iconPosition = getPos _x;
		private _iconWidth = 24;
		private _iconHeight = 24;
		private _iconDirection = getDir _x;
		private _iconText = if ((_vehicle == _x)) then
		{
			name _x
		} else
		{
			private _first = call
			{
				if ((alive driver _vehicle)) exitWith
				{
					driver _vehicle;
				};
				if ((isCopilotEnabled _vehicle) && (alive (_vehicle turretUnit [0]))) exitWith
				{
					_vehicle turretUnit [0];
				};
				effectiveCommander _vehicle;
			};
			private _array = [_first];
			private _rest = (crew _vehicle - _array) select {alive _x};
			if ((_scale)) then
			{
				_array append _rest;
			};
			{
				_array set [_forEachIndex, (name _x)];
			} forEach _array;
			format ["[%1] %2%3", getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName"), _array joinString ", ", (if ((!_scale) && (count _rest > 0)) then {format [" (+%1)", count _rest]} else {""})];
		};
		private _iconShadow = 1;
		private _iconSize = 0.04;
		private _iconFont = "PuristaMedium";
		private _iconAlignment = "right";
		if ((!isNull _x) && (!isNull player)) then
		{
			(_this select 0) drawIcon
			[
				_iconType,
				_iconColour,
				_iconPosition,
				_iconWidth,
				_iconHeight,
				_iconDirection,
				_iconText,
				_iconShadow,
				_iconSize,
				_iconFont,
				_iconAlignment
			];
		};
	};
} forEach allPlayers - (entities "HeadlessClient_F");