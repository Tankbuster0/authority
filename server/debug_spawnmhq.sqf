_cargo = createvehicle ["CUP_B_Mastiff_HMG_GB_W", (position (_this select 0)), [],0, "NONE"];
_cargo addEventHandler ["GetIn", {nul = [_this select 0,_this select 1, _this select 2] execVM "server\fobvehicledeploymanager.sqf"}];
_cargo addEventHandler ["GetOut", {unassignCurator cur;}];