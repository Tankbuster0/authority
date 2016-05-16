//[] execVM "intro.sqf";

if (isDedicated) exitWith {};
waituntil {alive player};
if ((score player) > 5 ) exitWith {};
//playsound "intro_music";

if (hasInterface) then {
cutText ["AUTHORITY", "BLACK IN", 10];
if ((score player) > 2) exitWith {};
if (!isNil "_camera_run") exitWith {};
_camera_run = true;

introended = false; publicVariable "introended";
loopdone = false; publicVariable "loopdone";
while {!loopdone} do {if ((introended) and (!loopdone)) then {loopdone = true; publicVariable "loopdone";};

//_firstshot = [cam1, cam2, target1, 20, 0.3, 0.1, false, 0, 0, 0] execVM "camera_work.sqf";
//waitUntil {scriptdone _firstshot};
cutText ["A small group of international Special Forces have been deployed to the island of Altis to investigate and remove hostile forces and return the island back to it's people.", "PLAIN DOWN", 25];
_secondshot = [cam3, cam3, target2, 10, 0.5, 0.5, false, 0, 0, 0] execVM "camera_work.sqf";
waitUntil {scriptdone _secondshot};

_thirdshot = [cam4, cam4, target3, 5, 1, 1, true, 0, 1, 3] execVM "camera_work.sqf";
waitUntil {scriptdone _thirdshot};
cutText ["AUTHORITY", "PLAIN", 10];
_fourthshot = [cam5, cam6, target5, 10, 1, 1, false, 3, -6, 0] execVM "camera_work.sqf";
waitUntil {scriptdone _fourthshot};
cutText ["By Tankbuster and WASP", "PLAIN", 10];
_fifthshot = [cam6, cam7, target6, 8, 1, 0.01, false, 7, 1, 6] execVM "camera_work.sqf";
waitUntil {scriptdone _fifthshot};

introended = true; publicVariable "introended";

sleep 0.05;
};

cutText ["Good Luck!", "BLACK IN", 3];
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [100];
"dynamicBlur" ppEffectCommit 0;
"dynamicBlur" ppEffectAdjust [0.0];
"dynamicBlur" ppEffectCommit 4;
};