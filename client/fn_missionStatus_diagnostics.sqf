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

private _bluforAliveMen0 = entities [["SoldierWB"], [], true, true];
private _bluforDeadMen0 = {(!alive _x)} count (entities [["SoldierWB"], [], true, false]);
private _bluforAliveCars = entities [["Car"], [], true, true];
private _bluforAliveTanks = entities [["Tank"], [], true, true];
private _bluforAliveWatercraft = entities [["Ship"], [], true, true];
private _bluforAliveRotorcraft = entities [["Helicopter"], [], true, true];
private _bluforAlivePlanes = entities [["Plane"], [], true, true];
private _bluforAliveAutonomous = entities [["Autonomous"], [], true, true];
private _bluforDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _opforAliveMen0 = entities [["SoldierEB"], [], true, true];
private _opforDeadMen0 = {(!alive _x)} count (entities [["SoldierEB"], [], true, false]);
private _opforAliveCars = entities [["Car"], [], true, true];
private _opforAliveTanks = entities [["Tank"], [], true, true];
private _opforAliveWatercraft = entities [["Ship"], [], true, true];
private _opforAliveRotorcraft = entities [["Helicopter"], [], true, true];
private _opforAlivePlanes = entities [["Plane"], [], true, true];
private _opforAliveAutonomous = entities [["Autonomous"], [], true, true];
private _opforDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _independentAliveMen0 = entities [["SoldierGB"], [], true, true];
private _independentDeadMen0 = {(!alive _x)} count (entities [["SoldierGB"], [], true, false]);
private _independentAliveCars = entities [["Car"], [], true, true];
private _independentAliveTanks = entities [["Tank"], [], true, true];
private _independentAliveWatercraft = entities [["Ship"], [], true, true];
private _independentAliveRotorcraft = entities [["Helicopter"], [], true, true];
private _independentAlivePlanes = entities [["Plane"], [], true, true];
private _independentAliveAutonomous = entities [["Autonomous"], [], true, true];
private _independentDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

private _civilianAliveMen0 = entities [["SoldierCB"], [], true, true];
private _civilianDeadMen0 = {(!alive _x)} count (entities [["SoldierCB"], [], true, false]);
private _civilianAliveCars = entities [["Car"], [], true, true];
private _civilianAliveTanks = entities [["Tank"], [], true, true];
private _civilianAliveWatercraft = entities [["Ship"], [], true, true];
private _civilianAliveRotorcraft = entities [["Helicopter"], [], true, true];
private _civilianAlivePlanes = entities [["Plane"], [], true, true];
private _civilianAliveAutonomous = entities [["Autonomous"], [], true, true];
private _civilianDeadVehicles0 = {(!alive _x)} count (entities [["AllVehicles"], [], true, false]);

{
	hintSilent format ["%1\n%2\n%3", (_x select 0), (_x select 1)];
} forEach
[
	[_bluforAliveMen, _bluforAliveMen0],
	[_opforAliveMen, _opforAliveMen0],
	[_independentAliveMen, _independentAliveMen0],
	[_civilianAliveMen, _civilianAliveMen0],
	[_bluforDeadMen, _bluforDeadMen0],
	[_opforDeadMen, _opforDeadMen0],
	[_independentDeadMen, _indeoendentDeadMen0],
	[_civilianDeadMen, _civilianAliveMen0],
	[_bluforCars, _bluforAliveCars],
	[_opforCars, _opforAliveCars],
	[_independentCars, _independentAliveCars],
	[_civilianCars, _civilianAliveCars],
	[_bluforTanks, _bluforAliveTanks],
	[_opforTanks, _opforAliveTanks],
	[_independentTanks, _independentAliveTanks],
	[_civilianTanks, _civilianAliveTanks],
	[_bluforWatercraft, _bluforAliveWatercraft],
	[_opforWatercraft, _opforAliveWatercraft],
	[_independentWatercraft, _independentAliveWatercraft],
	[_civilianWatercraft, _civilianAliveWatercraft],
	[_bluforHelicopters, _bluforAliveHelicopters],
	[_opforHelicopters, _opforAliveHelicopters],
	[_independentHelicopters, _independentAliveHelicopters],
	[_civilianHelicopters, _civilianAliveHelicopters],
	[_bluforPlanes, _bluforAlivePlanes],
	[_opforPlanes, _opforAlivePlanes],
	[_independentPlanes, _independentAlivePlanes],
	[_civilianPlanes, _civilianAlivePlanes],
	[_bluforAutonomous, _bluforAliveAutonomous],
	[_opforAutonomous, _opforAliveAutonomous],
	[_independentAutonomous, _independentAliveAutonomous],
	[_civilianAutonomous, _civilianAliveAutonomous],
	[_bluforDeadVehicles, _bluforDeadVehicles0],
	[_opforDeadVehicles, _opforDeadVehicles0],
	[_independentDeadVehicles, _independentDeadVehicles0],
	[_civilianDeadVehicles, _civilianDeadVehicles0]
];