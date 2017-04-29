//by tankbuster
 #include "..\includes.sqf"
_myscript = "tky_aireinforcementchopper";
__tky_starts;
private ["_startpos","_vecdata","_rpilotgroup","_heliseats","_cspots","_helicargogroup","_n","_dude", "_checkstalledpos", "_rheli"];
params[
	["_landingpos", cpt_position],// send a helipad object for accurate landing on it, else send a position
	["_helitype", selectRandom opfor_reinf_helos],// supply a classname or one will be chosen
	["_cargocount", 99]// number of soldiers in cargo


	];
diag_log format ["***tarc gets landingpos %1, helitype %2 and cargocount %3.", _landingpos, _helitype, _cargocount];
_startpos = cpt_position getPos [(4000 + random 3000), (random 360)];

_vecdata = [_startpos, (_startpos getdir cpt_position), _helitype, EAST] call BIS_fnc_spawnVehicle;
_rheli = _vecdata select 0; // aircraft itself
_rpilotgroup = _vecdata select 2; //<--- pilot/copilot/ gunner group
_heliseats = (getNumber (configFile >> "CfgVehicles" >> _helitype >> "transportSoldier"));
_cspots = _heliseats min _cargocount;
_helicargogroup = creategroup [east, true];
for "_n" from 1 to _cspots do
	{
		_dude = _helicargogroup createUnit [(selectRandom opfor_heli_cargomen), _startpos, [],0, "NONE"];
		[_dude, true, true] call tky_fnc_tc_setskill;
		_dude moveInCargo (_rheli);
	};
[_rheli, _landingpos] spawn
	{
		params ["_s_rheli", "_s_landingpos"];
		private "_checkstalledpos";
		while {alive _s_rheli} do
		{
		sleep 5;
		if (((speed _s_rheli) < 10) and ((_s_rheli distance2D _s_landingpos) > 100)) then //if its stopped well away from target
			{
			diag_log format ["***tarc suspects a stalled _rheli at %1 ( %2 from target) and will check again in 20 secs",  getpos _s_rheli, (_s_rheli distance2D _s_landingpos)];
			_checkstalledpos = getpos _s_rheli;
			sleep 10;
			if 	(((speed _s_rheli) < 10) and ((_s_rheli distance2D _checkstalledpos) < 100)) then //if it's STILL stopped near where we last saw it
				{
				diag_log format ["*** tarc is now sure rehli has stalled and is killing it. It's %1 from where we last saw it or if it's close, give it another land command", _s_rheli distance2d _checkstalledpos];
				if ((_s_rheli distance2D _s_landingpos) < 10) then
					{
					diag_log "*** tarc says heli is stalled but close to pos so giving it another land command";
					_s_rheli land "LAND";
					}
					else
					{
					{_s_rheli deleteVehicleCrew _x} forEach crew _s_rheli;
					_s_rheli setdamage 1;
					};
				}
				else
				{
				diag_log format  ["*** tarc says _rheli is now UNSTALLED and is at speed %1 and %1 from landing pos and %3 from where we last saw it", speed _s_rheli, _s_rheli distance2D _s_landingpos, _s_rheli distance2D _checkstalledpos];
				};
			};
		};
	};
pt_radar setdamage 1;// remove after testing
diag_log format ["***tarc says giving domove."];
(leader (_rpilotgroup)) doMove (if (typename _landingpos isEqualTo "OBJECT") then {getpos _landingpos} else {_landingpos});

while {((_rheli) distance2D _landingpos) > 100} do {sleep 1};
diag_log format ["***tarc says chopper arrived."];
doStop (_rheli);
diag_log format ["***tarc says chopper stopped"];
if (typeName _landingpos isEqualTo "OBJECT") then {(_rheli) landAt _landingpos} else {(_rheli) land "LAND"};
diag_log format ["***tarc says chopper told to land."];
//waitUntil {sleep 0.5; ((getpos _rheli select 2) < 5)};
_helicargogroup leaveVehicle (_rheli);
(_rheli animateDoor ['Door_4_source', 1]);
(_rheli animateDoor ['Door_5_source', 1]);
(_rheli animateDoor ['Door_6_source', 1]);

diag_log format ["***tarc says cargo told to leave chopper."];
{if !(alive _x) then {deleteVehicle _x}} foreach (crew  _rheli); // delete any deads
diag_log "*** tacr waiting while cargo crew disembark";
waitUntil {sleep 0.5; (_rheli emptyPositions "cargo") isEqualTo _cspots};
sleep 1;
(_rheli animateDoor ['Door_4_source', 0]);
(_rheli animateDoor ['Door_5_source', 0]);
(_rheli animateDoor ['Door_6_source', 0]);
diag_log "*** tacr sending heli back to startpos";
[_helicargogroup, getpos forward] call BIS_fnc_taskattack;
(leader (_rpilotgroup)) doMove _startpos;

waitUntil {sleep 3; (_rheli distance2d _startpos) < 100};
diag_log "*** tacr deleting heli and pilot group";
{_rheli deleteVehicleCrew _x} forEach crew _rheli;
deleteVehicle _rheli;


__tky_ends