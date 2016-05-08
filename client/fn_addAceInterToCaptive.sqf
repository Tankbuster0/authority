//By Alex
//Add interaction to take a person captive (i.e. make him surrender).

private "_unit";
_unit = param [0];

_takeCaptive = ['alex_takecaptive','Take Captive','',{[_this select 0,true] remoteExec ["ACE_captives_fnc_setSurrendered", 0, true];},{ if (((_this select 0) getVariable ["ace_captives_isHandcuffed", false] isEqualTo false) && ((_this select 0) getVariable ["ace_captives_isSurrendering", false] isEqualTo false)) then {true;} else {false;};}] call ace_interact_menu_fnc_createAction;
[_unit, 0, ["ACE_MainActions"], _takeCaptive] call ace_interact_menu_fnc_addActionToObject;