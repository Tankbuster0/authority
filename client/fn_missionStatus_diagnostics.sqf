scriptName "fn_missionStatus_diagnostics";

/*
	Code written by Haz
*/

#define __FILENAME "fn_missionStatus_diagnostics.sqf"

#include "..\dlg_missionStatus_diagnostics_IDCs.hpp"

if ((isDedicated) || (!hasInterface)) exitWith {};

disableSerialization;

_display = uiNamespace getVariable "disp_missionStatus_diagnostics";

private _bluforAliveMen = _display displayCtrl idc_bluforAliveMen;
private _opforAliveMen = _display displayCtrl idc_opforAliveMen;
private _independentAliveMen = _display displayCtrl idc_independentAliveMen;
private _civilianAliveMen = _display displayCtrl idc_civilianAliveMen;
private _bluforDeadMen = _display displayCtrl idc_bluforDeadMen;
private _opforDeadMen = _display displayCtrl idc_opforDeadMen;
private _independentDeadMen = _display displayCtrl idc_independentDeadMen;
private _civilianDeadMen = _display displayCtrl idc_civilianDeadMen;
private _bluforCars = _display displayCtrl idc_bluforCars;
private _opforCars = _display displayCtrl idc_opforCars;
private _independentCars = _display displayCtrl idc_independentCars;
private _civilianCars = _display displayCtrl idc_civilianCars;
private _bluforTanks = _display displayCtrl idc_bluforTanks;
private _opforTanks = _display displayCtrl idc_opforTanks;
private _independentTanks = _display displayCtrl idc_independentTanks;
private _civilianTanks = _display displayCtrl idc_civilianTanks;
private _bluforHelicopters = _display displayCtrl idc_bluforHelicopters;
private _opforHelicopters = _display displayCtrl idc_opforHelicopters;
private _independentHelicopters = _display displayCtrl idc_independentHelicopters;
private _civilianHelicopters = _display displayCtrl idc_civilianHelicopters;
private _bluforPlanes = _display displayCtrl idc_bluforPlanes;
private _opforPlanes = _display displayCtrl idc_opforPlanes;
private _independentPlanes = _display displayCtrl idc_independentPlanes;
private _civilianPlanes = _display displayCtrl idc_civilianPlanes;
private _bluforWatercraft = _display displayCtrl idc_bluforWatercraft;
private _opforWatercraft = _display displayCtrl idc_opforWatercraft;
private _independentWatercraft = _display displayCtrl idc_independentWatercraft;
private _civilianWatercraft = _display displayCtrl idc_civilianWatercraft;
private _bluforAutonomous = _display displayCtrl idc_bluforAutonomous;
private _opforAutonomous = _display displayCtrl idc_opforAutonomous;
private _independentAutonomous = _display displayCtrl idc_independentAutonomous;
private _civilianAutonomous = _display displayCtrl idc_civilianAutonomous;
private _bluforDeadVehicles = _display displayCtrl idc_bluforDeadVehicles;
private _opforDeadVehicles = _display displayCtrl idc_opforDeadVehicles;
private _independentDeadVehicles = _display displayCtrl idc_independentDeadVehicles;
private _civilianDeadVehicles = _display displayCtrl idc_civilianDeadVehicles;
private _nameShort = _display displayCtrl idc_nameShort;
private _versionNumber = _display displayCtrl idc_versionNumber;
private _buildNumber = _display displayCtrl idc_buildNumber;
private _branch = _display displayCtrl idc_branch;
private _platform = _display displayCtrl idc_platform;
private _OS = _display displayCtrl idc_OS;
private _missionTime = _display displayCtrl idc_missionTime;
private _serverTime = _display displayCtrl idc_serverTime;
private _serverFPS = _display displayCtrl idc_serverFPS;

private _bluforAliveMen0 = count (entities [["SoldierWB"], [], true, true]);
private _bluforDeadMen0 = {(!alive _x)} count (entities [["SoldierWB"], [], true, false]);
private _bluforAliveCars = count (entities [["Car"], [], true, true]);
private _bluforAliveTanks = count (entities [["Tank"], [], true, true]);
private _bluforAliveWatercraft = count (entities [["Ship"], [], true, true]);
private _bluforAliveHelicopters = count (entities [["Helicopter"], [], true, true]);
private _bluforAlivePlanes = count (entities [["Plane"], [], true, true]);
private _bluforAliveAutonomous = count (entities [["Autonomous"], [], true, true]);
private _bluforDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _opforAliveMen0 = count (entities [["SoldierEB"], [], true, true]);
private _opforDeadMen0 = {(!alive _x)} count (entities [["SoldierEB"], [], true, false]);
private _opforAliveCars = count (entities [["Car"], [], true, true]);
private _opforAliveTanks = count (entities [["Tank"], [], true, true]);
private _opforAliveWatercraft = count (entities [["Ship"], [], true, true]);
private _opforAliveHelicopters = count (entities [["Helicopter"], [], true, true]);
private _opforAlivePlanes = count (entities [["Plane"], [], true, true]);
private _opforAliveAutonomous = count (entities [["Autonomous"], [], true, true]);
private _opforDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _independentAliveMen0 = count (entities [["SoldierGB"], [], true, true]);
private _independentDeadMen0 = {(!alive _x)} count (entities [["SoldierGB"], [], true, false]);
private _independentAliveCars = count (entities [["Car"], [], true, true]);
private _independentAliveTanks = count (entities [["Tank"], [], true, true]);
private _independentAliveWatercraft = count (entities [["Ship"], [], true, true]);
private _independentAliveHelicopters = count (entities [["Helicopter"], [], true, true]);
private _independentAlivePlanes = count (entities [["Plane"], [], true, true]);
private _independentAliveAutonomous = count (entities [["Autonomous"], [], true, true]);
private _independentDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _civilianAliveMen0 = count (entities [["SoldierCB"], [], true, true]);
private _civilianDeadMen0 = {(!alive _x)} count (entities [["SoldierCB"], [], true, false]);
private _civilianAliveCars = count (entities [["Car"], [], true, true]);
private _civilianAliveTanks = count (entities [["Tank"], [], true, true]);
private _civilianAliveWatercraft = count (entities [["Ship"], [], true, true]);
private _civilianAliveHelicopters = count (entities [["Helicopter"], [], true, true]);
private _civilianAlivePlanes = count (entities [["Plane"], [], true, true]);
private _civilianAliveAutonomous = count (entities [["Autonomous"], [], true, true]);
private _civilianDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

_bluforAliveMen ctrlSetText format ["%1", _bluforAliveMen0];
_bluforAliveMen ctrlCommit 0;

_bluforDeadMen ctrlSetText format ["%1", _bluforDeadMen0];
_bluforDeadMen ctrlCommit 0;

_bluforCars ctrlSetText format ["%1", _bluforAliveCars];
_bluforCars ctrlCommit 0;

_bluforTanks ctrlSetText format ["%1", _bluforAliveTanks];
_bluforTanks ctrlCommit 0;

_bluforWatercraft ctrlSetText format ["%1", _bluforAliveWatercraft];
_bluforWatercraft ctrlCommit 0;

_bluforHelicopters ctrlSetText format ["%1", _bluforAliveHelicopters];
_bluforHelicopters ctrlCommit 0;

_bluforPlanes ctrlSetText format ["%1", _bluforAlivePlanes];
_bluforPlanes ctrlCommit 0;

_bluforAutonomous ctrlSetText format ["%1", _bluforAliveAutonomous];
_bluforAutonomous ctrlCommit 0;

_bluforDeadVehicles ctrlSetText format ["%1", _bluforDeadVehicles0];
_bluforDeadVehicles ctrlCommit 0;

_opforAliveMen ctrlSetText format ["%1", _opforAliveMen0];
_opforAliveMen ctrlCommit 0;

_opforDeadMen ctrlSetText format ["%1", _opforDeadMen0];
_opforDeadMen ctrlCommit 0;

_opforCars ctrlSetText format ["%1", _opforAliveCars];
_opforCars ctrlCommit 0;

_opforTanks ctrlSetText format ["%1", _opforAliveTanks];
_opforTanks ctrlCommit 0;

_opforWatercraft ctrlSetText format ["%1", _opforAliveWatercraft];
_opforWatercraft ctrlCommit 0;

_opforHelicopters ctrlSetText format ["%1", _opforAliveHelicopters];
_opforHelicopters ctrlCommit 0;

_opforPlanes ctrlSetText format ["%1", _opforAlivePlanes];
_opforPlanes ctrlCommit 0;

_opforAutonomous ctrlSetText format ["%1", _opforAliveAutonomous];
_opforAutonomous ctrlCommit 0;

_opforDeadVehicles ctrlSetText format ["%1", _opforDeadVehicles0];
_opforDeadVehicles ctrlCommit 0;

_independentAliveMen ctrlSetText format ["%1", _independentAliveMen0];
_independentAliveMen ctrlCommit 0;

_independentDeadMen ctrlSetText format ["%1", _indeoendentDeadMen0];
_independentDeadMen ctrlCommit 0;

_independentCars ctrlSetText format ["%1", _independentAliveCars];
_independentCars ctrlCommit 0;

_independentTanks ctrlSetText format ["%1", _independentAliveTanks];
_independentTanks ctrlCommit 0;

_independentWatercraft ctrlSetText format ["%1", _independentAliveWatercraft];
_independentWatercraft ctrlCommit 0;

_civilianWatercraft ctrlSetText format ["%1", _civilianAliveWatercraft];
_civilianWatercraft ctrlCommit 0;

_independentHelicopters ctrlSetText format ["%1", _independentAliveHelicopters];
_independentHelicopters ctrlCommit 0;

_independentPlanes ctrlSetText format ["%1", _independentAlivePlanes];
_independentPlanes ctrlCommit 0;

_independentAutonomous ctrlSetText format ["%1", _independentAliveAutonomous];
_independentAutonomous ctrlCommit 0;

_independentDeadVehicles ctrlSetText format ["%1", _independentDeadVehicles0];
_independentDeadVehicles ctrlCommit 0;

_civilianAliveMen ctrlSetText format ["%1", _civilianAliveMen0];
_civilianAliveMen ctrlCommit 0;

_civilianDeadMen ctrlSetText format ["%1", _civilianAliveMen0];
_civilianDeadMen ctrlCommit 0;

_civilianCars ctrlSetText format ["%1", _civilianAliveCars];
_civilianCars ctrlCommit 0;

_civilianTanks ctrlSetText format ["%1", _civilianAliveTanks];
_civilianTanks ctrlCommit 0;

_civilianHelicopters ctrlSetText format ["%1", _civilianAliveHelicopters];
_civilianHelicopters ctrlCommit 0;

_civilianPlanes ctrlSetText format ["%1", _civilianAlivePlanes];
_civilianPlanes ctrlCommit 0;

_civilianAutonomous ctrlSetText format ["%1", _civilianAliveAutonomous];
_civilianAutonomous ctrlCommit 0;

_civilianDeadVehicles ctrlSetText format ["%1", _civilianDeadVehicles0];
_civilianDeadVehicles ctrlCommit 0;