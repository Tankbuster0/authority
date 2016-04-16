_myscript = "handlefobgetin.sqf";
diag_log format ["*** %1 starts %2,%3", _myscript, diag_tickTime, time];
private ["_veh","_seat","_unit","_reason"];
params [
["_veh", ""],
["_seat", ""],
["_unit", ""]
];
_reason = "";
while {_reason isEqualTo ""} do
	{
	if not ((alive _unit) or (alive _veh))  then {_reason = "dead";};
	if not (_unit in _veh) then {_reason = "dismounted";};
	// unit is in veh, but might not be in drivers seat, so stay in loop
	if (((driver fobveh) isEqualTo _unit) and (not (isengineOn fobveh)) and ((speed _veh) isEqualTo 0)) then {_reason = "good";};
	sleep 0.5;
	};
 if not (_reason  isEqualTo "good") exitWith {};

 fobdeployactionid = fobveh addaction [
	"Deploy FOB",// text on action menu
	 "server\fobvehicledeploymanager.sqf",// executed script
	  "",//optional arguments
	  0, //priority, appears low down the addaction list
	  false, //don't show titletext in middle of screen
	  false, //hide on use
	  "", //shortcut
	  "true" // condition
	  ];
sleep 0.5;
if (fobdeployed) then {fobveh setUserActionText [fobdeployactionid, "Undeploy FOB"];};

diag_log format ["*** %1 ends %2,%3", _myscript, diag_tickTime, time];