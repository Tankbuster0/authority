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
private _bluforAliveCars = _display displayCtrl idc_bluforAliveCars;
private _opforAliveCars = _display displayCtrl idc_opforAliveCars;
private _independentAliveCars = _display displayCtrl idc_independentAliveCars;
private _civilianAliveCars = _display displayCtrl idc_civilianAliveCars;
private _bluforAliveTanks = _display displayCtrl idc_bluforAliveTanks;
private _opforAliveTanks = _display displayCtrl idc_opforAliveTanks;
private _independentAliveTanks = _display displayCtrl idc_independentAliveTanks;
private _civilianAliveTanks = _display displayCtrl idc_civilianAliveTanks;
private _bluforAliveHelicopters = _display displayCtrl idc_bluforAliveHelicopters;
private _opforAliveHelicopters = _display displayCtrl idc_opforAliveHelicopters;
private _independentAliveHelicopters = _display displayCtrl idc_independentAliveHelicopters;
private _civilianAliveHelicopters = _display displayCtrl idc_civilianAliveHelicopters;
private _bluforAlivePlanes = _display displayCtrl idc_bluforAlivePlanes;
private _opforAlivePlanes = _display displayCtrl idc_opforAlivePlanes;
private _independentAlivePlanes = _display displayCtrl idc_independentAlivePlanes;
private _civilianAlivePlanes = _display displayCtrl idc_civilianAlivePlanes;
private _bluforAliveWatercraft = _display displayCtrl idc_bluforAliveWatercraft;
private _opforAliveWatercraft = _display displayCtrl idc_opforAliveWatercraft;
private _independentAliveWatercraft = _display displayCtrl idc_independentAliveWatercraft;
private _civilianAliveWatercraft = _display displayCtrl idc_civilianAliveWatercraft;
private _bluforAliveAutonomous = _display displayCtrl idc_bluforAliveAutonomous;
private _opforAliveAutonomous = _display displayCtrl idc_opforAliveAutonomous;
private _independentAliveAutonomous = _display displayCtrl idc_independentAliveAutonomous;
private _civilianAliveAutonomous = _display displayCtrl idc_civilianAliveAutonomous;
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
private _bluforAliveCars0 = count (entities [["Car"], [], true, true]);
private _bluforAliveTanks0 = count (entities [["Tank"], [], true, true]);
private _bluforAliveWatercraft0 = count (entities [["Ship"], [], true, true]);
private _bluforAliveHelicopters0 = count (entities [["Helicopter"], [], true, true]);
private _bluforAlivePlanes0 = count (entities [["Plane"], [], true, true]);
private _bluforAliveAutonomous0 = count (entities [["Autonomous"], [], true, true]);
private _bluforDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _opforAliveMen0 = count (entities [["SoldierEB"], [], true, true]);
private _opforDeadMen0 = {(!alive _x)} count (entities [["SoldierEB"], [], true, false]);
private _opforAliveCars0 = count (entities [["Car"], [], true, true]);
private _opforAliveTanks0 = count (entities [["Tank"], [], true, true]);
private _opforAliveWatercraft0 = count (entities [["Ship"], [], true, true]);
private _opforAliveHelicopters0 = count (entities [["Helicopter"], [], true, true]);
private _opforAlivePlanes0 = count (entities [["Plane"], [], true, true]);
private _opforAliveAutonomous0 = count (entities [["Autonomous"], [], true, true]);
private _opforDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _independentAliveMen0 = count (entities [["SoldierGB"], [], true, true]);
private _independentDeadMen0 = {(!alive _x)} count (entities [["SoldierGB"], [], true, false]);
private _independentAliveCars0 = count (entities [["Car"], [], true, true]);
private _independentAliveTanks0 = count (entities [["Tank"], [], true, true]);
private _independentAliveWatercraft0 = count (entities [["Ship"], [], true, true]);
private _independentAliveHelicopters0 = count (entities [["Helicopter"], [], true, true]);
private _independentAlivePlanes0 = count (entities [["Plane"], [], true, true]);
private _independentAliveAutonomous0 = count (entities [["Autonomous"], [], true, true]);
private _independentDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _civilianAliveMen0 = count (entities [["SoldierCB"], [], true, true]);
private _civilianDeadMen0 = {(!alive _x)} count (entities [["SoldierCB"], [], true, false]);
private _civilianAliveCars0 = count (entities [["Car"], [], true, true]);
private _civilianAliveTanks0 = count (entities [["Tank"], [], true, true]);
private _civilianAliveWatercraft0 = count (entities [["Ship"], [], true, true]);
private _civilianAliveHelicopters0 = count (entities [["Helicopter"], [], true, true]);
private _civilianAlivePlanes0 = count (entities [["Plane"], [], true, true]);
private _civilianAliveAutonomous0 = count (entities [["Autonomous"], [], true, true]);
private _civilianDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

_bluforAliveMen ctrlSetText format ["%1", _bluforAliveMen0];
_bluforAliveMen ctrlSetTooltip "Number of alive BLUFOR men";
_bluforAliveMen ctrlCommit 0;

_bluforDeadMen ctrlSetText format ["%1", _bluforDeadMen0];
_bluforDeadMen ctrlSetTooltip "Number of dead BLUFOR men";
_bluforDeadMen ctrlCommit 0;

_bluforAliveCars ctrlSetText format ["%1", _bluforAliveCars0];
_bluforAliveCars ctrlSetTooltip "Number of alive BLUFOR cars";
_bluforAliveCars ctrlCommit 0;

_bluforAliveTanks ctrlSetText format ["%1", _bluforAliveTanks0];
_bluforAliveTanks ctrlSetTooltip "Number of alive BLUFOR tanks";
_bluforAliveTanks ctrlCommit 0;

_bluforAliveHelicopters ctrlSetText format ["%1", _bluforAliveWatercraft0];
_bluforAliveHelicopters ctrlSetTooltip "Number of alive BLUFOR helicopters";
_bluforAliveHelicopters ctrlCommit 0;

_bluforAlivePlanes ctrlSetText format ["%1", _bluforAliveHelicopters0];
_bluforAlivePlanes ctrlSetTooltip "Number of alive BLUFOR planes";
_bluforAlivePlanes ctrlCommit 0;

_bluforAliveWatercraft ctrlSetText format ["%1", _bluforAliveWatercraft0];
_bluforAliveWatercraft ctrlSetTooltip "Number of alive BLUFOR watercraft";
_bluforAliveWatercraft ctrlCommit 0;

_bluforAliveAutonomous ctrlSetText format ["%1", _bluforAliveAutonomous0];
_bluforAliveAutonomous ctrlSetTooltip "Number of alive BLUFOR UTVs and UAVs";
_bluforAliveAutonomous ctrlCommit 0;

_bluforDeadVehicles ctrlSetText format ["%1", _bluforDeadVehicles0];
_bluforDeadVehicles ctrlSetTooltip "Number of dead BLUFOR vehicles";
_bluforDeadVehicles ctrlCommit 0;

_opforAliveMen ctrlSetText format ["%1", _opforAliveMen0];
_opforAliveMen ctrlSetTooltip "Number of alive OPFOR men";
_opforAliveMen ctrlCommit 0;

_opforDeadMen ctrlSetText format ["%1", _opforDeadMen0];
_opforDeadMen ctrlSetTooltip "Number of dead OPFOR men";
_opforDeadMen ctrlCommit 0;

_opforAliveCars ctrlSetText format ["%1", _opforAliveCars0];
_opforAliveCars ctrlSetTooltip "Number of alive OPFOR cars";
_opforAliveCars ctrlCommit 0;

_opforAliveTanks ctrlSetText format ["%1", _opforAliveTanks0];
_opforAliveTanks ctrlSetTooltip "Number of alive OPFOR tanks";
_opforAliveTanks ctrlCommit 0;

_opforAliveHelicopters ctrlSetText format ["%1", _opforAliveWatercraft0];
_opforAliveHelicopters ctrlSetTooltip "Number of alive OPFOR helicopters";
_opforAliveHelicopters ctrlCommit 0;

_opforAlivePlanes ctrlSetText format ["%1", _opforAliveHelicopters0];
_opforAlivePlanes ctrlSetTooltip "Number of alive OPFOR planes";
_opforAlivePlanes ctrlCommit 0;

_opforAliveWatercraft ctrlSetText format ["%1", _opforAlivePlanes0];
_opforAliveWatercraft ctrlSetTooltip "Number of alive OPFOR watercraft";
_opforAliveWatercraft ctrlCommit 0;

_opforAliveAutonomous ctrlSetText format ["%1", _opforAliveAutonomous0];
_opforAliveAutonomous ctrlSetTooltip "Number of alive OPFOR UTVs and UAVs";
_opforAliveAutonomous ctrlCommit 0;

_opforDeadVehicles ctrlSetText format ["%1", _opforDeadVehicles0];
_opforDeadVehicles ctrlSetTooltip "Number of dead OPFOR vehicles";
_opforDeadVehicles ctrlCommit 0;

_independentAliveMen ctrlSetText format ["%1", _independentAliveMen0];
_independentAliveMen ctrlSetTooltip "Number of alive INDEPENDENT men";
_independentAliveMen ctrlCommit 0;

_independentDeadMen ctrlSetText format ["%1", _independentDeadMen0];
_independentDeadMen ctrlSetTooltip "Number of dead INDEPENDENT men";
_independentDeadMen ctrlCommit 0;

_independentAliveCars ctrlSetText format ["%1", _independentAliveCars0];
_independentAliveCars ctrlSetTooltip "Number of alive INDEPENDENT cars";
_independentAliveCars ctrlCommit 0;

_independentAliveTanks ctrlSetText format ["%1", _independentAliveTanks0];
_independentAliveTanks ctrlSetTooltip "Number of alive INDEPENDENT tanks";
_independentAliveTanks ctrlCommit 0;

_independentAliveHelicopters ctrlSetText format ["%1", _independentAliveWatercraft0];
_independentAliveHelicopters ctrlSetTooltip "Number of alive INDEPENDENT helicopters";
_independentAliveHelicopters ctrlCommit 0;

_independentAlivePlanes ctrlSetText format ["%1", _independentAliveHelicopters0];
_independentAlivePlanes ctrlSetTooltip "Number of alive INDEPENDENT planes";
_independentAlivePlanes ctrlCommit 0;

_independentAliveWatercraft ctrlSetText format ["%1", _independentAlivePlanes0];
_independentAliveWatercraft ctrlSetTooltip "Number of alive INDEPENDENT watercraft";
_independentAliveWatercraft ctrlCommit 0;

_independentAliveAutonomous ctrlSetText format ["%1", _independentAliveAutonomous0];
_independentAliveAutonomous ctrlSetTooltip "Number of alive INDEPENDENT UTVs and UAVs";
_independentAliveAutonomous ctrlCommit 0;

_independentDeadVehicles ctrlSetText format ["%1", _independentDeadVehicles0];
_independentDeadVehicles ctrlSetTooltip "Number of alive INDEPENDENT men";
_independentDeadVehicles ctrlCommit 0;

_civilianAliveMen ctrlSetText format ["%1", _civilianAliveMen0];
_civilianAliveMen ctrlSetTooltip "Number of alive CIVILIAN men";
_civilianAliveMen ctrlCommit 0;

_civilianDeadMen ctrlSetText format ["%1", _civilianAliveMen0];
_civilianDeadMen ctrlSetTooltip "Number of dead CIVILIAN men";
_civilianDeadMen ctrlCommit 0;

_civilianAliveCars ctrlSetText format ["%1", _civilianAliveCars0];
_civilianAliveCars ctrlSetTooltip "Number of alive CIVILIAN men";
_civilianAliveCars ctrlCommit 0;

_civilianAliveTanks ctrlSetText format ["%1", _civilianAliveTanks0];
_civilianAliveTanks ctrlSetTooltip "Number of alive CIVILIAN men";
_civilianAliveTanks ctrlCommit 0;

_civilianAliveHelicopters ctrlSetText format ["%1", _civilianAliveHelicopters0];
_civilianAliveHelicopters ctrlSetTooltip "Number of alive CIVILIAN men";
_civilianAliveHelicopters ctrlCommit 0;

_civilianAlivePlanes ctrlSetText format ["%1", _civilianAlivePlanes0];
_civilianAlivePlanes ctrlSetTooltip "Number of alive CIVILIAN men";
_civilianAlivePlanes ctrlCommit 0;

_civilianAliveWatercraft ctrlSetText format ["%1", _civilianAliveWatercraft0];
_civilianAliveWatercraft ctrlSetTooltip "Number of alive CIVILIAN men";
_civilianAliveWatercraft ctrlCommit 0;

_civilianAliveAutonomous ctrlSetText format ["%1", _civilianAliveAutonomous0];
_civilianAliveAutonomous ctrlSetTooltip "Number of alive CIVILIAN UTVs and UAVs";
_civilianAliveAutonomous ctrlCommit 0;

_civilianDeadVehicles ctrlSetText format ["%1", _civilianDeadVehicles0];
_civilianDeadVehicles ctrlSetTooltip "Number of dead CIVILIAN vehicles";
_civilianDeadVehicles ctrlCommit 0;