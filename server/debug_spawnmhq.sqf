_cargo = createvehicle ["rhsusf_M1083A1P2_B_M2_d_MHQ_fmtv_usarmy", (position alpha_1), [],0, "NONE"];
_cargo addEventHandler ["GetIn", {nul = [_this select 0,_this select 1, _this select 2] execVM "server\fobvehicledeploymanager.sqf"}];
_cargo addEventHandler ["GetOut", {unassignCurator cur;}];