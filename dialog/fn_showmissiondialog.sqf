disableSerialization;
diag_log "*** fn_smd runs";
_d_cpt_name = [missionNamespace, "cpt_name"] call BIS_fnc_getServerVariable;

_d_hq_status = [missionnamespace, "pt_hq_alive"] call BIS_fnc_getServerVariable;
createDialog "dlg_missionStatus";

waitUntil {!isNull (findDisplay 13579);};

//_cpt_name = missionNamespace getVariable "cpt_name";

sleep 0;
//ctrlSetText [800, (format ["Primary Target: %1.", _cpt_name ])];
_ctrl = (findDisplay 13579) displayCtrl 800;
_ctrl ctrlSetStructuredText parseText format ["Primary Target: %1", _d_cpt_name];
_ctrl = (findDisplay 13579) displayCtrl 900;
_ctrl ctrlSetStructuredText parseText format ["Enemy HQ active: %1", _d_hq_status];

diag_log "*** fn_smd ends";