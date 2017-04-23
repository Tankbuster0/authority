//by tankbuster
 #include "..\includes.sqf"
_myscript = "tky_aireinforcementchopper";
__tky_starts;
pt_radar setdamage 1;
params[
	["_landingpos", cpt_position],// send a helipad object for accurate landing on it, else send a position
	["_helitype", selectRandom opfor_reinf_helos],// supply a classname or one will be chosen
	["_cargocount", 99]// number of soldiers in cargo

	];
diag_log format ["***tarc gets landingpos %1, helitype %2 and cargocount %3."];
_startpos = cpt_position getPos [(4000 + random 3000), (random 360)];

_vecdata = [_startpos, (_startpos getdir cpt_position), _helitype, EAST] call BIS_fnc_spawnVehicle;

_helicargogroup = creategroup [east, true];
for "_n" from 1 to ((getNumber (configFile >> "CfgVehicles" >> _helitype >> "transportSoldier")) min _cargocount) do
	{
		_dude = _helicargogroup createUnit [(selectRandom opfor_heli_cargomen), _startpos, [],0, "NONE"];
		[_dude, true, true] call tky_fnc_tc_setskill;
		_dude moveInCargo (_vecdata select 0);
	};
diag_log format ["***tarc says giving domove."];
(leader (_vecdata select 2)) doMove (if (typename _landingpos isEqualTo "OBJECT") then {getpos _landingpos} else {_landingpos});

while {((_vecdata select 0) distance2D _landingpos) > 40} do {sleep 3};
diag_log format ["***tarc says chopper arrived."];
 doStop (_vecdata select 0);
diag_log format ["***tarc says chopper stopped"];
if (typeName _landingpos isEqualTo "OBJECT") then {(_vec select 0) landAt _landingpos_} else {(_vec select 0) land "LAND"};
diag_log format ["***tarc says chopper told to land."];
_helicargogroup leaveVehicle (_vecdata select 0);
diag_log format ["***tarc says cargo told to leave choppe."];



__tky_ends