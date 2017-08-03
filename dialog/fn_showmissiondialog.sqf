disableSerialization;
diag_log "*** fn_smd runs";
private ["_d_cpt_name","_d_hq_status","_d_radar_status","_d_roadblockdata1","_d_roadblockdata2","_d_roadblockdata3","_d_roadblockfinal","_ctrl"];
_d_roadblockfinal = "";
_d_cpt_name = [missionNamespace, "cpt_name"] call BIS_fnc_getServerVariable;

_d_hq_status = [missionnamespace, "pt_hq_alive", false] call BIS_fnc_getServerVariable;

_d_radar_status = [missionNamespace, "pt_radar_alive", false] call BIS_fnc_getServerVariable;

_d_roadblockdata1 = [missionNamespace, "deadgatecount", -1 ] call BIS_fnc_getServerVariable;
_d_roadblockdata2 = [missionNamespace, "roadblockgates", -1 ] call BIS_fnc_getServerVariable;
_d_roadblockdata3 = [missionNamespace, "roadblockscleared"] call BIS_fnc_getServerVariable;

_d_roadblockfinal = format ["Roadblocks to clear: %1",(_d_roadblockdata2 - _d_roadblockdata1)];// number of gates still to kill

_d_enemystrengthdata = east countSide allunits;

createDialog "dlg_missionStatus";

waitUntil {!isNull (findDisplay 13579);};

_d_hq_status_output = if (_d_hq_status) then {"Yes"} else {"No"};
_d_radar_status_output = if (_d_radar_status) then {"Yes"} else {"No"};


sleep 0;

_ctrl = (findDisplay 13579) displayCtrl 800;
_ctrl ctrlSetStructuredText parseText format ["Primary Target: %1", _d_cpt_name];
_ctrl = (findDisplay 13579) displayCtrl 900;
_ctrl ctrlSetStructuredText parseText format ["Enemy HQ Active: %1", _d_hq_status_output];
_ctrl = (findDisplay 13579) displayCtrl 1000;
_ctrl ctrlSetStructuredText parseText format ["Enemy Radar Active: %1", _d_radar_status_output];
_ctrl = (findDisplay 13579) displayCtrl 1001;
_ctrl ctrlSetStructuredText parseText format ["Roadblocks to Clear", _d_roadblockfinal];
_ctrl = (findDisplay 13579) displayCtrl 1003;
_ctrl ctrlSetStructuredText parseText format ["Enemy Strength: %1", _d_enemystrengthdata];

_ctrl = (findDisplay 13579) displayCtrl 1005;
_ctrl ctrlSetStructuredText parseText format ["%1", smmissionstring];
diag_log "*** fn_smd ends";