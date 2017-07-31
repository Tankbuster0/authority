disableSerialization;
diag_log "*** fn_smd runs";
private ["_d_cpt_name","_d_hq_status","_d_radar_status","_d_roadblockdata1","_d_roadblockdata2","_d_roadblockdata3","_d_roadblockfinal","_ctrl"];
_d_roadblockfinal = "";
_d_cpt_name = [missionNamespace, "cpt_name"] call BIS_fnc_getServerVariable;

_d_hq_status = [missionnamespace, "pt_hq_alive"] call BIS_fnc_getServerVariable;

_d_radar_status = [missionNamespace, "pt_radar_alive"] call BIS_fnc_getServerVariable;

_d_roadblockdata1 = [missionNamespace, "deadgatecount", -1 ] call BIS_fnc_getServerVariable;
_d_roadblockdata2 = [missionNamespace, "roadblockgates", -1 ] call BIS_fnc_getServerVariable;
_d_roadblockdata3 = [missionNamespace, "roadblockscleared"] call BIS_fnc_getServerVariable;

_d_roadblockfinal = format ["Roadblocks to clear: %1",(_d_roadblockdata2 - _d_roadblockdata1)];// number of gates still to kill



createDialog "dlg_missionStatus";

waitUntil {!isNull (findDisplay 13579);};



sleep 0;

_ctrl = (findDisplay 13579) displayCtrl 800;
_ctrl ctrlSetStructuredText parseText format ["Primary Target: %1", _d_cpt_name];
_ctrl = (findDisplay 13579) displayCtrl 900;
_ctrl ctrlSetStructuredText parseText format ["Enemy HQ active: %1", _d_hq_status];
_ctrl = (findDisplay 13579) displayCtrl 1000;
_ctrl ctrlSetStructuredText parseText format ["Radio Tower up: %1", _d_radar_status];
_ctrl = (findDisplay 13579) displayCtrl 1001;
_ctrl ctrlSetStructuredText parseText format ["%1", _d_roadblockfinal];
_ctrl = (findDisplay 13579) displayCtrl 1005;
_ctrl ctrlSetStructuredText parseText format ["%1", smmissionstring];
diag_log "*** fn_smd ends";