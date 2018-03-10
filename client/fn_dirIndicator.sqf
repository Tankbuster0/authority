
/*
	Author: Karel Moricky and Tankbuster

	Description:
	Direction indicator (similar to one CWC-era military game)

	Parameter(s):
	_this select 0: OBJECT - Center
	_this select 1: OBJECT - Related object

	Returns:
	True
*/
_this spawn {
	disableserialization;
	_center = _this select 0;
	_obj = _this select 1;

	_color = if (count _this > 2) then {_this select 2} else {[0.424,0.651,0.247,1];};
	_size = if (count _this > 3) then {_this select 3} else {0.1045752};
	_fadeIn = 0;
	_fadeOut = 0.8;
	_delay = 0.5;
	_delayFade = _delay;
	indicatorrun = true;

	("bis_fnc_dirIndicator" call bis_fnc_rscLayer) cutrsc ["RscMissionScreen","plain"];
	waituntil {!isnull (uinamespace getvariable "BIS_RscMissionScreen")};
	uinamespace setvariable ["BIS_RscMissionScreen_dirIndicator",uinamespace getvariable "BIS_RscMissionScreen"];


	//--- Definitions
	#define IND_DISPLAY	(uinamespace getvariable "BIS_RscMissionScreen_dirIndicator")
	#define IND_CONTROL	1200

	#define IND_W		(_size)
	#define IND_H		(IND_W * 4/3)
	#define IND_COEF	(1.1)

	#define IND_1	(IND_DISPLAY displayctrl (IND_CONTROL + 1))	//--- Left
	#define IND_2	(IND_DISPLAY displayctrl (IND_CONTROL + 2))	//--- Top
	#define IND_3	(IND_DISPLAY displayctrl (IND_CONTROL + 3))	//--- Right
	#define IND_4	(IND_DISPLAY displayctrl (IND_CONTROL + 4))	//--- Bottom

	//--- Init
	_pos = [
		(safezoneX + safezoneW / 2) - ((IND_W) * IND_COEF)/2,
		(safezoneY + safezoneH) - (IND_H) * IND_COEF,
		IND_W,
		IND_H
	];

	IND_1 ctrlsetposition _pos;
	IND_2 ctrlsetposition _pos;
	IND_3 ctrlsetposition _pos;
	IND_4 ctrlsetposition _pos;

	IND_1 ctrlsettextcolor _color;
	IND_2 ctrlsettextcolor _color;
	IND_3 ctrlsettextcolor _color;
	IND_4 ctrlsettextcolor _color;

	IND_1 ctrlsetfade _fadeOut;
	IND_2 ctrlsetfade _fadeOut;
	IND_3 ctrlsetfade _fadeOut;
	IND_4 ctrlsetfade _fadeOut;

	IND_1 ctrlcommit 0;
	IND_2 ctrlcommit 0;
	IND_3 ctrlcommit 0;
	IND_4 ctrlcommit 0;

	IND_1 ctrlsettext "\A3\ui_f\data\igui\rsctitles\dirindicator\dir_270_ca.paa";
	IND_2 ctrlsettext "\A3\ui_f\data\igui\rsctitles\dirindicator\dir_000_ca.paa";
	IND_3 ctrlsettext "\A3\ui_f\data\igui\rsctitles\dirindicator\dir_090_ca.paa";
	IND_4 ctrlsettext "\A3\ui_f\data\igui\rsctitles\dirindicator\dir_180_ca.paa";

	//--- Display again after load
	_this spawn {scriptName "fn_diIndicator.sqf: Load restart";
		_load = [] spawn {scriptName "fn_diIndicator.sqf: Load detection";
			disableserialization;
			waituntil {false};
		};
		waituntil {scriptdone _load || isnull IND_DISPLAY};
		_this spawn bis_fnc_dirIndicator;
	};

	while {alive _center && !isnull IND_DISPLAY and indicatorrun} do {
		if (visiblemap) then {
			for "_i" from 1 to 4 do {
				(IND_DISPLAY displayctrl (IND_CONTROL + _i)) ctrlsetfade 1;
				(IND_DISPLAY displayctrl (IND_CONTROL + _i)) ctrlcommit _delayFade;
			};

		} else {
			_centerPos = position vehicle _center;
			_objPos = switch (typename _obj) do {
				case (typename {}): {call _obj};
				case (typename ""): {missionnamespace getvariable _obj};
				case (typename objnull): {position vehicle _obj};
				default {_obj}
			};
			_dirTo = if (_centerPos distance _objPos > 0 && _objPos distance [0,0,0] > 0) then {
				_dirTo = (vehicle _center) getRelDir _objPos;
				_dirTo = round (((_dirTo + 180) % 360) / 90);
				if (_dirTo <= 0 || _dirTo >= 4) then {_dirTo = 4;};
				_dirTo
			} else {
				-1
			};

			for "_i" from 1 to 4 do {
				_fadeCurrent = ctrlfade (IND_DISPLAY displayctrl (IND_CONTROL + _i));
				_fade = if (_dirTo == _i && _dirTo >= 0) then {
					if (typename _obj == typename objnull) then {
						//--- When unconsious, blink
						if (lifestate _obj == "UNCONSCIOUS") then {
							if (_fadeCurrent == _fadeIn) then {_fadeOut} else {_fadeIn};
						} else {
							_fadeIn
						};
					} else {
						_fadeIn
					};
				} else {
					_fadeOut
				};
				if (_fadeCurrent != _fade) then {
					(IND_DISPLAY displayctrl (IND_CONTROL + _i)) ctrlsetfade _fade;
					(IND_DISPLAY displayctrl (IND_CONTROL + _i)) ctrlcommit _delayFade;
				};
				if ((_objPos distance2D _centerPos ) < 40) then
					{
						(IND_DISPLAY displayctrl (IND_CONTROL + _i)) ctrlsettextcolor [0.4,0.4,0.6,1];
					} else
					{
						(IND_DISPLAY displayctrl (IND_CONTROL + _i)) ctrlsettextcolor _color;
					};
			};
		};

		sleep _delay;
	};

	IND_1 ctrlsetfade 1;
	IND_2 ctrlsetfade 1;
	IND_3 ctrlsetfade 1;
	IND_4 ctrlsetfade 1;

	IND_1 ctrlcommit 0.5;
	IND_2 ctrlcommit 0.5;
	IND_3 ctrlcommit 0.5;
	IND_4 ctrlcommit 0.5;
};