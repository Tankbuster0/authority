//by tankbuster
 #include "..\includes.sqf"
_myscript = "do_kill1man";
__tky_starts;
missionactive = true; publicVariable "missionactive";
missionsuccess = false; publicVariable "missionsuccess";
private [];

_kill1types =
	[//[missioncode, [buildings to use, buildings to use], spawninsidehighflag, spawninsidelowflag, spawnoutsideflag, [classnames of mantokill],"unitinit"[texts to use], ["classnames of support units indoors"], ["classnames of support units outdoors"], ["missiontextstrings"]]
		["cgl", ["Land_FuelStation_Build_F", "Land_FuelStation_01_shop_F", "Land_FuelStation_01_workshop_F", "Land_FuelStation_02_workshop_F"], false, true, false ["I_C_Soldier_Bandit_7_F"], ["",""], ["His activities are disturbing the fragile peace. Take him out"] ],
	["htg", ["House_f"]]
	];
/*
missiontextstrings explan
random ["Locals report there is a ", "Freindly forces tell us there's a ", "Mobile phone intercepts show there might be a ", "Our forward forces observed a "]
plus
screenname classname of manktokill
plus
if spawninsideflag then "inside" else "near"
plus
distance
plus
cardinaldirection
plus
of nearesttown.
plus
missiontextstring



*/
submissiondata = selectRandom _kill1types;




smmissionstring = format ["Do some shit at %1 and blah blah etc", _sometown getVariable "targetname"];
smmissionstring remoteexecCall ["tky_fnc_usefirstemptyinhintqueue",2,false];
publicVariable "smmissionstring";

 failtext = "Dudes. You suck texts";
_
while {missionactive} do
	{
	sleep 3;
	if (/*failure conditions*/) then
		{
		missionsuccess = false;
		missionactive = false;
		};

	if (/*succeed conditions*/) then
		{
		missionsuccess = true;
		missionactive = false;
		"Dudes. You rock! Mission successful. Yey." remoteExecCall ["tky_fnc_usefirstemptyinhintqueue", 2, false];
		};
	};
publicVariable "missionsuccess";
publicVariable "missionactive";
[_smcleanup, 60] execVM "server\Functions\fn_smcleanup.sqf";

__tky_ends
