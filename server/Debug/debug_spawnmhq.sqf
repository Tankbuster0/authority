_cargo = createvehicle ["CUP_B_Mastiff_HMG_GB_W", (position (_this select 0)), [],0, "NONE"];
//_cargo addEventHandler ["GetIn", {nul = [_this select 0,_this select 1, _this select 2] execVM "server\fobvehicledeploymanager.sqf"}];
_cargo addEventHandler ["GetOut", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetout.sqf"}];
_cargo addEventHandler ["GetIn", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetin.sqf"}];
_cargo addEventHandler ["SeatSwitched", {_nul = [_this select 0, _this select 1, _this select 2] execVM "server\functions\fn_handlefobgetseatchanged.sqf"}];
//solongandthanksforallthefish